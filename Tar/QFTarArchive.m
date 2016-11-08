//
//  QFTarArchive.m
//  WebViewCacheTest
//
//  Created by qixf on 15/11/9.
//  Copyright © 2015年 SOSGPS. All rights reserved.
//

#import "QFTarArchive.h"

static int TAR_BLOCK_SIZE               = 512;
static int TAR_TYPE_POSITION            = 156;
static int TAR_NAME_POSITION            = 0;
static int TAR_NAME_SIZE                = 100;
static int TAR_SIZE_POSITION            = 124;
static int TAR_SIZE_SIZE                = 12;

@implementation QFTarArchive

+ (NSData *)findFileWithName:(NSString *)fileName fileHandle:(NSFileHandle *)fileHandle size:(unsigned long long)size{
    unsigned long long location = 0;
    while (location < size) {
        unsigned long long blockCount = 1; // 1 block for the header
        
        int type = [QFTarArchive typeForObject:fileHandle atOffset:location];
        switch (type) {
            case '0': // It's a File
            {
                // 获取文件名
                NSString *name = [QFTarArchive nameForObject:fileHandle atOffset:location];
                unsigned long long length = [QFTarArchive sizeForObject:fileHandle atOffset:location];
                if (length > 0) {
                    blockCount += (length - 1) / TAR_BLOCK_SIZE + 1;
                    if ([name isEqualToString:fileName]){
                        // 找到该文件，返回文件流
                        unsigned long long curLocation = (location + TAR_BLOCK_SIZE);
                        [fileHandle seekToFileOffset:curLocation];
                        return [fileHandle readDataOfLength:length];
                    }
                }
                break;
            }
                
            case '5': // It's a directory
                break;
                
            case '\0': // It's a nul block
                break;
                
            case 'x': // It's an other header block
            {
                blockCount++; //skip extended header block
                break;
            }
                
            case '1':
            case '2':
            case '3':
            case '4':
            case '6':
            case '7':
            case 'g': // It's not a file neither a directory
            {
                unsigned long long size = [QFTarArchive sizeForObject:fileHandle atOffset:location];
                blockCount += ceil(size / TAR_BLOCK_SIZE);
                break;
            }
                
            default: // It's not a tar type
                return nil;
        }
        
        location += blockCount * TAR_BLOCK_SIZE;
    }
    return nil;
}

#pragma mark 辅助方法（源自网络开源库）

+ (char)typeForObject:(id)object atOffset:(unsigned long long)offset{
    char type;
    memcpy(&type, [self dataForObject:object inRange:NSMakeRange(offset + TAR_TYPE_POSITION, 1) orLocation:offset + TAR_TYPE_POSITION andLength:1].bytes, 1);
    return type;
}

+ (NSString *)nameForObject:(id)object atOffset:(unsigned long long)offset{
    char nameBytes[TAR_NAME_SIZE + 1];
    
    memset(&nameBytes, '\0', TAR_NAME_SIZE + 1);
    memcpy(&nameBytes, [self dataForObject:object inRange:NSMakeRange(offset + TAR_NAME_POSITION, TAR_NAME_SIZE) orLocation:offset + TAR_NAME_POSITION andLength:TAR_NAME_SIZE].bytes, TAR_NAME_SIZE);
    return [NSString stringWithCString:nameBytes encoding:NSASCIIStringEncoding];
}

+ (unsigned long long)sizeForObject:(id)object atOffset:(unsigned long long)offset{
    char sizeBytes[TAR_SIZE_SIZE + 1];
    memset(&sizeBytes, '\0', TAR_SIZE_SIZE + 1);
    memcpy(&sizeBytes, [self dataForObject:object inRange:NSMakeRange(offset + TAR_SIZE_POSITION, TAR_SIZE_SIZE) orLocation:offset + TAR_SIZE_POSITION andLength:TAR_SIZE_SIZE].bytes, TAR_SIZE_SIZE);
    return strtol(sizeBytes, NULL, 8);
}

+ (NSData *)dataForObject:(id)object inRange:(NSRange)range orLocation:(unsigned long long)location andLength:(unsigned long long)length{
    if ([object isKindOfClass:[NSData class]]) {
        return [object subdataWithRange:range];
    } else if ([object isKindOfClass:[NSFileHandle class]]) {
        [object seekToFileOffset:location];
        return [object readDataOfLength:length];
    }
    return nil;
}

@end
