//
//  UIControl+FLKit.h
//  FLKit
//
//  Created by Wess Cope on 3/21/12.
//  Copyright (c) 2012 FrenzyLabs. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^FLEventCallback)(id sender);

@interface UIControl (FLKit)
- (void)on:(UIControlEvents)event callback:(FLEventCallback)callback;
- (void)remove:(UIControlEvents)events;
@end
