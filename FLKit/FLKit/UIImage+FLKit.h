//
//  UIImage+FLKit.h
//  FLKit
//
//  Created by Wess Cope on 3/20/12.
//  Copyright (c) 2012 FrenzyLabs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (FLKit)
// Resizing
- (UIImage *)imageWithNewSize:(CGSize)newSize;
- (UIImage *)ratioScaleToRect:(CGRect)frame fromSize:(CGSize)size;
- (UIImage *)scaleImageToWidth:(CGFloat)width;
- (UIImage *)scaleImageToHeight:(CGFloat)height;

// Cropping
- (UIImage *)fillImageWithColor:(UIColor *)color;
- (UIImage *)cropImageToInset:(CGFloat)inset;
- (UIImage *)cropImageToSizeFromCenter:(CGSize)size;
- (UIImage *)cropImageToSize:(CGSize)size;
- (UIImage *)cropImageToSize:(CGSize)size atPoint:(CGPoint)point;

// Loading from URL
+ (UIImage *)imageFromURL:(id)url;
+ (UIImage *)imageFromURL:(id)url useCache:(BOOL)useCache;
@end
