package com.growthpush.cocos2dx;

import java.util.HashMap;
import java.util.Map;

import org.cocos2dx.lib.Cocos2dxGLSurfaceView;
import org.json.JSONObject;

import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.util.Log;

import com.growthpush.GrowthPush;
import com.growthpush.handler.ReceiveHandler;
import com.growthpush.model.Environment;

public class GrowthPushJNI {
    private static Context mContext = null;
    private static Cocos2dxGLSurfaceView mGLSurfaceView = null; 

    public GrowthPushJNI(Activity activity, Cocos2dxGLSurfaceView glSurfaceView) {
        mContext = activity.getApplicationContext();
        mGLSurfaceView = glSurfaceView;
    }

    // XXX: Test copy from Unity SDK
    private static JSONObject parsePushGrowthPushMessage(final Intent intent) {
        if(intent == null) {
            return null;
        }
        Bundle bundle = intent.getExtras();
        if (bundle == null || bundle.isEmpty()) {
            return null;
        }
        
        Map<String, Object> jsonMap = new HashMap<String, Object>();
        for (String key : bundle.keySet()) {
            String value = bundle.get(key).toString();
            Log.d("cocos2d-x", key + " => " + value);                                        
            if (key.equals("showDialog") || key.equals("collapse_key") || key.equals("from")) {
                continue;
            }
            jsonMap.put(key, value);
        }
        return new JSONObject(jsonMap);
    }
    
    private static void setReceiveHandler() {
        GrowthPush.getInstance().setReceiveHandler(new ReceiveHandler() {
            @Override
            public void onReceive(Context context, final Intent intent) {
                mGLSurfaceView.queueEvent(new Runnable() {
                    @Override
                    public void run() {
                        Log.d("GrowthPushJNI", "*********onReceive:" + intent.getStringExtra("message"));
                        //JSONObject json = parsePushGrowthPushMessage(intent);
                        //Log.d("GrowthPushJNI", "*********onReceive json=" + json.toString());
                        didReceiveRemoteNotification("{\"growthpush\":{\"notificationId\":2778}}");
                    }
                });
            }
        });
    }
    
    private static native void didReceiveRemoteNotification(String json);

    public static void initialize(int applicationId, final String secret, int environment, boolean debug) {
        GrowthPush.getInstance().initialize(mContext, applicationId, secret, environmentFromCocos(environment), debug);
        setReceiveHandler();
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
