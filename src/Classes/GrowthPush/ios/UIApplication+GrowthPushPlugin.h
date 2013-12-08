//
//  UIApplication+GrowthPushPlugin.h
//  GrowthPushPlugin
//
//  Created by TSURUDA Ryo on 2013/12/08.
//  Copyright (c) 2013年 TSURUDA Ryo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIApplication (GrowthPushPluginInterface)

- (void)application:(UIApplication *)application gp_didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)devToken;
- (void)application:(UIApplication *)application gp_didFailToRegisterForRemoteNotificationsWithError:(NSError *)error;

@end
