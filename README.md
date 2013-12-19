growthpush-cocos2dx
===================

Growth Push SDK for Cocos2d-x

Install
----------------
Common
----------------
1. Copy "src/Classes/GrowthPush" and "src/Classes/picojson.h" to "/path/to/your_project/Classes/"

iOS
----------------
1. Copy "GrowthPush.framework" library to "/path/to/your_project/proj.ios/Frameworks/"
2. Add "Security.framework" library to your Xcode project
3. Add "/path/to/your_project/Classes/GrowthPush" and "/path/to/your_project/Classes/picojson.h" to Xcode

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
5. Modified "Cocos2dxActivity" to "GPCocos2dxActivity" in your project MainActivity class

Example

AndroidManifest.xml

```
    <application android:label="@string/app_name"
        android:icon="@drawable/icon">

        <activity android:name="jp.example.sample.SampleActivity"
                  android:label="@string/app_name"
                  android:screenOrientation="portrait"
                  android:theme="@android:style/Theme.NoTitleBar.Fullscreen"
                  android:configChanges="orientation"
                  android:launchMode="singleTask">
            <intent-filter>
                <action android:name="android.intent.action.MAIN" />
                <category android:name="android.intent.category.LAUNCHER" />
            </intent-filter>
        </activity>
        
        <activity android:name="com.growthpush.view.AlertActivity"
                  android:configChanges="orientation|keyboardHidden"
                  android:launchMode="singleInstance"
                  android:theme="@android:style/Theme.Translucent" />
        <receiver android:name="com.growthpush.cocos2dx.GPCocos2dxBroadcastReceiver" android:permission="com.google.android.c2dm.permission.SEND">
                <intent-filter>
                        <action android:name="com.google.android.c2dm.intent.RECEIVE" />
                        <action android:name="com.google.android.c2dm.intent.REGISTRATION" />
                        <category android:name="jp.example.sample" />
                </intent-filter>
        </receiver>
        </application>

    <uses-permission android:name="android.permission.INTERNET"/>
    <uses-permission android:name="android.permission.GET_ACCOUNTS" />
    <uses-permission android:name="com.google.android.c2dm.permission.RECEIVE" />
    <uses-permission android:name="android.permission.VIBRATE" />
    <uses-permission android:name="android.permission.WAKE_LOCK" />
    <uses-permission android:name="android.permission.GET_TASKS" />
    <permission android:name="jp.example.sample.permission.C2D_MESSAGE" android:protectionLevel="signature" />
    <uses-permission android:name="jp.example.sample.permission.C2D_MESSAGE" />
```

SampleActivity.java

```
import com.growthpush.cocos2dx.GPCocos2dxActivity;

public class SampleActivity extends GPCocos2dxActivity {

    protected void onCreate(Bundle savedInstanceState){
		super.onCreate(savedInstanceState);
    }

    public Cocos2dxGLSurfaceView onCreateView() {
        Log.d("GrowthPushCocos2dxPlugin", "onCreateView");
        
    	Cocos2dxGLSurfaceView glSurfaceView = new Cocos2dxGLSurfaceView(this);
    	// GrowthPushCocos2dxPlugin should create stencil buffer
    	glSurfaceView.setEGLConfigChooser(5, 6, 5, 0, 16, 8);
        
    	return glSurfaceView;
    }

    static {
        System.loadLibrary("cocos2dcpp");
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

GrowthPush::launchWithNotification(this, gp_remote_notification_selector(AppDelegate::CALLBACK_FUNCTION));
```

Example

```
bool AppDelegate::applicationDidFinishLaunching() {
    ... (code) ...
    
    // run
    pDirector->runWithScene(pScene);

    GrowthPush::launchWithNotification(this, gp_remote_notification_selector(AppDelegate::didReceiveRemoteNotification));

    ... (code) ...
}

void AppDelegate::didReceiveRemoteNotification(CCObject *json)
{
    // ex.) {"aps":{"badge":1,"sound":"default","alert":"Message"},"growthpush":{"notificationId":1234}}
    CCDictionary *jsonDict = (CCDictionary *)json;
    CCDictionary *growthpush = (CCDictionary *)jsonDict->objectForKey("growthpush");
    /* use CCDouble */
    CCDouble *notificationID = (CCDouble *)growthpush->objectForKey("notificationId");
    CCLOG("notificationID:%d", notificationID->intValue());
    /* cannot use CCDouble */
    CCString *notificationID = (CCString *)growthpush->objectForKey("notificationId");
    CCLOG("notificationID:%d", (int)notificationID->getValue());
}

```
