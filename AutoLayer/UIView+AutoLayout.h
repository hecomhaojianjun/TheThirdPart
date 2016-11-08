//
//  UIView+AutoLayout.h
//  测试自动布局
//
//  Created by wyj on 14-10-2.
//  Copyright (c) 2014年 wyj.ruijie. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 * 放置view的参照位置
 */

typedef NS_OPTIONS(NSUInteger, AutoLayoutViewPinEdges)
{
    // 参照view的顶部
    AutoLayoutViewPinTopEdge = 1 << 0,
    
    // 参照view的右边
    AutoLayoutViewPinRightEdge = 1 << 1,
    
    // 参照view的底部
    AutoLayoutViewPinBottomEdge = 1 << 2,
    
    // 参照view的左部
    AutoLayoutViewPinLeftEdge = 1 << 3,
    
    // 参照view的所有边
    AutoLayoutViewPinAllEdges = ~0UL
};
@interface UIView (AutoLayout)
//
/**
 *  创建自动布局的view
 *
 *  @return 返回创建的视图
 */
+(instancetype)autoLayoutView;

/**
 *  参照父视图的自动布局
 *
 *  @param edges 参照父视图的位置
 *  @param inset 边距
 *
 *  @return 一个数组，里面为约束对象
 */
#pragma -mark  子视图相对父视图的约束
-(NSArray*)pinToSuperviewEdges:(AutoLayoutViewPinEdges)edges inset:(CGFloat)inset;
/**
 *  对于ios7有新的方式来匹配状态栏、导航栏等的计算方式
 *  主要在ios7后viewController有两个属性topLayoutGuide
 *  和bottomLayoutGuide
 *
 *  @param edges          参照父视图的位置
 *  @param inset          边距
 *  @param viewController viewController
 *
 *  @return 一个数组对象，里面为约束的对象
 */
-(NSArray*)pinToSuperviewEdges:(AutoLayoutViewPinEdges)edges inset:(CGFloat)inset usingLayoutGuidesFrom:(UIViewController*)viewController;
/**
 *  参照父视图的自动布局，默认采取所有边，也就是整个对于父视图的布局
 *
 *  @param insets 边距
 *
 *  @return 一个数组，里面为约束对象
 */
-(NSArray*)pinToSuperviewEdgesWithInset:(UIEdgeInsets)insets;
/**
 *  参照父视图的自动布局，相对父视图的attribute的multiplier多少倍
 *
 *  @param attribute 子视图的属性
 *  @param multiplier 倍数 要0<multiplier
 *
 *  @return 约束对象
 */
-(NSLayoutConstraint *)pinToSuperviewAttribute:(NSLayoutAttribute)attribute multiplier:(CGFloat)multiplier constant:(CGFloat)constant;

#pragma -mark 子视图相对父视图中心点的约束
/**
 *  使在view中居中
 *
 *  @param view 参照的view
 *
 *  @return 一个数组，里面为约束对象
 */
-(NSArray *)centerInView:(UIView*)view;
/**
 *  使在view中参照NSLayoutAttribute居中
 *
 *  @param view 参照的view
 *  @param axis 为NSLayoutAttribute中的
 *  NSLayoutAttributeCenterX,
 *  NSLayoutAttributeCenterY,
 *
 *  @return 返回NSLayoutConstraint对象
 */
-(NSLayoutConstraint *)centerInView:(UIView *)view onAxis:(NSLayoutAttribute)axis;
/**
 *  使在父视图中居中
 *
 *  @return 一个数组，里面为约束的对象
 */
-(NSArray *)centerInContainer;
/**
 *  使在父视图中居中参照axis
 *
 *  @param axis 为NSLayoutAttribute中的
 *  NSLayoutAttributeCenterX,
 *  NSLayoutAttributeCenterY,
 *
 *  @return 返回 NSLayoutConstraint对象
 */
-(NSLayoutConstraint *)centerInContainerOnAxis:(NSLayoutAttribute)axis;

#pragma -mark 子视图大小的约束
/**
 *  设置视图的内容大小
 *
 *  @param size 内容大小
 *
 *  @return 一个数组，里面为约束的对象
 */
-(NSArray *)constrainToSize:(CGSize)size;
/**
 *  设置内容视图的宽
 *
 *  @param width 宽的大小
 *
 *  @return NSLayoutConstraint
 */
-(NSLayoutConstraint *)constrainToWidth:(CGFloat)width;

/**
 *  设置内容视图的最大宽
 *
 *  @param width 最大宽
 *
 *  @return NSLayoutConstraint
 */
-(NSLayoutConstraint *)constrainToMaximumWidth:(CGFloat)width;

/**
 *  设置内容视图的最小宽
 *
 *  @param width 最小宽
 *
 *  @return NSLayoutConstraint
 */
-(NSLayoutConstraint *)constrainToMinimumWidth:(CGFloat)width;
/**
 *  设置内容视图的高度
 *
 *  @param height 高的大小
 *
 *  @return NSLayoutConstraint
 */

-(NSLayoutConstraint *)constrainToHeight:(CGFloat)height;

