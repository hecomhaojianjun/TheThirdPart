//
//  UIView+AutoLayout.m
//  测试自动布局
//
//  Created by wyj on 14-10-2.
//  Copyright (c) 2014年 wyj.ruijie. All rights reserved.
//

#import "UIView+AutoLayout.h"
@interface UIView (AutoLayoutPrivate)
/**
 *  查找自身和peerView共同的父view
 *
 *  @param peerView 参照的view
 *
 *  @return 返回共同的父view
 */
- (UIView*)commonSuperviewWithView:(UIView*)peerView;
/**
 *  不需要参照view的约束
 *
 *  @param attribute attribute
 *  @param constant  边距常量
 *  @param relation  NSLayoutRelation
 *
 *  @return NSLayoutConstraint
 */
- (NSLayoutConstraint *)applyAttribute:(NSLayoutAttribute)attribute withConstant:(CGFloat)constant relation:(NSLayoutRelation)relation;
@end
@implementation UIView (AutoLayout)
+(instancetype)autoLayoutView
{
    UIView *viewToReturn = [[self  alloc] init];
    viewToReturn.translatesAutoresizingMaskIntoConstraints = NO;
    viewToReturn.backgroundColor = [UIColor clearColor];
    return viewToReturn;
}

#pragma -mark superview
-(NSArray *)pinToSuperviewEdges:(AutoLayoutViewPinEdges)edges inset:(CGFloat)inset
{
    return [self pinToSuperviewEdges:edges inset:inset usingLayoutGuidesFrom:nil];
}
-(NSArray *)pinToSuperviewEdges:(AutoLayoutViewPinEdges)edges inset:(CGFloat)inset usingLayoutGuidesFrom:(UIViewController *)viewController
{
    UIView *superview = self.superview;
    NSAssert(superview,@"Can't pin to a superview if no superview exists");
    
    id topItem = nil;
    id bottomItem = nil;
    
#ifdef __IPHONE_7_0
    if (viewController && [viewController respondsToSelector:@selector(topLayoutGuide)])
    {
        topItem = viewController.topLayoutGuide;
        bottomItem = viewController.bottomLayoutGuide;
    }
#endif
    
    NSMutableArray *constraints = [NSMutableArray array];
    
    if (edges & AutoLayoutViewPinTopEdge)
    {
        id item = topItem ? topItem : superview;
        NSLayoutAttribute attribute = topItem ? NSLayoutAttributeBottom : NSLayoutAttributeTop;
        [constraints addObject:[self pinAttribute:NSLayoutAttributeTop toAttribute:attribute ofItem:item withConstant:inset]];
    }
    if (edges & AutoLayoutViewPinLeftEdge)
    {
        [constraints addObject:[self pinAttribute:NSLayoutAttributeLeft toAttribute:NSLayoutAttributeLeft ofItem:superview withConstant:inset]];
    }
    if (edges & AutoLayoutViewPinRightEdge)
    {
        [constraints addObject:[self pinAttribute:NSLayoutAttributeRight toAttribute:NSLayoutAttributeRight ofItem:superview withConstant:-inset]];
    }
    if (edges & AutoLayoutViewPinBottomEdge)
    {
        id item = bottomItem ? bottomItem : superview;
        NSLayoutAttribute attribute = bottomItem ? NSLayoutAttributeTop : NSLayoutAttributeBottom;
        [constraints addObject:[self pinAttribute:NSLayoutAttributeBottom toAttribute:attribute ofItem:item withConstant:-inset]];
    }
    return [constraints copy];
}
-(NSArray *)pinToSuperviewEdgesWithInset:(UIEdgeInsets)insets
{
    NSMutableArray *constraints = [NSMutableArray array];
    
    [constraints addObjectsFromArray:[self pinToSuperviewEdges:AutoLayoutViewPinTopEdge inset:insets.top]];
    [constraints addObjectsFromArray:[self pinToSuperviewEdges:AutoLayoutViewPinLeftEdge inset:insets.left]];
    [constraints addObjectsFromArray:[self pinToSuperviewEdges:AutoLayoutViewPinBottomEdge inset:insets.bottom]];
    [constraints addObjectsFromArray:[self pinToSuperviewEdges:AutoLayoutViewPinRightEdge inset:insets.right]];
    
    return [constraints copy];
}
-(NSLayoutConstraint *)pinToSuperviewAttribute:(NSLayoutAttribute)attribute multiplier:(CGFloat)multiplier constant:(CGFloat)constant
{
    UIView *superview = self.superview;
    NSAssert(superview,@"Can't create constraints without a superview");
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self attribute:attribute relatedBy:NSLayoutRelationEqual toItem:superview attribute:attribute multiplier:multiplier constant:constant];
    [superview addConstraint:constraint];
    return constraint;
}
-(NSLayoutConstraint *)pinToSuperviewAttribute:(NSLayoutAttribute)attribute OfItem:(UIView *)peerItem multiplier:(CGFloat)multiplier
{
    UIView *superview = [self commonSuperviewWithView:peerItem];;
    NSAssert(superview,@"Can't create constraints without a superview");
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self attribute:attribute relatedBy:NSLayoutRelationEqual toItem:superview attribute:attribute multiplier:multiplier constant:0];
    [superview addConstraint:constraint];
    return constraint;
}
-(NSArray *)centerInView:(UIView *)view
{
    NSMutableArray *constraints = [NSMutableArray array];
    
    [constraints addObject:[self centerInView:view onAxis:NSLayoutAttributeCenterX]];
    [constraints addObject:[self centerInView:view onAxis:NSLayoutAttributeCenterY]];
    
    return [constraints copy];
}
-(NSArray *)centerInContainer
{
    return [self centerInView:self.superview];
}
-(NSLayoutConstraint *)centerInView:(UIView *)view onAxis:(NSLayoutAttribute)axis
{
    NSParameterAssert(axis == NSLayoutAttributeCenterX || axis == NSLayoutAttributeCenterY);
    return [self pinAttribute:axis toSameAttributeOfItem:view];
}
-(NSLayoutConstraint*)centerInContainerOnAxis:(NSLayoutAttribute)axis
{
    return [self centerInView:self.superview onAxis:axis];
}
#pragma mark - Constraining to a fixed size

