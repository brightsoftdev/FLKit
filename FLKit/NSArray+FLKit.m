//
//  NSArray+FLKit.m
//  FLKit
//
//  Created by Wess Cope on 3/20/12.
//  Copyright (c) 2012 FrenzyLabs. All rights reserved.
//

#import "NSArray+FLKit.h"

@implementation NSArray (FLKit)
- (void)each:(FLNSArrayEachBlock)block
{
    for(int i = 0; i < self.count; i++)
        block([self objectAtIndex:i], i);
}

- (NSArray *)select:(FLCheckCallback)callback
{
    NSMutableArray *results = [[NSMutableArray alloc] initWithCapacity:self.count];
    
    for(id item in self)
        if(callback(item))
            [results addObject:item];
    
    return (results.count)? [results copy] : nil;
}

- (NSString *)join
{
    return [self componentsJoinedByString:@""];
}

- (NSString *)join:(NSString *)character
{
    return [self componentsJoinedByString:character];    
}

@end

@implementation NSMutableArray (FLKit)

- (NSMutableArray *)push:(id)object
{
    [self addObject:object];
    return self;
}

- (id)pop
{
    id = [self lastObject];
    [self removeLastObject];
    return id;
}

- (NSMutableArray *)unshift:(id)object
{
    [self insertObject:object atIndex:0];
    return self;
}

- (id)shift
{
    id object = [self objectAtIndex:0];
    [self removeObjectAtIndex:0];
    return object;
}


@end