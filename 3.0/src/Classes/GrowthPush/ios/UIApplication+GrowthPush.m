//
//  UIApplication+GrowthPush.m
//  sampleProject
//
//  Created by Kataoka Naoyuki on 2014/04/24.
//
//

#include "CCPlatformConfig.h"
#if CC_TARGET_PLATFORM == CC_PLATFORM_IOS

#import "UIApplication+GrowthPush.h"

#import <objc/runtime.h>

#import "GPAppDelegateWrapper.h"
#import "GPAppDelegateIntercepter.h"

@interface UIApplication ()

- (void)setDelegateWithWrapping:(id<UIApplicationDelegate>)delegate;

@end

@implementation UIApplication (GrowthPush)

+ (void) load {
    
    Method setDelegateMethod = class_getInstanceMethod(self, @selector(setDelegate:));
    IMP setDelegateWithWrappingImplementation = method_getImplementation(class_getInstanceMethod(self, @selector(setDelegateWithWrappingImplementation:)));
    class_addMethod(self, @selector(setDelegateWithWrapping:), setDelegateWithWrappingImplementation, method_getTypeEncoding(setDelegateMethod));
    method_exchangeImplementations(setDelegateMethod, class_getInstanceMethod(self, @selector(setDelegateWithWrapping:)));
    
}
                    
- (void)setDelegateWithWrappingImplementation:(id<UIApplicationDelegate>)delegate {
    
    if([delegate class] == [GPAppDelegateWrapper class])
        return;
    
    GPAppDelegateWrapper *appDelegateWrapper = [[GPAppDelegateWrapper alloc] init];
    [appDelegateWrapper setOriginalAppDelegate:delegate];
    GPAppDelegateIntercepter *appDelegateIntercepter = [[GPAppDelegateIntercepter alloc] init];
    [appDelegateWrapper setDelegate:appDelegateIntercepter];
    [self setDelegateWithWrapping:appDelegateWrapper];
    
}

@end

#endif /* if CC_TARGET_PLATFORM == CC_PLATFORM_IOS */
