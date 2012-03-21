//
//  UIImage+FLKit.m
//  FLKit
//
//  Created by Wess Cope on 3/20/12.
//  Copyright (c) 2012 FrenzyLabs. All rights reserved.
//

#import "UIImage+FLKit.h"
#import <QuartzCore/QuartzCore.h>
#import "FLMacros.h"

@implementation UIImage (FLKit)
static NSMutableDictionary *flSimpleImageCache;

#pragma mark - Resizing / Scaling
- (UIImage *)imageWithNewSize:(CGSize)newSize
{
    CGRect toRect           = CGRectIntegral(CGRectMake(0.0f, 0.0f, newSize.width, newSize.height));
    CGImageRef imageRef     = self.CGImage;
    
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0f);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetInterpolationQuality(context, kCGInterpolationHigh);
    CGContextConcatCTM(context, CGAffineTransformMake(1, 0, 0, -1, 0, newSize.height));
    CGContextDrawImage(context, toRect, imageRef);
    
    UIImage *resizedImage       = [UIImage imageWithCGImage:CGBitmapContextCreateImage(context)];
    
    UIGraphicsEndImageContext();
    
    return resizedImage;
}

- (UIImage *)ratioScaleToRect:(CGRect)frame fromSize:(CGSize)size
{
	CGSize frameSize = frame.size;
	CGSize imageSize = (CGSizeEqualToSize(size, CGSizeZero))? self.size : size;
	CGFloat ratio = imageSize.width/imageSize.height;
    
	CGFloat newWidth, 
            newHeight, 
            widthDifference, 
            heightDifference;
	
	if(imageSize.width > frameSize.width && imageSize.height > frameSize.height)
	{
		widthDifference = imageSize.width - frameSize.width;
        
		if(imageSize.height > frameSize.height)
			heightDifference = imageSize.height - frameSize.height;
		
		if(heightDifference >= widthDifference)
		{
			newHeight   = frameSize.height;
			newWidth    = newHeight*ratio;
		}
		else
		{
			newWidth    = frameSize.width;
			newHeight   = newWidth/ratio;
		}
        
	}
	else if(imageSize.width > frameSize.width)
	{
		newWidth    = frameSize.width;
		newHeight   = newWidth/ratio;		
	}
	else if(imageSize.height > frameSize.height)
	{
		newHeight   = frameSize.height;
		newWidth    = newHeight*ratio;		
	}
	else 
	{
		newWidth    = imageSize.width;
		newHeight   = imageSize.height;
	}
    
	return [self imageWithNewSize:CGSizeMake(newWidth, newHeight)];
}

- (UIImage *)scaleImageToWidth:(CGFloat)width
{
    return [self imageWithNewSize:CGSizeMake(width, ((width * self.size.height) / self.size.width))];
}

- (UIImage *)scaleImageToHeight:(CGFloat)height
{
    return [self imageWithNewSize:CGSizeMake(((self.size.width * height) / self.size.height), height)];
}

#pragma mark - Color/Effects
- (UIImage *)fillImageWithColor:(UIColor *)color
{
    UIGraphicsBeginImageContextWithOptions([self size], NO, 0.0);
    CGRect rect = CGRectZero;
    rect.size = self.size;
    
    [color set];
    UIRectFill(rect);
    
    [self drawInRect:rect blendMode:kCGBlendModeDestinationIn alpha:1.0];
    
    UIImage *filledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return filledImage;
}

#pragma mark - Cropping
- (UIImage *)cropImageToInset:(CGFloat)inset
{
    CGRect imageRect = CGRectMake(0.0f, 0.0f, self.size.width, self.size.height);
    CGRect newFrame  = CGRectInset(imageRect, inset, inset);
    
    return [self cropImageToSizeFromCenter:newFrame.size];
}

- (UIImage *)cropImageToSizeFromCenter:(CGSize)size
{
    return [self cropImageToSize:size atPoint:CGPointMake(((self.size.width - size.width) * 0.5f), ((self.size.height - size.height) * 0.5f))];
}

- (UIImage *)cropImageToSize:(CGSize)size
{
    return [self cropImageToSize:size atPoint:CGPointMake(0.0f, 0.0f)];
}

- (UIImage *)cropImageToSize:(CGSize)size atPoint:(CGPoint)point
{
    CGRect newFrame = CGRectZero;
    newFrame.size   = size;
    newFrame.origin = point;
    
    return [UIImage imageWithCGImage:CGImageCreateWithImageInRect(self.CGImage, newFrame)];
}

#pragma mark - Image Loading/Caching

+ (UIImage *)imageFromURL:(id)url
{
    return [UIImage imageFromURL:url useCache:NO];
}

+ (UIImage *)imageFromURL:(id)url useCache:(BOOL)useCache
{
    NSString *urlClass = [(NSStringFromClass([url class])) uppercaseString];
    
    NSURL *imageURL;
    NSString *imageKey;
    if([urlClass isEqualToString:@"NSSTRING"])
    {
        imageURL = [NSURL URLWithString:url];
        imageKey = url;
    }
    else if([urlClass isEqualToString:@"NSURL"])
    {
        imageURL = url;
        imageKey = [imageURL absoluteString];
    }

    if(!useCache)
        return [UIImage imageWithData:[NSData dataWithContentsOfURL:imageURL]];

    UIImage *cached = [flSimpleImageCache objectForKey:imageKey];
    
    if(cached)
        return cached;
    
    UIImage *newImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:imageURL]];
    [flSimpleImageCache setObject:newImage forKey:imageKey];
    
    return newImage;    
}

@end
