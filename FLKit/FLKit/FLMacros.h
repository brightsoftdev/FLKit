//
//  FLMacros.h
//  FLKit
//
//  Created by Wess Cope on 3/20/12.
//  Copyright (c) 2012 FrenzyLabs. All rights reserved.
//

#ifndef FL_MACROS
#define FL_MACROS

/* Language Short hands */
#define AND &&
#define OR  ||

#define RED             [UIColor redColor]
#define WHITE           [UIColor whiteColor]
#define BLACK           [UIColor blackColor]
#define BLUE            [UIColor blueColor]
#define GREEN           [UIColor greenColor]
#define YELLOW          [UIColor yellowColor]
#define GRAY            [UIColor grayColor]
#define LIGHTGRAY       [UIColor lightGrayColor]
#define CLEAR           [UIColor clearColor]
#define HEX_COLOR(hex)  [UIColor fromHexString:hex]

/* System Shorthand */

#define APP_DELEGATE(delegateName)    ((delegateName *)[[UIApplication sharedApplication] delegate])

#define SCREEN_BOUNDS   [[UIScreen mainScreen] bounds]
#define APP_FRAME       [[UIScreen mainScreen] applicationFrame]

#define IS_IPAD         (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)? YES : NO

#define DEVICE_ORIENTATION          [[UIDevice currentDevice] orientation]
#define IS_LANDSCAPE                UIDeviceOrientationIsLandscape(DEVICE_ORIENTATION)
#define IS_PORTRAIT                 UIDeviceOrientationIsPortrait(DEVICE_ORIENTATION)

#define ORIENTATION_BOUNDS  \
CGRectMake((IS_LANDSCAPE)? SCREEN_BOUNDS.origin.y : SCREEN_BOUNDS.origin.x, \
(IS_LANDSCAPE)? SCREEN_BOUNDS.origin.y : SCREEN_BOUNDS.origin.x,        \
(IS_LANDSCAPE)? SCREEN_BOUNDS.size.height : SCREEN_BOUNDS.size.width,   \
(IS_LANDSCAPE)? SCREEN_BOUNDS.size.width : SCREEN_BOUNDS.size.height)

#define KEY_WINDOW                      [[UIApplication sharedApplication] keyWindow]
#define UIVIEW_ZERO                     [[UIView alloc] initWithFrame:CGRectZero]
#define VIEW_ZERO(class)                [[class alloc] initWithFrame:CGRectZero]
#define VIEW_ZERO_AUTORELEASE(class)    [VIEW_ZERO(class)] autorelease]

#define FLEX_BOTTOM UIViewAutoresizingFlexibleBottomMargin
#define FLEX_TOP    UIViewAutoresizingFlexibleTopMargin
#define FLEX_LEFT   UIViewAutoresizingFlexibleLeftMargin
#define FLEX_RIGHT  UIViewAutoresizingFlexibleRightMargin
#define FLEX_WIDTH  UIViewAutoresizingFlexibleWidth
#define FLEX_HEIGHT UIViewAutoresizingFlexibleHeight
#define FLEX_NONE   UIViewAutoresizingNone
#define FLEX_ALL    FLEX_BOTTOM | FLEX_TOP | FLEX_LEFT | FLEX_RIGHT | FLEX_WIDTH | FLEX_HEIGHT
#define FLEX_SIZE   FLEX_WIDTH | FLEX_HEIGHT
#define FLEX_ORIGIN FLEX_BOTTOM | FLEX_TOP | FLEX_LEFT | FLEX_RIGHT

#define IMAGE_FROM_URL(url)     [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:url]]]
#define BACKGROUND_PATTERN(img) [UIColor colorWithPatternImage:img]
#define FILL_RECT(color, rect)  [color set]; UIRectFill(rect)
#define DRAW_LINE(startPoint, endPoint, color) [[UIBezierPath bezierPath] drawFrom:startPoint To:endPoint withColor:color]

#define VERTICAL_GRADIENT(tC,bC,withRect)                                                                                                   \
CGColorRef topColor		= [tC CGColor];                                                                                         \
CGColorRef bottomColor	= [bC CGColor];                                                                                         \
CGFloat locations[]		= {0, 1};                                                                                               \
NSArray *gradientColors	= [NSArray arrayWithObjects:(__bridge id)topColor, (__bridge id)bottomColor, nil];                                        \
CGGradientRef gradient	= CGGradientCreateWithColors(CGColorGetColorSpace(topColor), (__bridge CFArrayRef)gradientColors, locations);	\
CGPoint top				= CGPointMake(CGRectGetMidX(withRect), withRect.origin.y);                                              \
CGPoint btm				= CGPointMake(CGRectGetMidX(withRect), CGRectGetMaxY(withRect));                                        \
CGContextRef context	= UIGraphicsGetCurrentContext();																		\
CGContextDrawLinearGradient(context, gradient, top, btm, 0); CGGradientRelease(gradient)

