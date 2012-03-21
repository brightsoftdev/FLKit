//
//  NSArray+FLKit.h
//  FLKit
//
//  Created by Wess Cope on 3/20/12.
//  Copyright (c) 2012 FrenzyLabs. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^FLNSArrayEachBlock)(id item, int index);
typedef BOOL (^FLCheckCallback)(id object);

@interface NSArray (FLKit)

- (void)each:(FLNSArrayEachBlock)block;
- (NSArray *)select:(FLCheckCallback)callback;

- (NSString *)join;
- (NSString *)join:(NSString *)character;
@end

@interface NSMutableArray(FLKit)
- (NSMutableArray *)push:(id)object;
- (id)pop;
- (NSMutableArray *)unshift:(id)object;
- (id)shift;
@end
