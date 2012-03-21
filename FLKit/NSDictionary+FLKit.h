//
//  NSDictionary+FLKit.h
//  FLKit
//
//  Created by Wess Cope on 3/20/12.
//  Copyright (c) 2012 FrenzyLabs. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^FLNSDictionaryEachBlock)(id key, id object);
@interface NSDictionary (FLKit)
// Short hand Enumerator
- (void)each:(FLNSDictionaryEachBlock)block;

// JSON shortcuts 

+ (NSDictionary *)dictionaryFromJSONString:(NSString *)jsonString;
+ (NSDictionary *)dictionaryWithContentsOfJSONURLString:(NSString *)url;

- (NSData *)toJSONData;
- (NSString *)toJSONString;


@end
