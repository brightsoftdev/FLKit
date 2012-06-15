//
//  UILabel+FLKit.m
//  FLKit
//
//  Created by Wess Cope on 3/20/12.
//  Copyright (c) 2012 FrenzyLabs. All rights reserved.
//

#import "UILabel+FLKit.h"

@implementation UILabel (FLKit)
- (void)alignTop 
{
    CGSize fontSize         = [self.text sizeWithFont:self.font];
    double finalHeight      = fontSize.height * self.numberOfLines;
    double finalWidth       = self.frame.size.width;    //expected width of label
    CGSize theStringSize    = [self.text sizeWithFont:self.font constrainedToSize:CGSizeMake(finalWidth, finalHeight) lineBreakMode:self.lineBreakMode];
    int newLinesToPad       = (finalHeight  - theStringSize.height) / fontSize.height;
    
    for(int i=0; i<newLinesToPad; i++)
        self.text = [self.text stringByAppendingString:@"\n "];
}

- (void)alignBottom 
{
    CGSize fontSize         = [self.text sizeWithFont:self.font];
    double finalHeight      = fontSize.height * self.numberOfLines;
    double finalWidth       = self.frame.size.width;    //expected width of label
    CGSize theStringSize    = [self.text sizeWithFont:self.font constrainedToSize:CGSizeMake(finalWidth, finalHeight) lineBreakMode:self.lineBreakMode];
    int newLinesToPad       = (finalHeight  - theStringSize.height) / fontSize.height;
    
    for(int i=0; i<newLinesToPad; i++)
        self.text = [NSString stringWithFormat:@" \n%@",self.text];
}

- (void)sizeToFitFixedWidth:(NSInteger)fixedWidth
{
    self.frame          = CGRectMake(self.frame.origin.x, self.frame.origin.y, fixedWidth, 0);

#ifdef __IPHONE_6_0
	self.lineBreakMode  = NSLineBreakByWordWrapping;
#else
    self.lineBreakMode  = UILineBreakModeWordWrap; //NSLineBreakByWordWrapping
#endif

    self.lineBreakMode  = UILineBreakModeWordWrap; //NSLineBreakByWordWrapping
    self.numberOfLines  = 0;
    
    [self sizeToFit];
}

- (void)adjustHeightForString:(NSString *)str
{
    CGSize maximumLabelSize     = CGSizeMake(self.frame.size.width,9999);
    CGSize expectedLabelSize    = [str sizeWithFont:self.font constrainedToSize:maximumLabelSize lineBreakMode:self.lineBreakMode]; 

    CGRect newFrame             = self.frame;
    newFrame.size.height        = expectedLabelSize.height;
    self.frame                  = newFrame;
}

@end
