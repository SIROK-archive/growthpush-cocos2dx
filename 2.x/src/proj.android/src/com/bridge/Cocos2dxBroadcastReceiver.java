package com.growthpush.bridge;

public class Cocos2dxBroadcastReceiver extends ExternalFrameworkBroadcastReceiver {

	public Cocos2dxBroadcastReceiver() {
		super();
		this.bridge = new Cocos2dxBridge();

	}
}
