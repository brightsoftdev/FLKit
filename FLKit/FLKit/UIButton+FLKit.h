//
//  UIButton+FLKit.h
//  FLKit
//
//  Created by Wess Cope on 3/21/12.
//  Copyright (c) 2012 FrenzyLabs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (FLKit)
@property (nonatomic, retain) NSMutableDictionary *backgrounds;

- (void) setBackgroundColor:(UIColor *)bgColor forState:(UIControlState)state;

+ (UIButton *) withColor:(UIColor *)color;
+ (UIButton *) withStartColor:(UIColor *)startColor EndColor:(UIColor *)stopColor; 

@end
