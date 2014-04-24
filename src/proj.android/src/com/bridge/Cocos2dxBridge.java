package com.growthpush.bridge;

import org.cocos2dx.lib.Cocos2dxGLSurfaceView;

public class Cocos2dxBridge extends ExternalFrameworkBridge {

	@Override
	protected void callbackExternalFramework(final String customFiled) {
		Cocos2dxGLSurfaceView.getInstance().queueEvent(new Runnable() {
			@Override
			public void run() {
				didReceiveRemoteNotification(customFiled);
			}
		});
	}

	/*
	 * Remote notification callback method (JNI interface)
	 * 
	 * @param json json string
	 */
	static native void didReceiveRemoteNotification(String json);

}