/**
 *  设置内容视图的最大高度高度
 *
 *  @param height 高的大小
 *
 *  @return NSLayoutConstraint
 */
-(NSLayoutConstraint *)constrainToMaximumHeight:(CGFloat)height;

/**
 *  设置内容视图的最小高度
 *
 *  @param height 最小高
 *
 *  @return NSLayoutConstraint
 */
-(NSLayoutConstraint *)constrainToMinimumHeight:(CGFloat)height;

/**
 *  设置内容视图的大小区间
 *
 *  @param minimum 最小size
 *  @param maximum 最大size
 *
 *  @return 一个数组，里面为约束对象
 */
-(NSArray *)constrainToMinimumSize:(CGSize)minimum maximumSize:(CGSize)maximum;
/**
 *  设置内容视图的最小值
 *
 *  @param minimum 最小size
 *
 *  @return 一个数组，里面为约束对象
 */
-(NSArray *)constrainToMinimumSize:(CGSize)minimum;
/**
 *  设置内容视图的最大值
 *
 *  @param maximum 最大size
 *
 *  @return 一个数组，里面为约束对象
 */
-(NSArray *)constrainToMaximumSize:(CGSize)maximum;

#pragma -mark 其他view约束，主要是子视图相对其他子视图的约束
/**
 *  参照peerItem的toAttribute实现对自身attribute的约束
 *
 *  @param attribute   要约束的attribute
 *  @param toAttribute 参照的约束toAttribute
 *  @param peerItem    参照的对象
 *
 *  @return NSLayoutConstraint
 */
-(NSLayoutConstraint *)pinAttribute:(NSLayoutAttribute)attribute toAttribute:(NSLayoutAttribute)toAttribute ofItem:(id)peerItem;
/**
 *  参照peerItem的toAttribute实现对自身attribute的约束
 *
 *  @param attribute   要约束的attribute
 *  @param toAttribute 参照的toAttribute
 *  @param peerItem    参照的对象
 *  @param constant    修正的常量
 *
 *  @return NSLayoutConstraint
 */
-(NSLayoutConstraint *)pinAttribute:(NSLayoutAttribute)attribute toAttribute:(NSLayoutAttribute)toAttribute ofItem:(id)peerItem withConstant:(CGFloat)constant;
/**
 *  参照peerItem的toAttribute实现对自身attribute的约束
 *
 *  @param attribute   要约束的attribute
 *  @param toAttribute 参照的toAttribute
 *  @param peerItem    参照的对象
 *  @param constant    修正的常量
 *  @param relation    NSLayoutRelation
 *
 *  @return NSLayoutConstraint
 */
-(NSLayoutConstraint *)pinAttribute:(NSLayoutAttribute)attribute toAttribute:(NSLayoutAttribute)toAttribute ofItem:(id)peerItem withConstant:(CGFloat)constant relation:(NSLayoutRelation)relation;
/**
 *  参照peerItem实现对自身的约束
 *
 *  @param attribute 要约束的attribute
 *  @param peerItem  参照的peerItem
 *
 *  @return NSLayoutConstraint
 */
-(NSLayoutConstraint *)pinAttribute:(NSLayoutAttribute)attribute toSameAttributeOfItem:(id)peerItem;
/**
 *  参照peerItem实现对自身的约束
 *
 *  @param attribute 要约束的attribute
 *  @param peerItem  参照的peerItem
 *  @param constant  修正的常量
 *
 *  @return NSLayoutConstraint
 */
-(NSLayoutConstraint *)pinAttribute:(NSLayoutAttribute)attribute toSameAttributeOfItem:(id)peerItem withConstant:(CGFloat)constant;
/**
 *  参照peerview对自身的edges约束
 *
 *  @param edges    要约束的edges
 *  @param peerView 参照的view
 *
 *  @return 一个数组，里面为约束的对象
 */
-(NSArray *)pinEdges:(AutoLayoutViewPinEdges)edges toSameEdgesOfView:(UIView *)peerView;
/**
 *  参照peerview对自身的edges约束
 *
 *  @param edges    要约束的edges
 *  @param peerView 参照的view
 *  @param inset    相差的边距
 *
 *  @return 一个数组，里面为约束的对象
 */
-(NSArray *)pinEdges:(AutoLayoutViewPinEdges)edges toSameEdgesOfView:(UIView *)peerView inset:(CGFloat)inset;
/**
 *  对于父视图的参照x,y值的坐标
 *
 *  @param x     NSLayoutAttribute
 *  @param y     NSLayoutAttribute
 *  @param point 偏移的点
 *
 *  @return 一个数组，里面为约束对象
 */
-(NSArray*)pinPointAtX:(NSLayoutAttribute)x Y:(NSLayoutAttribute)y toPoint:(CGPoint)point;
/**
 *  参照peerItem实现对自身的约束
 *
 *  @param attribute 要约束的attribute
 *  @param peerItem  参照的peerItem
 *  @param multiplier  倍数关系
 *
 *  @return NSLayoutConstraint
 */
-(NSLayoutConstraint *)pinToSuperviewAttribute:(NSLayoutAttribute)attribute OfItem:(UIView *)peerItem multiplier:(CGFloat)multiplier;

@end
