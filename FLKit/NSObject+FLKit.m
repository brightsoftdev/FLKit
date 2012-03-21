//
//  NSObject+FLKit.m
//  FLKit
//
//  Created by Wess Cope on 3/20/12.
//  Copyright (c) 2012 FrenzyLabs. All rights reserved.
//

#import "NSObject+FLKit.h"
#import "FLMacros.h"

@implementation NSObject (FLKit)

- (void)execute:(FLBlock)block callBack:(FLBlock)callback
{
    dispatch_async(GLOBAL_QUEUE, ^{
        block();
        dispatch_sync(MAIN_QUEUE, ^{
            callback(); 
        });
    });
}

+ (void)execute:(FLBlock)block callBack:(FLBlock)callback
{
    dispatch_async(GLOBAL_QUEUE, ^{
        block();
        dispatch_sync(MAIN_QUEUE, ^{
            callback(); 
        });
    });    
}

@end
