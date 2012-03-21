//
//  NSString+FLKit.h
//  FLKit
//
//  Created by Wess Cope on 3/20/12.
//  Copyright (c) 2012 FrenzyLabs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (FLKit)

- (NSString *)append:(NSString *)string;
- (NSString *)prepend:(NSString *)string;
- (NSArray *)split:(NSString *)character;
- (NSArray *)split;

// Helpers
- (BOOL) isValidEmail;
- (NSString *)URLEncode;
- (NSString *)escapeHTML;
- (NSString *)unescapeHTML;
- (NSString *)stringByRemovingHTML;
- (NSString *)capitalizeFirstLetter;
- (NSString *) md5;
+ (NSString *) uuid;

// For phone numbers:
+ (NSDictionary *) sharedPhoneFormats;
- (BOOL)canBeInputByPhonePad:(char)c;
- (NSString *)strip:(NSString *)phoneNumber;
- (NSString *)formattedPhoneNumber;
- (NSString *)substringAfterRange:(NSRange)range;

@end

@interface NSMutableString (FLKit)
- (NSMutableString *)append:(NSString * )string;
- (NSMutableString *)prepend:(NSString *)string;
- (NSMutableString *)insert:(NSString *)string atIndex:(NSUInteger)index;
@end