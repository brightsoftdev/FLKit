//
//  UIControl+FLKit.m
//  FLKit
//
//  Created by Wess Cope on 3/21/12.
//  Copyright (c) 2012 FrenzyLabs. All rights reserved.
//

#import "UIControl+FLKit.h"
#import <objc/runtime.h>
#import "NSArray+FLKit.h"

@interface FLControlCallback : NSObject
{
@private
    FLEventCallback callback;
    UIControlEvents events;
}

- (id)initWithCallback:(FLEventCallback)block forEvents:(UIControlEvents)controlEvents;
- (void)execute:(id)sender;

@property (copy) FLEventCallback callback;
@property (assign) UIControlEvents events;

@end

@implementation FLControlCallback 
@synthesize callback, events;

- (id)initWithCallback:(FLEventCallback)block forEvents:(UIControlEvents)controlEvents
{
    self = [super init];
    if(self)
    {
        self.callback = block;
        self.events = controlEvents;
    }
    
    return self;
}

- (void)execute:(id)sender
{
    FLEventCallback action = self.callback;
    
    if(action)
        dispatch_async(dispatch_get_main_queue(), ^{ action(sender); });
}

@end

@implementation UIControl(FLKit)

- (void)on:(UIControlEvents)events callback:(FLEventCallback)callback
{
    NSMutableArray *currentEvents = objc_getAssociatedObject(self, "FL_CONTROL_EVENT");
    
    if(!currentEvents)
    {
        currentEvents = [[NSMutableArray alloc] init];
        objc_setAssociatedObject(self, "FL_CONTROL_EVENT", currentEvents, OBJC_ASSOCIATION_COPY_NONATOMIC);
    }
    
    FLControlCallback *element = [[FLControlCallback alloc] initWithCallback:callback forEvents:events];
    [currentEvents addObject:element];
    [self addTarget:element action:@selector(execute:) forControlEvents:events];
}

- (void)remove:(UIControlEvents)events
{
    NSMutableArray *currentEvents;
    if ((currentEvents = objc_getAssociatedObject(self, "FL_CONTROL_EVENT")))
    {
        [currentEvents removeObjectsInArray:[currentEvents select:^BOOL(id sender) {
            if ([sender isKindOfClass:[FLControlCallback class]])
                return ([(FLControlCallback*)sender events] == events);
            
            return NO;
        }]];        
    }
}
@end
