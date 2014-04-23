package com.growthpush.cocos2dx;

import org.cocos2dx.lib.Cocos2dxGLSurfaceView;

import android.content.Context;

import com.growthpush.ExternalFramework;
import com.growthpush.ExternalFramework.Framework;
import com.growthpush.GrowthPush;
import com.growthpush.model.Environment;

public class GrowthPushJNI {
	static Context mContext = null;

	public GrowthPushJNI(Context context) {
		ExternalFramework.setFramework(Framework.cocos2dx);
		ExternalFramework.setCallbackListener(new ExternalFramework.CallbackToNativeFromReceivePushNotificationListener() {
			@Override
			public void callback(final String json) {
				Cocos2dxGLSurfaceView.getInstance().queueEvent(new Runnable() {
					@Override
					public void run() {
						didReceiveRemoteNotification(json);
					}
				});
			}
		});
		mContext = context;
	}

	public static void initialize(int applicationId, final String secret, int environment, boolean debug) {
		initialize(applicationId, secret, environment, debug, 0);
	}

	public static void initialize(int applicationId, final String secret, int environment, boolean debug, int option) {
		GrowthPush.getInstance().initialize(mContext, applicationId, secret, GrowthPushJNI.EnvironmentFromInteger(environment), debug);
	}

	public static void register(final String senderId) {
		GrowthPush.getInstance().register(senderId);
	}

	public static void trackEvent(final String name) {
		trackEvent(name, null);
	}

	public static void trackEvent(final String name, final String value) {
		GrowthPush.getInstance().trackEvent(name, value);
	}

	public static void setTag(final String name) {
		setTag(name, null);
	}

	public static void setTag(final String name, final String value) {
		GrowthPush.getInstance().setTag(name, value);
	}

	public static void setDeviceTags() {
		GrowthPush.getInstance().setDeviceTags();
	}

	public static void callTrackGrowthPushMessage() {
		ExternalFramework.callTrackGrowthPushMessage();
	}

	public static Environment EnvironmentFromInteger(int environment) {

		switch (environment) {
		case 0:
			return Environment.development;
		case 1:
			return Environment.production;
		}
		return null;

	}

	/*
	 * Remote notification callback method (JNI interface)
	 * 
	 * @param json json string
	 */
	static native void didReceiveRemoteNotification(String json);

}
