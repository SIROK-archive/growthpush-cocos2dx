#include "AppDelegate.h"
#include "HelloWorldScene.h"
#include "GrowthPush.h"

USING_NS_CC;
USING_NS_GROWTHPUSH;

AppDelegate::AppDelegate() {}

AppDelegate::~AppDelegate()
{}

bool AppDelegate::applicationDidFinishLaunching() {
    // initialize director
    auto director = Director::getInstance();
    auto glview = director->getOpenGLView();

    if (!glview) {
        glview = GLView::create("My Game");
        director->setOpenGLView(glview);
    }

    // turn on display FPS
    director->setDisplayStats(true);

    // set FPS. the default value is 1.0/60 if you don't call this
    director->setAnimationInterval(1.0 / 60);

    // create a scene. it's an autorelease object
    auto scene = HelloWorld::createScene();

    // run
    director->runWithScene(scene);

    GrowthPush::initialize(1074, "sH2RhzDPNZKmXAKwqtG6pHNvDalIGk54", GPEnvironmentDevelopment, true);
    GrowthPush::registerDeviceToken("870898687785");
    GrowthPush::trackEvent("Launch");
    GrowthPush::setDeviceTags();
    GrowthPush::clearBadge();
    GrowthPush::launchWithNotification(this, gp_remote_notification_selector(AppDelegate::didLaunchWithNotification));

    return true;
}

void AppDelegate::didLaunchWithNotification(Value extra) {
    
    CCLOG("%s", extra.getDescription().c_str());
    auto growthpushCustomField = extra.asValueMap()["growthpush"].asValueMap();
    auto notificationId = growthpushCustomField["notificationId"];
    GrowthPush::trackEvent("Launch via push notification", notificationId.asString());
    
}

// This function will be called when the app is inactive. When comes a phone call,it's be invoked too
void AppDelegate::applicationDidEnterBackground() {
    Director::getInstance()->stopAnimation();

    // if you use SimpleAudioEngine, it must be pause
    // SimpleAudioEngine::sharedEngine()->pauseBackgroundMusic();
}

// this function will be called when the app is active again
void AppDelegate::applicationWillEnterForeground() {
    Director::getInstance()->startAnimation();

    // if you use SimpleAudioEngine, it must resume here
    // SimpleAudioEngine::sharedEngine()->resumeBackgroundMusic();
}
