//
//  QFTarArchive.h
//  WebViewCacheTest
//
//  Created by qixf on 15/11/9.
//  Copyright © 2015年 SOSGPS. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface QFTarArchive : NSObject

+ (NSData *)findFileWithName:(NSString *)fileName fileHandle:(NSFileHandle *)fileHandle size:(unsigned long long)size;

@end
