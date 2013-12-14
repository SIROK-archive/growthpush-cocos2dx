package com.growthpush.cocos2dx;

import android.content.Context;
import android.util.Log;

import org.cocos2dx.lib.Cocos2dxGLSurfaceView;

import com.growthpush.GrowthPush;
import com.growthpush.model.Environment;

public class GrowthPushJNI {
    static final String LOG_TAG = "growthpush-cocos2dx";
    static Context mContext = null;

    public GrowthPushJNI(Context context) {
        mContext = context;
    }

    public void didReceiveRemoteNotificationOnGLSurfaceView(final String json) {
        Log.d(LOG_TAG, "didReceiveRemoteNotificationOnGLSurfaceView");
        Cocos2dxGLSurfaceView.getInstance().queueEvent(new Runnable() {
            @Override
            public void run() {
                didReceiveRemoteNotification(json);
            }
        });
    }
    
    /*
     * Remote notification callback method (JNI interface)
     *
     * @param json  json string
     */
    static native void didReceiveRemoteNotification(String json);

    public static void initialize(int applicationId, final String secret, int environment, boolean debug) {
        GrowthPush.getInstance().initialize(mContext, applicationId, secret, environmentFromCocos(environment), debug);
        GPCocos2dxActivity.callTrackGrowthPushMessage();
    }

    public static void register(final String senderId) {
        GrowthPush.getInstance().register(senderId);
    }

    public static void trackEvent(final String name) {
        GrowthPush.getInstance().trackEvent(name);
    }

    public static void trackEvent(final String name, final String value) {
        GrowthPush.getInstance().trackEvent(name, value);
    }

    public static void setTag(final String name) {
        GrowthPush.getInstance().setTag(name);
    }

    public static void setTag(final String name, final String value) {
        GrowthPush.getInstance().setTag(name, value);
    }

    public static void setDeviceTags() {
        GrowthPush.getInstance().setDeviceTags();
    }

    /*
     * Convert GPEnvironment to Environment
     * 
     * @param environment GPEnvironment value of Cocos2d-x
     * 
     * @return Environment value of Java
     */
    private static Environment environmentFromCocos(int environment) {
        if (environment == Environment.development.ordinal()) {
            return Environment.development;
        } else if (environment == Environment.production.ordinal()) {
            return Environment.production;
        }
        throw new IllegalArgumentException("Unknown environment");
    }
}
