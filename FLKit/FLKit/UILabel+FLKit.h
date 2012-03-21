//
//  UILabel+FLKit.h
//  FLKit
//
//  Created by Wess Cope on 3/20/12.
//  Copyright (c) 2012 FrenzyLabs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (FLKit)
- (void)alignTop;
- (void)alignBottom;
- (void)sizeToFitFixedWidth:(NSInteger)fixedWidth;
- (void)adjustHeightForString:(NSString *)str;
@end
