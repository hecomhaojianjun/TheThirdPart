//
//  Message.m
//  Kale
//
//  Created by Administrator on 13-6-28.
//  Copyright (c) 2013年 郝 建军. All rights reserved.
//

#import "Message.h"

@implementation Message

- (void)sendSmS:(NSString *)testStr andRecipients:(NSArray *)recipients {
	
	BOOL canSendSMS = [MFMessageComposeViewController canSendText];
	if (canSendSMS) {
        
		MFMessageComposeViewController *picker = [[MFMessageComposeViewController alloc] init];
		picker.messageComposeDelegate = self;
		picker.navigationBar.tintColor = [UIColor blackColor];
		picker.body = testStr;
		picker.recipients = recipients;
        [self.resourceViewController presentViewController:picker animated:YES completion:^{
            
        }];
	}
}

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result {
	
	// Notifies users about errors associated with the interface
	[self.resourceViewController dismissViewControllerAnimated:YES completion:^{
        
    }];
}

@end