#define HORIZONTAL_GRADIENT(lc, rc, withRect)                                                                                               \
CGColorRef leftColor	= [lc CGColor];                                                                                         \
CGColorRef rightColor	= [rc CGColor];                                                                                         \
CGFloat locations[]		= {0, 1};																								\
NSArray *gradientColors	= [NSArray arrayWithObjects:(__bridge id)leftColor, (__bridge id)rightColor, nil];										\
CGGradientRef gradient	= CGGradientCreateWithColors(CGColorGetColorSpace(leftColor), (__bridge CFArrayRef)gradientColors, locations);	\
CGPoint left			= CGPointMake(CGRectGetMinX(withRect), CGRectGetMinY(withRect));                                        \
CGPoint right			= CGPointMake(CGRectGetMaxX(withRect), CGRectGetMinY(withRect));                                        \
CGContextRef context	= UIGraphicsGetCurrentContext();																		\
CGContextDrawLinearGradient(context, gradient, left, right, 0); CGGradientRelease(gradient)

#define LAYER_DROP_SHADOW(view, color, offset, opacity, radius) \
view.layer.shadowColor = color.CGColor; \
view.layer.shadowOffset = offset;       \
view.layer.shadowOpacity = opacity;     \
view.layer.shadowRadius = radius

#ifdef DEBUG
#   define DEBUG_LOG(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#   define DEBUG_LOG(...)
#endif

// Data
#define CGFONT_REF(withFont)    CGFontCreateWithFontName((CFStringRef)[withFont fontName]);
#define NOT_AT_ALL(item)        !item || [item isEqual:[NSNull null]] || [item isEqualToString:@"(null)"]
#define KVO_NEW                 NSKeyValueObservingOptionNew
#define KVO_OLD                 NSKeyValueObservingOptionOld

// Singleton Method
#define SINGLETON(classname) \
+(classname *)instance { \
static dispatch_once_t onetime; \
static classname *shared = nil; \
dispatch_once(&onetime, ^{ \
shared = [[classname alloc] init];  \
}); \
return shared; \
}

// Queues
#define GLOBAL_QUEUE            dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
#define MAIN_QUEUE              dispatch_get_main_queue()

// Threads
#define isOnMainThread          [[NSThread currentThread] isEqual:[NSThread mainThread]]

// AppSetup
#define PLIST_GET(plist, key)                  [[NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:plist ofType:@"plist"]] objectForKey:key]

// User Defaults
#define GET_USER_DEFAULT(key)       [[NSUserDefaults standardUserDefaults] valueForKey:key]
#define GET_USER_DEFAULT_INT(key)   [[NSUserDefaults standardUserDefaults] integerForKey:key]
#define GET_USER_OBJECT(key)        [[NSUserDefaults standardUserDefaults] objectForKey:key]

#define SET_USER_DEFAULT(key, val)          [[NSUserDefaults standardUserDefaults] setValue:val     forKey:key]
#define SET_USER_DEFAULT_OBJECT(key, obj)   [[NSUserDefaults standardUserDefaults] setObject:obj    forKey:key]
#define SET_USER_DEFAULT_INT(key, intgr)    [[NSUserDefaults standardUserDefaults] setInteger:intgr forKey:key]

#define SYNC_USER_DEFAULTS                  [[NSUserDefaults standardUserDefaults] synchronize]

#ifndef DEGREES_TO_RADIANS
#define DEGREES_TO_RADIANS(d) ((d) * 0.0174532925199432958)
#endif

#ifndef RADIANS_TO_DEGREES
#define RADIANS_TO_DEGREES(r) ((r) * 57.29577951308232)
#endif

#ifndef __has_feature
    #define __has_feature(x) 0
#endif

#if __has_feature(objc_arc)
    #define IF_ARC(yes, no) yes
#else
    #define IF_ARC(yes, no) no
#endif

// Shorthand
#define NEW(className)  IF_ARC([[className alloc] init], [[[className alloc] init] autorelease])

#define DICT(...)           [NSDictionary dictionaryWithObjectsAndKeys:__VA_ARGS__, nil]
#define NEW_DICT            [NSDictionary dictionary]

#define MUTABLE_DICT(...)   [NSMutableDictionary dictionaryWithObjectsAndKeys:__VA_ARGS__, nil]
#define NEW_MUTABLE_DICT    [NSMutableDictionary dictionary]

#define ARRAY(...)          [NSArray arrayWithObjects:__VA_ARGS__, nil]
#define NEW_ARRAY           [NSArray array]

#define MUTABLE_ARRAY(...)  [NSMutableArray arrayWithObjects:__VA_ARGS__, nil]
#define NEW_MUTABLE_ARRAY   [NSMutableArray array]

#define STRING_FORMAT(...)  [NSString stringWithFormat:__VA_ARGS__]





#endif