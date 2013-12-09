//
//  UIApplication+GrowthPushPlugin.m
//  GrowthPushPlugin
//
//  Created by TSURUDA Ryo on 2013/12/08.
//  Copyright (c) 2013年 TSURUDA Ryo. All rights reserved.
//

#import "UIApplication+GrowthPushPlugin.h"

#import <objc/runtime.h>

#import "GrowthPushInternal.h"

@implementation UIApplication (GrowthPushPlugin)

void swizze(Class cls, SEL oldSelector, SEL newSelector, IMP imp)
{
    Method oldMethod = class_getInstanceMethod(cls, oldSelector);
    if (oldMethod) {
        class_addMethod(cls, newSelector, imp, method_getTypeEncoding(oldMethod));
        method_exchangeImplementations(oldMethod, class_getInstanceMethod(cls, newSelector));
    } else {
        class_addMethod(cls, oldSelector, imp, method_getTypeEncoding(oldMethod));
    }
}

+ (void)load
{
    Method originalMethod = class_getInstanceMethod(self, @selector(setDelegate:));
    Method alternativeMethod = class_getInstanceMethod(self, @selector(setGrowthPushPluginDelegate:));
    method_exchangeImplementations(originalMethod, alternativeMethod);
}

- (void)setGrowthPushPluginDelegate:(id<UIApplicationDelegate>)delegate
{
    static Class delegateClass = nil;
    if (delegateClass == [delegate class]) {
        [self setGrowthPushPluginDelegate:delegate];
        return;
    }
    
    delegateClass = [delegate class];
    swizze(delegateClass,
           @selector(application:didRegisterForRemoteNotificationsWithDeviceToken:),
           @selector(application:gp_didRegisterForRemoteNotificationsWithDeviceToken:),
           (IMP)gp_didRegisterForRemoteNotificationsWithDeviceTokenRuntime);
    swizze(delegateClass,
           @selector(application:didFailToRegisterForRemoteNotificationsWithError:),
           @selector(application:gp_didFailToRegisterForRemoteNotificationsWithError:),
           (IMP)gp_didFailToRegisterForRemoteNotificationsWithErrorRuntime);
    [self setGrowthPushPluginDelegate:delegate];
}

void gp_didRegisterForRemoteNotificationsWithDeviceTokenRuntime(id self, SEL aSel, id application, id deviceToken)
{
    [GrowthPushInternal setDeviceToken:deviceToken];
    
    if ([self respondsToSelector:@selector(application:gp_didRegisterForRemoteNotificationsWithDeviceToken:)]) {
        [self application:application gp_didRegisterForRemoteNotificationsWithDeviceToken:deviceToken];
    }
}

void gp_didFailToRegisterForRemoteNotificationsWithErrorRuntime(id self, SEL aSel, id application, id error)
{
    if ([self respondsToSelector:@selector(application:gp_didFailToRegisterForRemoteNotificationsWithError:)]) {
        [self application:application gp_didFailToRegisterForRemoteNotificationsWithError:error];
    }
}

@end
