package com.growthpush.cocos2dx;

import org.json.JSONException;
import org.json.JSONObject;

import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.util.Log;

import org.cocos2dx.lib.Cocos2dxActivity;

import com.growthpush.GrowthPush;
import com.growthpush.handler.DefaultReceiveHandler;

public class GPCocos2dxActivity extends Cocos2dxActivity {
    public static final String LOG_TAG = "growthpush-cocos2dx";
    private static GrowthPushJNI growthPushJNI = null;
    
    private static String growthPushMessage = null;
    public static void saveGrowthPushMessage(String msg) {
        growthPushMessage = msg;
    }
    
    public static void callTrackGrowthPushMessage() {
        if (growthPushMessage != null) {
            growthPushJNI.didReceiveRemoteNotificationOnGLSurfaceView(growthPushMessage);
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
    
    @Override
    protected void onCreate(Bundle savedInstanceState){
        super.onCreate(savedInstanceState);
        growthPushJNI = new GrowthPushJNI(this);

        // register receive handler method
        DefaultReceiveHandler receiveHandler = new DefaultReceiveHandler() {
            @Override
            public void onReceive(Context context, Intent intent) {
                Log.d(LOG_TAG, "onReceive");
                super.onReceive(context, intent);
            }
        };
        receiveHandler.setCallback(new DefaultReceiveHandler.Callback() {
            @Override
            public void onOpen(Context context, final Intent intent) {
                Log.d(LOG_TAG, "onOpen");
                super.onOpen(context, intent);
                String str = GPCocos2dxActivity.parseGrowthPushMessage(intent);
                if (str != null) {
                    growthPushJNI.didReceiveRemoteNotificationOnGLSurfaceView(str);
                }
            }
        });
        GrowthPush.getInstance().setReceiveHandler(receiveHandler);
    }
}
