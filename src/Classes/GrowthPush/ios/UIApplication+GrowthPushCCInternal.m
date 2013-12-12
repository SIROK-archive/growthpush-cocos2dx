//
//  UIApplication+GrowthPushCCInternal.m
//  growthpush-cocos2dx
//
//  Created by TSURUDA Ryo on 2013/12/08.
//  Copyright (c) 2013年 TSURUDA Ryo. All rights reserved.
//

#import "UIApplication+GrowthPushCCInternal.h"

#import <objc/runtime.h>

#import "GrowthPushCCInternal.h"

@implementation UIApplication (GrowthPushCCInternal)

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
           @selector(application:didFinishLaunchingWithOptions:),
           @selector(application:gp_didFinishLaunchingWithOptions:),
           (IMP)gp_didFinishLaunchingWithOptionsRuntime);
    swizze(delegateClass,
           @selector(application:didReceiveRemoteNotification:),
           @selector(application:gp_didReceiveRemoteNotification:),
           (IMP)gp_didReceiveRemoteNotificationRuntime);
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

BOOL gp_didFinishLaunchingWithOptionsRuntime(id self, SEL aSel, id application, id launchOptions)
{
    [GrowthPushCCInternal didFinishLaunchingWithOptions:launchOptions];
    
    if ([self respondsToSelector:@selector(application:gp_didFinishLaunchingWithOptions:)]) {
		return [self application:application gp_didFinishLaunchingWithOptions:launchOptions];
	}
    return YES;
}

void gp_didReceiveRemoteNotificationRuntime(id self, SEL aSel, id application, id userInfo)
{
    [GrowthPushCCInternal didReceiveRemoteNotification:userInfo];
    
    if ([self respondsToSelector:@selector(application:gp_didReceiveRemoteNotification:)]) {
		return [self application:application gp_didReceiveRemoteNotification:userInfo];
	}
}

void gp_didRegisterForRemoteNotificationsWithDeviceTokenRuntime(id self, SEL aSel, id application, id deviceToken)
{
    [GrowthPushCCInternal didRegisterForRemoteNotificationsWithDeviceToken:deviceToken];
    
    if ([self respondsToSelector:@selector(application:gp_didRegisterForRemoteNotificationsWithDeviceToken:)]) {
        [self application:application gp_didRegisterForRemoteNotificationsWithDeviceToken:deviceToken];
    }
}

void gp_didFailToRegisterForRemoteNotificationsWithErrorRuntime(id self, SEL aSel, id application, id error)
{
    [GrowthPushCCInternal didFailToRegisterForRemoteNotificationsWithError:error];
    
    if ([self respondsToSelector:@selector(application:gp_didFailToRegisterForRemoteNotificationsWithError:)]) {
        [self application:application gp_didFailToRegisterForRemoteNotificationsWithError:error];
    }
}

@end
