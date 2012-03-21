//
//  NSObject+FLKit.h
//  FLKit
//
//  Created by Wess Cope on 3/20/12.
//  Copyright (c) 2012 FrenzyLabs. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^FLBlock)(void);

@interface NSObject (FLKit)

- (void)execute:(FLBlock)block callBack:(FLBlock)callback;
+ (void)execute:(FLBlock)block callBack:(FLBlock)callback;

@end
