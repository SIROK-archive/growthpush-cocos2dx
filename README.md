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
      + Insert GrowthPush activity setting.
      + Insert uses-permission setting.
3. Copy src/proj.android/src/com to /path/to/your_project/proj.android/src
4. Add build path to Android.mk
      + ../../Classes/GrowthPush/android/GrowthPush.cpp
      + $(LOCAL_PATH)/../../Classes/GrowthPush
5. Add GrowthPushJNI class to your project Activity.

Example

    import com.growthpush.cocos2dx.GrowthPushJNI;
    
    public class GrowthPushCocos2dxPlugin extends Cocos2dxActivity {
        GrowthPushJNI growthPushJNI = null;
        
        protected void onCreate(Bundle savedInstanceState) {
            super.onCreate(savedInstanceState);
            growthPushJNI = new GrowthPushJNI(this);
        }
    }

Cocos2d-x usage
----------------

    #include "GrowthPush.h"
    
    USING_NS_GROWTHPUSH;
    
    GrowthPush::initialize(YOUR_APP_ID, "YOUR_APP_SECRET", YOUR_APP_ENV, YOUR_DEBUG_FLAG);
    
    GrowthPush::registerDeviceToken("YOUR_SENDER_ID");
    
    GrowthPush::setDeviceTags();
    
    GrowthPush::trackEvent("EventName");
    GrowthPush::trackEvent("EventName", "EventValue");
    
    GrowthPush::setTag("TagName");
    GrowthPush::setTag("TagName", "TagValue");
    
    GrowthPush::clearBadge();