-(NSArray *)constrainToSize:(CGSize)size
{
    NSMutableArray *constraints = [NSMutableArray new];
    
    if (size.width)
        [constraints addObject:[self constrainToWidth:size.width]];
    if (size.height)
        [constraints addObject:[self constrainToHeight:size.height]];
    
    return [constraints copy];
}

-(NSLayoutConstraint *)constrainToWidth:(CGFloat)width
{
    return [self applyAttribute:NSLayoutAttributeWidth withConstant:width relation:NSLayoutRelationEqual];
}
-(NSLayoutConstraint *)constrainToMaximumWidth:(CGFloat)width
{
    return [self applyAttribute:NSLayoutAttributeWidth withConstant:width relation:NSLayoutRelationLessThanOrEqual];
}
-(NSLayoutConstraint *)constrainToMinimumWidth:(CGFloat)width
{
    return [self applyAttribute:NSLayoutAttributeWidth withConstant:width relation:NSLayoutRelationGreaterThanOrEqual];
}
-(NSLayoutConstraint *)constrainToHeight:(CGFloat)height
{
    return [self applyAttribute:NSLayoutAttributeHeight withConstant:height relation:NSLayoutRelationEqual];
}

-(NSLayoutConstraint *)constrainToMaximumHeight:(CGFloat)height
{
    return   [self applyAttribute:NSLayoutAttributeHeight withConstant:height relation:NSLayoutRelationLessThanOrEqual];
}
-(NSLayoutConstraint *)constrainToMinimumHeight:(CGFloat)height
{
     return   [self applyAttribute:NSLayoutAttributeHeight withConstant:height relation:NSLayoutRelationGreaterThanOrEqual];
}
-(NSArray *)constrainToMinimumSize:(CGSize)minimum maximumSize:(CGSize)maximum
{
    NSAssert(minimum.width <= maximum.width, @"maximum width should be strictly wider than or equal to minimum width");
    NSAssert(minimum.height <= maximum.height, @"maximum height should be strictly higher than or equal to minimum height");
    NSArray *minimumConstraints = [self constrainToMinimumSize:minimum];
    NSArray *maximumConstraints = [self constrainToMaximumSize:maximum];
    return [minimumConstraints arrayByAddingObjectsFromArray:maximumConstraints];
}

