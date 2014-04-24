package com.growthpush.cocos2dx;

import com.growthpush.bridge.ExternalFrameworkBroadcastReceiver;

public class Cocos2dxBroadcastReceiver extends ExternalFrameworkBroadcastReceiver {

	public Cocos2dxBroadcastReceiver() {
		super();
		this.bridge = new Cocos2dxBridge();

	}
}
