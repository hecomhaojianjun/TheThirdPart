//
//  Message.h
//  Kale
//
//  Created by Administrator on 13-6-28.
//  Copyright (c) 2013年 郝 建军. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MessageUI/MessageUI.h>

@interface Message : NSObject <MFMessageComposeViewControllerDelegate>

@property (nonatomic, weak) UIViewController * resourceViewController;

- (void)sendSmS:(NSString *)testStr andRecipients:(NSArray *)recipients;

@end
