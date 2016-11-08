//
//  APBaseNavigationController.m
//
//  https://github.com/nexuspod/SafeTransition
//
//
//  The MIT License (MIT)
//
//  Copyright (c) 2014 WenBi
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.
//

#import "APBaseNavigationController.h"
#include <execinfo.h>

@interface APBaseNavigationController () <UINavigationControllerDelegate> {
    BOOL _transitionInProgress;
}
@end

@implementation APBaseNavigationController

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    void* callstack[128];
    int frames = backtrace(callstack, 128);
    char **strs = backtrace_symbols(callstack, frames);
    NSString *secondTrack = [NSString stringWithUTF8String:strs[1]];
    NSString *className = nil;
    NSArray *arr1 = [secondTrack componentsSeparatedByString:@"["];
    if (arr1.count >= 2) {
        NSString *rightItem = [arr1 objectAtIndex:1];
        NSArray *arr2 = [rightItem componentsSeparatedByString:@" "];
        if (arr2.count >= 1) {
            className = [arr2 objectAtIndex:0];
        }
    }
    free(strs);
    if (!self.transitionInProgress && [self isValidViewControllerForPush:viewController parentClassName:className]) {
        self.transitionInProgress = YES;
        [super pushViewController:viewController animated:animated];
    }
}

- (BOOL)transitionInProgress {
    return _transitionInProgress;
}

- (void)setTransitionInProgress:(BOOL)transitionInProgress {
    _transitionInProgress = transitionInProgress;
}

// 判断vc和已有的最后一个vc的类名，不能重复
- (BOOL)isValidViewControllerForPush:(UIViewController *)vc parentClassName:(NSString *)className {
    if (self.viewControllers.count < 2) {
        return YES;
    } else {
        UIViewController *lastVC = [self.viewControllers lastObject];
        UIViewController *parentVC = [self.viewControllers objectAtIndex:(self.viewControllers.count - 2)];
        if ([self validClassName:className] && [className isEqualToString:NSStringFromClass(parentVC.class)]) {
            return NO;
        } else {
            return (lastVC.class != vc.class);
        }
    }
}

- (BOOL)validClassName:(NSString *)className {
    return className != nil && [className hasSuffix:@"Controller"] && ![className isEqualToString:@"PlugInController"] && ![className isEqualToString:@"LoginViewController"];
}

@end

