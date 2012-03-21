//
//  UIButton+FLKit.m
//  FLKit
//
//  Created by Wess Cope on 3/21/12.
//  Copyright (c) 2012 FrenzyLabs. All rights reserved.
//

#import "UIButton+FLKit.h"
#import <objc/runtime.h>
#import <QuartzCore/QuartzCore.h>

@implementation UIButton (FLKit)
static char BG_PROPERTY_KEY;
@dynamic backgrounds;

- (void)setBackgrounds:(NSMutableDictionary *)backgrounds
{
    objc_setAssociatedObject(self, &BG_PROPERTY_KEY, backgrounds, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSMutableDictionary *)backgrounds
{
    return (NSMutableDictionary *)objc_getAssociatedObject(self, &BG_PROPERTY_KEY);
}


- (void) setBackgroundColor:(UIColor *)bgColor forState:(UIControlState)state
{
    if([self backgrounds] == NULL)
    {
        NSMutableDictionary *tmpDict = [[NSMutableDictionary alloc] init];
        [self setBackgrounds:tmpDict];
    }
    
    [[self backgrounds] setObject:bgColor forKey:[NSNumber numberWithInt:state]];
    
    if(!self.backgroundColor)
        self.backgroundColor = bgColor;
}

- (void)animateBackgroundToColor:(NSNumber *)key
{
    UIColor *background = [[self backgrounds] objectForKey:key];
    if(background)
    {
        [UIView animateWithDuration:0.1f animations:^{
            self.backgroundColor = background;
        }];
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    [self animateBackgroundToColor:[NSNumber numberWithInt:UIControlStateHighlighted]];
    
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesCancelled:touches withEvent:event];
    [self animateBackgroundToColor:[NSNumber numberWithInt:UIControlStateNormal]];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
    [self animateBackgroundToColor:[NSNumber numberWithInt:UIControlStateNormal]];
}

+ (UIButton *) withColor:(UIColor *)color
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.titleLabel.font = [UIFont boldSystemFontOfSize:[UIFont buttonFontSize]];
    [button setBackgroundColor:color];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setTitleShadowColor:[UIColor colorWithWhite:0 alpha:0.5f] forState:UIControlStateNormal];
    
    button.frame = CGRectMake(0.0f, 0.0f, 300.0f, 46.0f);
    button.titleLabel.shadowOffset = CGSizeMake(0, 1);
    
    button.layer.cornerRadius = 6.0f;
    
    return button;
}

+ (UIButton *) withStartColor:(UIColor *)startColor EndColor:(UIColor *)stopColor
{
    UIButton *button = [UIButton withColor:[UIColor whiteColor]];
    button.backgroundColor = [UIColor clearColor];
    
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = button.frame;
    gradient.cornerRadius = 6.0f;
    
    CGColorRef cgStop  = [stopColor CGColor];
    CGColorRef cgStart = [startColor CGColor];
    
    gradient.colors = [NSArray arrayWithObjects:(__bridge id)cgStart, (__bridge id)cgStop, nil];
    [button.layer insertSublayer:gradient below:button.titleLabel.layer];
    
    return button;
}

@end
