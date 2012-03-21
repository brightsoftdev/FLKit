//
//  NSData+FLKit.h
//  FLKit
//
//  Created by Wess Cope on 3/20/12.
//  Copyright (c) 2012 FrenzyLabs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (FLKit)
+ (NSData *) dataFromBase64EncodedString:(NSString *)string;
- (id) initFromBase64EncodedString:(NSString *)string;
- (NSString *) base64EncodeWithLength:(unsigned int)length;
@end
