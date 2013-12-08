package com.growthpush.cocos2dx;

import android.app.Activity;
import android.content.Context;

import com.growthpush.GrowthPush;
import com.growthpush.model.Environment;

public class GrowthPushPlugin {
    private static Context mContext = null;
        
    public GrowthPushPlugin(Activity activity) {
        mContext = activity.getApplicationContext();
    }
    
    public static void initialize(int applicationId, final String secret) {
        GrowthPush.getInstance().initialize(mContext, applicationId, secret);
    }
    
    public static void initialize(int applicationId, final String secret, int environment) {
        GrowthPush.getInstance().initialize(mContext, applicationId, secret, getEnvironmentFromCocos(environment));
    }
    
    public static void initialize(int applicationId, final String secret, int environment, boolean debug) {
        GrowthPush.getInstance().initialize(mContext, applicationId, secret, getEnvironmentFromCocos(environment), debug);
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
     Convert com.growthpush.model.Environment from GPEnvironment value of Cocos2d-x
     
     @param environment GPEnvironment value of Cocos2d-x
     @return Environment value of Java
     */
    private static Environment getEnvironmentFromCocos(int environment) {
        if (environment == Environment.development.ordinal()) {
            return Environment.development;
        } else if(environment == Environment.production.ordinal()) {
            return Environment.production;
        }
        throw new IllegalArgumentException("Unknown environment");
    }
}
