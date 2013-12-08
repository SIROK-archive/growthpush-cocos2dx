//
//  GrowthPushPlugin.cpp
//  GrowthPushPlugin
//
//  Created by TSURUDA Ryo on 2013/12/08.
//  Copyright (c) 2013年 TSURUDA Ryo. All rights reserved.
//

#include "GrowthPushPlugin.h"

#include "cocos2d.h"
#include "platform/android/jni/JniHelper.h"
#include <jni.h>

USING_NS_CC;
USING_NS_GROWTHPUSH;

const char *JavaClassName = "com/growthpush/cocos2dx/GrowthPushPlugin";

GrowthPushPlugin::GrowthPushPlugin(void)
{
}

GrowthPushPlugin::~GrowthPushPlugin(void)
{
}

void GrowthPushPlugin::initialize(int applicationId, const char *secret, growthpush::GPEnvironment environment, bool debug)
{
    CCAssert(secret, "secret should not be NULL");
    
    JniMethodInfo t;
    if (JniHelper::getStaticMethodInfo(t, JavaClassName, "initialize", "(ILjava/lang/String;IZ)V")) {
        jstring jSecret = t.env->NewStringUTF(secret);
        t.env->CallStaticVoidMethod(t.classID, t.methodID, applicationId, jSecret, environment, debug);
        t.env->DeleteLocalRef(jSecret);
        t.env->DeleteLocalRef(t.classID);
    }
}

void GrowthPushPlugin::registerDeviceToken(const char *senderId)
{
    CCAssert(senderId, "senderId should not be NULL");
    
    JniMethodInfo t;
    if (JniHelper::getStaticMethodInfo(t, JavaClassName, "register", "(Ljava/lang/String;)V")) {
        jstring jSenderId = t.env->NewStringUTF(senderId);
        t.env->CallStaticVoidMethod(t.classID, t.methodID, jSenderId);
        t.env->DeleteLocalRef(jSenderId);
        t.env->DeleteLocalRef(t.classID);
    }
}

void GrowthPushPlugin::trackEvent(const char *name)
{
    CCAssert(name, "name should not be NULL");
    
    JniMethodInfo t;
    if (JniHelper::getStaticMethodInfo(t, JavaClassName, "trackEvent", "(Ljava/lang/String;)V")) {
        jstring jName = t.env->NewStringUTF(name);
        t.env->CallStaticVoidMethod(t.classID, t.methodID, jName);
        t.env->DeleteLocalRef(jName);
        t.env->DeleteLocalRef(t.classID);
    }
}

void GrowthPushPlugin::trackEvent(const char *name, const char *value)
{
    CCAssert(name, "name should not be  NULL");
    CCAssert(value, "value should not be  NULL");
    
    JniMethodInfo t;
    if (JniHelper::getStaticMethodInfo(t, JavaClassName, "trackEvent", "(Ljava/lang/String;Ljava/lang/String;)V")) {
        jstring jName = t.env->NewStringUTF(name);
        jstring jValue = t.env->NewStringUTF(value);
        t.env->CallStaticVoidMethod(t.classID, t.methodID, jName, jValue);
        t.env->DeleteLocalRef(jName);
        t.env->DeleteLocalRef(jValue);
        t.env->DeleteLocalRef(t.classID);
    }
}

void GrowthPushPlugin::setTag(const char *name)
{
    CCAssert(name, "name should not be  NULL");
    
    JniMethodInfo t;
    if (JniHelper::getStaticMethodInfo(t, JavaClassName, "setTag", "(Ljava/lang/String;)V")) {
        jstring jName = t.env->NewStringUTF(name);
        t.env->CallStaticVoidMethod(t.classID, t.methodID, jName);
        t.env->DeleteLocalRef(jName);
        t.env->DeleteLocalRef(t.classID);
    }
}

void GrowthPushPlugin::setTag(const char *name, const char *value)
{
    CCAssert(name, "name should not be  NULL");
    CCAssert(value, "value should not be  NULL");
    
    JniMethodInfo t;
    if (JniHelper::getStaticMethodInfo(t, JavaClassName, "setTag", "(Ljava/lang/String;Ljava/lang/String;)V")) {
        jstring jName = t.env->NewStringUTF(name);
        jstring jValue = t.env->NewStringUTF(value);
        t.env->CallStaticVoidMethod(t.classID, t.methodID, jName, jValue);
        t.env->DeleteLocalRef(jName);
        t.env->DeleteLocalRef(jValue);
        t.env->DeleteLocalRef(t.classID);
    }
}

void GrowthPushPlugin::setDeviceTags(void)
{
    JniMethodInfo t;
    if (JniHelper::getStaticMethodInfo(t, JavaClassName, "setDeviceTags", "()V")) {
        t.env->CallStaticVoidMethod(t.classID, t.methodID);
        t.env->DeleteLocalRef(t.classID);
    }
}
