//
//  UIView+FLKit.h
//  FLKit
//
//  Created by Wess Cope on 3/20/12.
//  Copyright (c) 2012 FrenzyLabs. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^FLDrawRect)(UIView *view, CGRect rect);

enum {
    UIViewRoundedCornerNone = 0,
    UIViewRoundedCornerUpperLeft = 1 << 0,
    UIViewRoundedCornerUpperRight = 1 << 1,
    UIViewRoundedCornerLowerLeft = 1 << 2,
    UIViewRoundedCornerLowerRight = 1 << 3,
    UIViewRoundedCornerAll = (1 << 4) - 1,
};
typedef NSInteger UIViewRoundedCornerMask;

@interface UIView (FLKit)
@property (nonatomic) CGPoint   origin;
@property (nonatomic) CGSize    size;
@property (nonatomic) CGFloat   y;
@property (nonatomic) CGFloat   top;
@property (nonatomic) CGFloat   x;
@property (nonatomic) CGFloat   left;
@property (nonatomic) CGFloat   right;
@property (nonatomic) CGFloat   bottom;
@property (nonatomic) CGFloat   width;
@property (nonatomic) CGFloat   height;
@property (nonatomic) CGFloat   centerX;
@property (nonatomic) CGFloat   centerY;


-(void)setRoundedCorners:(UIViewRoundedCornerMask)corners radius:(CGFloat)radius;
+ (UIView *)topView;
+ (UIView *)viewWithFrame:(CGRect)frame drawRect:(FLDrawRect)block;
@end
