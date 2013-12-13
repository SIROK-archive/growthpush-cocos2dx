//
//  GrowthPush.h
//  growthpush-cocos2dx
//
//  Created by TSURUDA Ryo on 2013/12/07.
//  Copyright (c) 2013年 TSURUDA Ryo. All rights reserved.
//

#ifndef GROWTHPUSHPLUGIN_GROWTHPUSH_H_
#define GROWTHPUSHPLUGIN_GROWTHPUSH_H_

#include "ccMacros.h"  // for CC_DLL

#include "GPEnvironment.h"
#include "EGPOption.h"

NS_GROWTHPUSH_BEGIN

/* APNS/GCM did received notification */
static const char *const kGPDidReceiveRemoteNotification = "GPDidReceiveRemoteNotification";

class CC_DLL GrowthPush
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
    static void initialize(int applicationId, const char *secret, GPEnvironment environment, bool debug);
    
    /**
     * Set device token
     */
    static void registerDeviceToken(void);
    
    /**
     * Set device token
     *
     * @param senderID Google Project Number
     */
    static void registerDeviceToken(const char *senderId);
    
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
     * Clear badge of app icon
     */
    static void clearBadge(void);
    
private:
    GrowthPush(void);
    virtual ~GrowthPush(void);
};

NS_GROWTHPUSH_END

#endif  // GROWTHPUSHPLUGIN_GROWTHPUSH_H_
