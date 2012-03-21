//
//  NSDictionary+FLKit.m
//  FLKit
//
//  Created by Wess Cope on 3/20/12.
//  Copyright (c) 2012 FrenzyLabs. All rights reserved.
//

#import "NSDictionary+FLKit.h"

@implementation NSDictionary (FLKit)

- (void)each:(FLNSDictionaryEachBlock)block
{
    [self enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        block(key, obj);
    }];
}

#pragma mark - JSON Shortcuts
+ (NSDictionary *) dictionaryFromJSONString:(NSString *)jsonString
{
    __autoreleasing NSError *error = nil;
    NSDictionary *result = [NSJSONSerialization JSONObjectWithData:[jsonString dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers | NSJSONWritingPrettyPrinted error:&error];
    if(error)
    {
        NSLog(@"JSON FROM STRING ERROR (NSDictionary+FLJSON): %@", [error userInfo]);
        return nil;
    }
    
    return result;
}

+ (NSDictionary *)dictionaryWithContentsOfJSONURLString:(NSString *)url
{
    NSData *data =[NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
    __autoreleasing NSError *error = nil;
    id result = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    
    if(error != nil)
    {
        NSLog(@"JSON REQUEST ERROR (NSDictionary+FLJSON): %@", [error userInfo]);
        return nil;
    }
    
    return result;
}

- (NSData *)toJSONData
{
    __autoreleasing NSError *error = nil;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self options:kNilOptions error:&error];
    
    if(error)
    {
        NSLog(@"toJSON ERROR (NSDictionary+FLJSON): %@", [error userInfo]);
        return nil;
    }
    
    return jsonData;
}

- (NSString *)toJSONString
{
    NSData *jsonData = [self toJSONData];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    return jsonString;
}


@end
