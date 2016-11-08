//
//  Mail.h
//  Kale
//
//  Created by Administrator on 13-6-28.
//  Copyright (c) 2013年 郝 建军. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MessageUI/MessageUI.h>
@interface Mail : NSObject <MFMailComposeViewControllerDelegate>

@property (nonatomic, retain) NSString * words;
@property (nonatomic, retain) UIImage * sendImg;
@property (nonatomic, retain) NSString * subject;
@property (nonatomic, retain) NSString * recrive;
@property (nonatomic, weak) UIViewController * resourceViewController;

//点击按钮后，触发这个方法
-(void)sendEMail;
//可以发送邮件的话
-(void)displayComposerSheet;
-(void)launchMailAppOnDevice;
@end
