//
//  AuotLayoutScrollerView.m
//  测试自动布局
//
//  Created by wyj on 14-10-19.
//  Copyright (c) 2014年 wyj.ruijie. All rights reserved.
//

#import "AuotLayoutScrollerView.h"
#import "UIView+AutoLayout.h"

@interface AuotLayoutScrollerView()
@property(nonatomic)AuotLayoutScrollerViewType type;
@property(nonatomic,strong) NSLayoutConstraint *constraint;
@property(nonatomic,weak) UIView *LastView;
@property(nonatomic,weak) UIView *contentView;
@end
@implementation AuotLayoutScrollerView
-(instancetype)initWithFrame:(CGRect)frame ScrollerViewType:(AuotLayoutScrollerViewType)type
{
    self = [self initWithFrame:frame];
    if (self) {
        if (type == AuotLayoutScrollerViewType_V) {
            [_contentView constrainToWidth:frame.size.width];
        }else
            [_contentView constrainToHeight:frame.size.height];
        self.type = type;
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIView *content = [UIView autoLayoutView];
        [self addSubview:content];
        [content pinToSuperviewEdgesWithInset:UIEdgeInsetsZero];
        self.contentView = content;
    }
    return self;
}
-(void)setAuotLayoutScrollerViewType:(AuotLayoutScrollerViewType)type constant:(CGFloat)constant
{
    if (type == AuotLayoutScrollerViewType_V) {
        [_contentView constrainToWidth:constant];
    }else
        [_contentView constrainToHeight:constant];
    self.type = type;
}
-(void)addAuotLayoutView_V:(UIView *)view height:(CGFloat)height
{
    NSAssert(self.type == AuotLayoutScrollerViewType_V, @"scrollview为垂直方向添加view才能调用此方法");
    view.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:view];
    [view pinToSuperviewEdges:AutoLayoutViewPinLeftEdge|AutoLayoutViewPinRightEdge inset:0];
    if (self.LastView) {
        [self.contentView removeConstraint:self.constraint];
        [view pinAttribute:NSLayoutAttributeTop toAttribute:NSLayoutAttributeBottom ofItem:self.LastView];
        [view constrainToHeight:height];
        
        self.constraint = [view pinAttribute:NSLayoutAttributeBottom toSameAttributeOfItem:self.contentView];
        self.LastView = view;
        
    }else
    {
        [view pinAttribute:NSLayoutAttributeTop toSameAttributeOfItem:self.contentView];
        [view constrainToHeight:height];
        self.constraint = [view pinAttribute:NSLayoutAttributeBottom toSameAttributeOfItem:self.contentView];
        self.LastView = view;
    }
}
-(void)addAuotLayoutView_H:(UIView *)view width:(CGFloat)width
{
    NSAssert(self.type == AuotLayoutScrollerViewType_H, @"scrollview为水平方向添加view才能调用此方法");
    view.translatesAutoresizingMaskIntoConstraints = NO;
    if (self.LastView) {
        [self.contentView addSubview:view];
        [view pinAttribute:NSLayoutAttributeLeft toAttribute:NSLayoutAttributeRight ofItem:self.LastView];
        [view pinToSuperviewEdges:AutoLayoutViewPinTopEdge|AutoLayoutViewPinBottomEdge inset:0];
        [view constrainToWidth:width];
        [self.contentView removeConstraint:self.constraint];
        self.constraint = [view pinAttribute:NSLayoutAttributeRight toSameAttributeOfItem:self.contentView];
        self.LastView = view;
        
    }else
    {
        [self.contentView addSubview:view];
        [view pinAttribute:NSLayoutAttributeLeft toSameAttributeOfItem:self.contentView];
        [view pinToSuperviewEdges:AutoLayoutViewPinTopEdge|AutoLayoutViewPinBottomEdge inset:0];
        [view constrainToWidth:width];
        self.constraint = [view pinAttribute:NSLayoutAttributeRight toSameAttributeOfItem:self.contentView];
        self.LastView = view;
    }
}

@end

