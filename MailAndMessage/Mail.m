//
//  Mail.m
//  Kale
//
//  Created by Administrator on 13-6-28.
//  Copyright (c) 2013年 郝 建军. All rights reserved.
//

#import "Mail.h"
@implementation Mail
@synthesize words;
@synthesize sendImg;
@synthesize subject;
//点击完send后  成功失败都弹框显示：
- (void) alertWithTitle: (NSString *)_title_ msg: (NSString *)msg
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:_title_
                                                    message:msg
                                                   delegate:nil
                                          cancelButtonTitle:@"确定"
                                          otherButtonTitles:nil];
    [alert show];
}
//点击Mail按钮后，触发这个方法
-(void)sendEMail
{
    Class mailClass = (NSClassFromString(@"MFMailComposeViewController"));
    
    if (mailClass != nil)
    {
        if ([mailClass canSendMail])
        {
            [self displayComposerSheet];
        }
        else
        {
            [self launchMailAppOnDevice];
        }
    }
    else
    {
        [self launchMailAppOnDevice];
    }
}
//可以发送邮件的话
-(void)displayComposerSheet
{
    MFMailComposeViewController *mailPicker = [[MFMailComposeViewController alloc] init];
    
    mailPicker.mailComposeDelegate = self;
    
    //设置主题
    if(!subject)subject = @"";
    [mailPicker setSubject:subject];
    
    // 添加发送者
    NSArray *toRecipients = [NSArray arrayWithObject: self.recrive];
    NSArray *ccRecipients = [NSArray arrayWithObjects:@"", @"", nil];
    //NSArray *bccRecipients = [NSArray arrayWithObject:@"fourth@example.com", nil];
    [mailPicker setToRecipients: toRecipients];
    [mailPicker setCcRecipients:ccRecipients];
    
    // 添加图片
//    NSData *imageData = UIImagePNGRepresentation(self.sendImg);            // png
//    [mailPicker addAttachmentData: imageData mimeType: @"" fileName: @""];

    NSString *emailBody = @"";
    if(words&&![words isEqualToString:@""]){
        emailBody = words;
    }
    [mailPicker setMessageBody:emailBody isHTML:YES];
    [self.resourceViewController presentViewController:mailPicker animated:YES completion:^{
        
    }];
}
-(void)launchMailAppOnDevice
{
    NSString *recipients = @"mailto:first@example.com&subject=my email!";
    //@"mailto:first@example.com?cc=second@example.com,third@example.com&subject=my email!";
    NSString *body = @"&body=email body!";
    
    NSString *email = [NSString stringWithFormat:@"%@%@", recipients, body];
    email = [email stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
    
    [[UIApplication sharedApplication] openURL: [NSURL URLWithString:email]];
}
- (void)mailComposeController:(MFMailComposeViewController *)controller
          didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
//    NSString *msg;
    
//    switch (result)
//    {
//        case MFMailComposeResultCancelled:
//            msg = @"邮件发送取消";
//            break;
//        case MFMailComposeResultSaved:
//            msg = @"邮件保存成功";
//            [self alertWithTitle:nil msg:msg];
//            break;
//        case MFMailComposeResultSent:
//            msg = @"邮件发送成功";
//            [self alertWithTitle:nil msg:msg];
//            break;
//        case MFMailComposeResultFailed:
//            msg = @"邮件发送失败";
//            [self alertWithTitle:nil msg:msg];
//            break;
//        default:
//            break;
//    }
    [self.resourceViewController dismissViewControllerAnimated:YES completion:^{
        
    }];
}

@end
