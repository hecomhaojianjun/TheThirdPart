//
//  AuotLayoutScrollerView.h
//  测试自动布局
//
//  Created by wyj on 14-10-19.
//  Copyright (c) 2014年 wyj.ruijie. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSUInteger, AuotLayoutScrollerViewType)
{
    // 垂直方向
    AuotLayoutScrollerViewType_V = 1 ,
    // 水平方向
    AuotLayoutScrollerViewType_H = 2
    
};
@interface AuotLayoutScrollerView : UIScrollView
-(instancetype)initWithFrame:(CGRect)frame ScrollerViewType:(AuotLayoutScrollerViewType)type;
-(void)setAuotLayoutScrollerViewType:(AuotLayoutScrollerViewType)type constant:(CGFloat)constant;
// 延垂直方向添加view
-(void)addAuotLayoutView_V:(UIView *)view height:(CGFloat)height;
// 延水平方向添加view
-(void)addAuotLayoutView_H:(UIView *)view width:(CGFloat)width;

@end
