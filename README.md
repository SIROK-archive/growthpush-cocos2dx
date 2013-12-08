growthpush-cocos2dx
===================

Growth Push SDK for Cocos2d-x

Install
----------------
iOS
----------------
1. Copy GrowthPush.framework to /path/to/your_project/proj.ios/Frameworks/
2. Copy src/Classes/GrowthPush to /path/to/your_project/Classes/
3. Add Security.framework

Android
----------------
1. Copy jar /path/to/your_project/proj.android/libs/
      + android-support-v4.jar
      + google-play-services.jar
      + growthpush.jar
2. Edit your project AndroidManifest.xml
      + Insert GrowthPush activity
      + Insert uses-permission
3. Copy src/proj.android/src/com to /path/to/your_project/proj.android/src
4. Add build path to Android.mk
      + ../../Classes/GrowthPush/android/GrowthPushPlugin.cpp
      + $(LOCAL_PATH)/../../Classes/GrowthPush
5. Add GrowthPushPlugin class to your project Activity

Example

    import com.growthpush.cocos2dx.GrowthPushPlugin;
    
    public class GrowthPushCocos2dxPlugin extends Cocos2dxActivity {
        GrowthPushPlugin growthPushPlugin = null;
        
        protected void onCreate(Bundle savedInstanceState) {
            super.onCreate(savedInstanceState);
            growthPushPlugin = new GrowthPushPlugin(this);
        }
    }

Cocos2d-x usage
----------------

    #include "GrowthPushPlugin.h"
    
    USING_NS_GROWTHPUSH;
    
    GrowthPushPlugin::initialize(YOUR_APP_ID, "YOUR_APP_SECRET", YOUR_APP_ENV, YOUR_DEBUG_FLAG);
    
    #if (CC_TARGET_PLATFORM == CC_PLATFORM_IOS)
      GrowthPushPlugin::registerDeviceToken();
    #elif (CC_TARGET_PLATFORM == CC_PLATFORM_ANDROID)
      GrowthPushPlugin::registerDeviceToken("YOUR_SENDER_ID");
    #endif
    
    GrowthPushPlugin::setDeviceTags();
    
    GrowthPushPlugin::trackEvent("EventName");
    GrowthPushPlugin::trackEvent("EventName", "EventValue");
    
    GrowthPushPlugin::setTag("TagName");
    GrowthPushPlugin::setTag("TagName", "TagValue");
    
    #if (CC_TARGET_PLATFORM == CC_PLATFORM_IOS)
      GrowthPushPlugin::clearBadge();
    #endif
