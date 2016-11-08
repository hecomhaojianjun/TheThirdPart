//
//  ParseXML.h
//  Test
//
//  Created by zhangzhao on 11-7-5.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ParseXML : NSObject <NSXMLParserDelegate>{
	NSMutableArray *dictionaryStack;
    NSMutableString *textInProgress;
}
+ (NSDictionary *)dictionaryForXMLData:(NSData *)data error:(NSError **)errorPointer;
+ (NSDictionary *)dictionaryForXMLString:(NSString *)string error:(NSError **)errorPointer;

@end
