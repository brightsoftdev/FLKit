//
//  UIImage+FLKit.m
//  FLKit
//
//  Created by Wess Cope on 3/20/12.
//  Copyright (c) 2012 FrenzyLabs. All rights reserved.
//

#import "UIImage+FLKit.h"
#import <QuartzCore/QuartzCore.h>

@implementation UIImage (FLKit)

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


@end
