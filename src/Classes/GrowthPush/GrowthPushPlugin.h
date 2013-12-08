//
//  GrowthPushPlugin.h
//  GrowthPushPlugin
//
//  Created by TSURUDA Ryo on 2013/12/07.
//  Copyright (c) 2013年 TSURUDA Ryo. All rights reserved.
//

#ifndef GROWTHPUSHPLUGIN_GROWTHPUSHPLUGIN_H_
#define GROWTHPUSHPLUGIN_GROWTHPUSHPLUGIN_H_

#include "ccMacros.h"  // for CC_DLL

#include "GPEnvironment.h"
#include "EGPOption.h"

NS_GROWTHPUSH_BEGIN

class CC_DLL GrowthPushPlugin
{
public:
    /**
     * Initialize GrowthPush instance and register the client device if not yet been registered
     *
     * @param applicationId Application ID
     * @param secret Secret key for application
     * @param environment Build configuration (debug or release)
     * @param debug Debug mode
     */
    static void initialize(int applicationId, const char *secret, growthpush::GPEnvironment environment, bool debug);
    
    /**
     * Initialize GrowthPush instance and register the client device if not yet been registered (Only iOS)
     *
     * @param applicationId Application ID
     * @param secret Secret key for application
     * @param environment Build configuration (debug or release)
     * @param debug Debug mode
     * @param option option flags
     */
#if (CC_TARGET_PLATFORM == CC_PLATFORM_IOS)
    static void initialize(int applicationId, const char *secret, growthpush::GPEnvironment environment, bool debug, growthpush::EGPOption option);
#endif
    
    /**
     * Request APNS device token and set device token (Only iOS)
     *
     */
#if (CC_TARGET_PLATFORM == CC_PLATFORM_IOS)
    static void registerDeviceToken(void);
#endif
    
    /**
     * Set device token (Only Android)
     *
     * @param senderID Google Project Number
     */
#if (CC_TARGET_PLATFORM == CC_PLATFORM_ANDROID)
    static void registerDeviceToken(const char *senderId);
#endif
    
    /**
     * Track event
     *
     * @param name Event name such as "Launch" (max 64 characters)
     */
    static void trackEvent(const char *name);
    
    /**
     * Track event with additional information
     *
     * @param name Event name (max 64 characters)
     * @param value Additional information
     */
    static void trackEvent(const char *name, const char *value);
    
    /**
     * Create a tag for the device
     *
     * @param name Tag name such as "Finished Tutorial" (max 64 characters)
     */
    static void setTag(const char *name);
    
    /**
     * Create a tag with value for the device
     *
     * @param name Tag name such as "Gender" (max 64 characters)
     * @param value Tag value such as "male"
     */
    static void setTag(const char *name, const char *value);
    
    /**
     * Create tags including device model, OS version, language, time zone and app version
     */
    static void setDeviceTags(void);
    
    /**
     * Clear badge of app icon (Only iOS)
     */
#if (CC_TARGET_PLATFORM == CC_PLATFORM_IOS)
    static void clearBadge(void);
#endif
    
private:
    GrowthPushPlugin(void);
    virtual ~GrowthPushPlugin(void);
};

NS_GROWTHPUSH_END

#endif  // GROWTHPUSHPLUGIN_GROWTHPUSHPLUGIN_H_
