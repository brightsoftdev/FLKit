//
//  UIColor+FLKit.h
//  FLKit
//
//  Created by Wess Cope on 3/21/12.
//  Copyright (c) 2012 FrenzyLabs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (FLKit)
+ (UIColor *)fromHexString:(NSString *)inColorString;
- (UIColor *)colorByChangingAlphaTo:(CGFloat)newAlpha;
- (UIColor *)invertColor;
- (BOOL)isDark;
@end
