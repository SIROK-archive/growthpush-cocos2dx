package com.growthpush.cocos2dx;

import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.util.Log;

import org.cocos2dx.lib.Cocos2dxGLSurfaceView;
import org.json.JSONException;
import org.json.JSONObject;

import com.growthpush.GrowthPush;
import com.growthpush.model.Environment;

public class GrowthPushJNI {
    static final String LOG_TAG = "growthpush-cocos2dx";
    static Context mContext = null;
    static String growthPushMessage = null;

    public GrowthPushJNI(Context context) {
        mContext = context;
    }

    public static void saveGrowthPushMessage(Intent intent) {
        String msg = parseGrowthPushMessage(intent);
        growthPushMessage = msg;
    }
    
    public static void callTrackGrowthPushMessage() {
        if (growthPushMessage != null) {
            didReceiveRemoteNotificationOnGLSurfaceView(growthPushMessage);
            growthPushMessage = null;
        }
    }

    /*
     * Parse intent to json.
     * 
     * @param intent
     * @return json string
     */
    public static String parseGrowthPushMessage(final Intent intent) {
        if (intent == null) {
            return null;
        }
        Bundle bundle = intent.getExtras();
        if (bundle == null || bundle.isEmpty()) {
            return null;
        }

        try {
            JSONObject jsonObject = new JSONObject();
            for (String key : bundle.keySet()) {
                Object value = bundle.get(key);
                if (key.equals("showDialog") || key.equals("collapse_key") || key.equals("from")) {
                    continue;
                }
                JSONObject json = new JSONObject("{\"" + key + "\":" + value + "}");
                jsonObject.put(key, json.get(key));
            }
            return jsonObject.toString();
        } catch (JSONException e) {
            Log.e(LOG_TAG, "Unknown JSON format", e);
        }
        return null;
    }
    
    static void didReceiveRemoteNotificationOnGLSurfaceView(final String json) {
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
