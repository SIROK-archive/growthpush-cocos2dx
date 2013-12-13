growthpush-cocos2dx
===================

Growth Push SDK for Cocos2d-x

Install
----------------
iOS
----------------
1. Copy "GrowthPush.framework" library to "/path/to/your_project/proj.ios/Frameworks/"
2. Copy "src/Classes/GrowthPush" directory to "/path/to/your_project/Classes/"
3. Add "Security.framework" library to your Xcode project

Android
----------------
1. Copy following jar files to "/path/to/your_project/proj.android/libs/"
      * android-support-v4.jar
      * google-play-services.jar
      * growthpush.jar
2. Edit your project's AndroidManifest.xml
      * Insert GrowthPush activity setting
      * Insert uses-permission setting
3. Copy "src/proj.android/src/com" to "/path/to/your_project/proj.android/src"
4. Add build path to your project's Android.mk
      * LOCAL_SRC_FILES := ../../Classes/GrowthPush/android/GrowthPush.cpp
      * LOCAL_C_INCLUDES := $(LOCAL_PATH)/../../Classes/GrowthPush
5. Add "GrowthPushJNI" class to your project Activity class file

Example

```
import com.growthpush.cocos2dx.GrowthPushJNI;

public class GrowthPushCocos2dxPlugin extends Cocos2dxActivity {
    // Add GrowthPushJNI instance
    GrowthPushJNI growthPushJNI = null;
    
    protected void onCreate(Bundle savedInstanceState){
        Log.d("GrowthPushCocos2dxPlugin", "onCreate");
		super.onCreate(savedInstanceState);
    }
    
    public Cocos2dxGLSurfaceView onCreateView() {
    	Cocos2dxGLSurfaceView glSurfaceView = new Cocos2dxGLSurfaceView(this);
    	// GrowthPushCocos2dxPlugin should create stencil buffer
    	glSurfaceView.setEGLConfigChooser(5, 6, 5, 0, 16, 8);
    	
    	// Use GrowthPushJNI
        growthPushJNI = new GrowthPushJNI(this, glSurfaceView);
        
    	return glSurfaceView;
    }
}
```

Cocos2d-x usage
----------------

```
#include "GrowthPush.h"

USING_NS_GROWTHPUSH;

GrowthPush::initialize(YOUR_APP_ID, "YOUR_APP_SECRET", YOUR_APP_ENV, YOUR_DEBUG_FLAG);

GrowthPush::registerDeviceToken();
GrowthPush::registerDeviceToken("YOUR_SENDER_ID");

GrowthPush::setDeviceTags();

GrowthPush::trackEvent("EventName");
GrowthPush::trackEvent("EventName", "EventValue");

GrowthPush::setTag("TagName");
GrowthPush::setTag("TagName", "TagValue");

GrowthPush::clearBadge();
```

Example

```
void HelloWorld::init() {
    ... (code) ...
    
    // add remote notification receiver
    CCNotificationCenter::sharedNotificationCenter()->addObserver(this, callfuncO_selector(HelloWorld::didReceiveRemoteNotification),
                                                                  kGPDidReceiveRemoteNotification, NULL);

    ... (code) ...
}

void HelloWorld::~HelloWorld() {
    // remove remote notification receiver
    CCNotificationCenter::sharedNotificationCenter()->removeObserver(this, kGPDidReceiveRemoteNotification);
}

void HelloWorld::didReceiveRemoteNotification(CCObject *sender)
{
    // ex.) {"aps":{"badge":1,"sound":"default","alert":"Message"},"growthpush":{"notificationId":1234}}
    CCDictionary *json = (CCDictionary *)sender;
    CCDictionary *growthpush = (CCDictionary *)json->objectForKey("growthpush");
    /* use CCDouble */
    CCDouble *notificationID = (CCDouble *)growthpush->objectForKey("notificationId");
    CCLOG("notificationID:%d", notificationID->intValue());
    /* cannot use CCDouble */
    CCString *notificationID = (CCString *)growthpush->objectForKey("notificationId");
    CCLOG("notificationID:%d", (int)notificationID->getValue());
}

```