-(NSArray *)constrainToMinimumSize:(CGSize)minimum
{
    NSMutableArray *constraints = [NSMutableArray array];
    if (minimum.width)
        [constraints addObject:[self applyAttribute:NSLayoutAttributeWidth withConstant:minimum.width relation:NSLayoutRelationGreaterThanOrEqual]];
    if (minimum.height)
        [constraints addObject:[self applyAttribute:NSLayoutAttributeHeight withConstant:minimum.height relation:NSLayoutRelationGreaterThanOrEqual]];
    return [constraints copy];
}

-(NSArray *)constrainToMaximumSize:(CGSize)maximum
{
    NSMutableArray *constraints = [NSMutableArray array];
    if (maximum.width)
        [constraints addObject:[self applyAttribute:NSLayoutAttributeWidth withConstant:maximum.width relation:NSLayoutRelationLessThanOrEqual]];
    if (maximum.height)
        [constraints addObject:[self applyAttribute:NSLayoutAttributeHeight withConstant:maximum.height relation:NSLayoutRelationLessThanOrEqual]];
    return [constraints copy];
}

#pragma mark - Pinning to other items

- (NSLayoutConstraint *)pinAttribute:(NSLayoutAttribute)attribute toAttribute:(NSLayoutAttribute)toAttribute ofItem:(id)peerItem withConstant:(CGFloat)constant
{
    return [self pinAttribute:attribute toAttribute:toAttribute ofItem:peerItem withConstant:constant relation:NSLayoutRelationEqual];
}

-(NSLayoutConstraint *)pinAttribute:(NSLayoutAttribute)attribute toAttribute:(NSLayoutAttribute)toAttribute ofItem:(id)peerItem
{
    return [self pinAttribute:attribute toAttribute:toAttribute ofItem:peerItem withConstant:0];
}

-(NSLayoutConstraint *)pinAttribute:(NSLayoutAttribute)attribute toAttribute:(NSLayoutAttribute)toAttribute ofItem:(id)peerItem withConstant:(CGFloat)constant relation:(NSLayoutRelation)relation
{
    NSParameterAssert(peerItem);
    
    UIView *superview;
    if ([peerItem isKindOfClass:[UIView class]])
    {
        superview = [self commonSuperviewWithView:peerItem];
        NSAssert(superview,@"Can't create constraints without a common superview");
    }
    else
    {
        superview = self.superview;
    }
    NSAssert(superview,@"Can't create constraints without a common superview");
    
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self attribute:attribute relatedBy:relation toItem:peerItem attribute:toAttribute multiplier:1.0 constant:constant];
    [superview addConstraint:constraint];
    return constraint;
}

-(NSLayoutConstraint *)pinAttribute:(NSLayoutAttribute)attribute toSameAttributeOfItem:(id)peerItem
{
    return [self pinAttribute:attribute toAttribute:attribute ofItem:peerItem withConstant:0];
}

-(NSLayoutConstraint *)pinAttribute:(NSLayoutAttribute)attribute toSameAttributeOfItem:(id)peerItem withConstant:(CGFloat)constant
{
    return [self pinAttribute:attribute toAttribute:attribute ofItem:peerItem withConstant:constant];
}

