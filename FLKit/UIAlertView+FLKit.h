//
//  UIAlertView+FLKit.h
//  FLKit
//
//  Created by Wess Cope on 3/21/12.
//  Copyright (c) 2012 FrenzyLabs. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^FLAlertViewBlock)(void);

@interface UIAlertView (FLKit)
@property (nonatomic, retain) NSMutableDictionary *buttonsAndBlocks;
@property (nonatomic, retain) id<UIAlertViewDelegate> flDelegate;

+ (UIAlertView *)alertViewWithTitle:(NSString *)title message:(NSString *)message;
- (void)cancelButtonWithTitle:(NSString *)title block:(FLAlertViewBlock)block;
- (void)addButtonWithTitle:(NSString *)title block:(FLAlertViewBlock)block;

@end
