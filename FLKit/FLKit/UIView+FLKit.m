//
//  UIView+FLKit.m
//  FLKit
//
//  Created by Wess Cope on 3/20/12.
//  Copyright (c) 2012 FrenzyLabs. All rights reserved.
//

#import "UIView+FLKit.h"
#import <objc/runtime.h>
#import <objc/message.h>
#import <QuartzCore/QuartzCore.h>

@interface __UIView : UIView
{
    __strong FLDrawRect block;
}

- (void)setBlock:(FLDrawRect)_block;
@end

@implementation __UIView

- (void)setBlock:(FLDrawRect)_block
{
    block = [_block copy];
}

- (void)drawRect:(CGRect)rect
{
    if(block)
        block(self, rect);
}

@end

@implementation UIView (FLKit)

#pragma mark - Getters

- (CGPoint)origin
{
    return self.frame.origin;
}

- (CGSize)size
{
    return self.frame.size;
}

- (CGFloat)y
{
    return CGRectGetMinY(self.frame);
}

- (CGFloat)top {
    return self.y;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)left {
    return self.x;
}

- (CGFloat)x
{
    return CGRectGetMinX(self.frame);
}

- (CGFloat)right {
    return self.frame.origin.x + self.frame.size.width;
}

- (CGFloat)bottom {
    return self.frame.origin.y + self.frame.size.height;
}

- (CGFloat)width
{
    return CGRectGetWidth(self.frame);
}

- (CGFloat)height
{
    return CGRectGetHeight(self.frame);
}

- (CGFloat)centerX 
{
    return self.center.x;
}

- (CGFloat)centerY 
{
    return self.center.y;
}

- (CGFloat)cornerRadius
{
    return self.layer.cornerRadius;
}

- (CGFloat)borderWidth
{
    return self.layer.borderWidth;
}

- (UIColor *)borderColor
{
    return [UIColor colorWithCGColor:self.layer.borderColor];
}


#pragma mark - Setters

- (void)setOrigin:(CGPoint)_origin
{
    CGRect frame    = self.frame;
    frame.origin    = _origin;
    self.frame      = frame;
}


- (void)setSize:(CGSize)_size
{
    CGRect frame    = self.frame;
    frame.size      = _size;
    self.frame      = frame;
}

- (void)setY:(CGFloat)_y
{
    CGRect frame    = self.frame;
    frame.origin.y  = _y;
    self.frame      = frame;
}

- (void)setTop:(CGFloat)y {
    [self setY:y];
}

- (void)setBottom:(CGFloat)bottom {
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}

- (void)setLeft:(CGFloat)x {
    [self setX:x];
}

- (void)setRight:(CGFloat)right {
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}


- (void)setX:(CGFloat)_x
{
    CGRect frame    = self.frame;
    frame.origin.x  = _x;
    self.frame      = frame;
}

- (void)setWidth:(CGFloat)_width
{
    CGRect frame        = self.frame;
    frame.size.width    = _width;
    self.frame          = frame;
}

- (void)setHeight:(CGFloat)_height
{
    CGRect frame        = self.frame;
    frame.size.height   = _height;
    self.frame          = frame;
}

- (void)setCenterX:(CGFloat)centerX 
{
    self.center = CGPointMake(centerX, self.center.y);
}

- (void)setCenterY:(CGFloat)centerY 
{
    self.center = CGPointMake(self.center.x, centerY);
}

- (void)setCornerRadius:(CGFloat)cornerRadius
{
    self.layer.cornerRadius = cornerRadius;
}

- (void)setBorderWidth:(CGFloat)borderWidth
{
    self.layer.borderWidth = borderWidth;
}

- (void)setBorderColor:(UIColor *)borderColor
{
    self.layer.borderColor = borderColor.CGColor;
}

#pragma mark - RoundCorners
-(void)setRoundedCorners:(UIViewRoundedCornerMask)corners radius:(CGFloat)radius 
{
    CGRect rect = self.bounds;
	
	CGFloat minx = CGRectGetMinX(rect);
	CGFloat midx = CGRectGetMidX(rect);
	CGFloat maxx = CGRectGetMaxX(rect);
	CGFloat miny = CGRectGetMinY(rect);
	CGFloat midy = CGRectGetMidY(rect);
	CGFloat maxy = CGRectGetMaxY(rect);
    
	CGMutablePathRef path = CGPathCreateMutable();
	CGPathMoveToPoint(path, nil, minx, midy);
	CGPathAddArcToPoint(path, nil, minx, miny, midx, miny, (corners & UIViewRoundedCornerUpperLeft) ? radius : 0);
	CGPathAddArcToPoint(path, nil, maxx, miny, maxx, midy, (corners & UIViewRoundedCornerUpperRight) ? radius : 0);
	CGPathAddArcToPoint(path, nil, maxx, maxy, midx, maxy, (corners & UIViewRoundedCornerLowerRight) ? radius : 0);
	CGPathAddArcToPoint(path, nil, minx, maxy, minx, midy, (corners & UIViewRoundedCornerLowerLeft) ? radius : 0);
	CGPathCloseSubpath(path);
    
	CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
	[maskLayer setPath:path];
	[[self layer] setMask:nil];
	[[self layer] setMask:maskLayer];
	CFRelease(path);
}

#pragma mark - Short cut methods

+ (UIView *)topView
{
    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
    
	if (keyWindow.subviews.count > 0) {
		return [keyWindow.subviews objectAtIndex:0];
	} else {
		return keyWindow;
	}
}

#pragma mark - Block Based DrawRect
+ (UIView *)viewWithFrame:(CGRect)frame drawRect:(FLDrawRect)block
{
    __UIView *view = [[__UIView alloc] initWithFrame:frame];
    [view setBlock:block];
    
    return view;
}

@end