-(NSArray *)pinEdges:(AutoLayoutViewPinEdges)edges toSameEdgesOfView:(UIView *)peerView
{
    return [self pinEdges:edges toSameEdgesOfView:peerView inset:0];
}

-(NSArray *)pinEdges:(AutoLayoutViewPinEdges)edges toSameEdgesOfView:(UIView *)peerView inset:(CGFloat)inset
{
    UIView *superview = [self commonSuperviewWithView:peerView];
    NSAssert(superview,@"Can't create constraints without a common superview");
    
    NSMutableArray *constraints = [NSMutableArray arrayWithCapacity:4];
    
    if (edges & AutoLayoutViewPinTopEdge)
    {
        [constraints addObject:[self pinAttribute:NSLayoutAttributeTop toAttribute:NSLayoutAttributeTop ofItem:peerView withConstant:inset]];
    }
    if (edges & AutoLayoutViewPinLeftEdge)
    {
        [constraints addObject:[self pinAttribute:NSLayoutAttributeLeft toAttribute:NSLayoutAttributeLeft ofItem:peerView withConstant:inset]];
    }
    if (edges & AutoLayoutViewPinRightEdge)
    {
        [constraints addObject:[self pinAttribute:NSLayoutAttributeRight toAttribute:NSLayoutAttributeRight ofItem:peerView withConstant:-inset]];
    }
    if (edges & AutoLayoutViewPinBottomEdge)
    {
        [constraints addObject:[self pinAttribute:NSLayoutAttributeBottom toAttribute:NSLayoutAttributeBottom ofItem:peerView withConstant:-inset]];
    }
    [superview addConstraints:constraints];
    return [constraints copy];
}

#pragma mark - Pinning to a fixed point

-(NSArray*)pinPointAtX:(NSLayoutAttribute)x Y:(NSLayoutAttribute)y toPoint:(CGPoint)point
{
    UIView *superview = self.superview;
    NSAssert(superview,@"Can't create constraints without a superview");
    
    // Valid X positions are Left, Center, Right and Not An Attribute
    __unused BOOL xValid = (x == NSLayoutAttributeLeft || x == NSLayoutAttributeCenterX || x == NSLayoutAttributeRight || x == NSLayoutAttributeNotAnAttribute);
    // Valid Y positions are Top, Center, Baseline, Bottom and Not An Attribute
    __unused BOOL yValid = (y == NSLayoutAttributeTop || y == NSLayoutAttributeCenterY || y == NSLayoutAttributeBaseline || y == NSLayoutAttributeBottom || y == NSLayoutAttributeNotAnAttribute);
    
    NSAssert (xValid && yValid,@"Invalid positions for creating constraints");
    
    NSMutableArray *constraints = [NSMutableArray array];
    
    if (x != NSLayoutAttributeNotAnAttribute)
    {
        NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self attribute:x relatedBy:NSLayoutRelationEqual toItem:superview attribute:NSLayoutAttributeLeft multiplier:1.0 constant:point.x];
        [constraints addObject:constraint];
    }
    
    if (y != NSLayoutAttributeNotAnAttribute)
    {
        NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self attribute:y relatedBy:NSLayoutRelationEqual toItem:superview attribute:NSLayoutAttributeTop multiplier:1.0 constant:point.y];
        [constraints addObject:constraint];
    }
    [superview addConstraints:constraints];
    return [constraints copy];
}

#pragma mark - Private
-(UIView*)commonSuperviewWithView:(UIView*)peerView
{
    UIView *commonSuperview = nil;
    UIView *startView = self;
    do {
        if ([peerView isDescendantOfView:startView])
        {
            commonSuperview = startView;
        }
        startView = startView.superview;
    } while (startView && !commonSuperview);
    
    return commonSuperview;
}

-(NSLayoutConstraint *)applyAttribute:(NSLayoutAttribute)attribute withConstant:(CGFloat)constant relation:(NSLayoutRelation)relation
{
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self attribute:attribute relatedBy:relation toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:constant];
    [self addConstraint:constraint];
    return constraint;
}
@end
