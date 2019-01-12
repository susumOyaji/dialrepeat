#include "AppDelegate.h"
#include "GeneratedPluginRegistrant.h"


@implementation AppDelegate

- (int)getBatteryLevel {
    UIDevice* device = UIDevice.currentDevice;
    device.batteryMonitoringEnabled = YES;
    if (device.batteryState == UIDeviceBatteryStateUnknown) {
        return -1;
    } else {
        return (int)(device.batteryLevel * 100);
    }
}




- (BOOL)application:(UIApplication*)application didFinishLaunchingWithOptions:(NSDictionary*)launchOptions {
    FlutterViewController* controller = (FlutterViewController*)self.window.rootViewController;
    
    FlutterMethodChannel* batteryChannel = [FlutterMethodChannel
                                            methodChannelWithName:@"samples.flutter.io/battery"
                                            binaryMessenger:controller];
    
    [batteryChannel setMethodCallHandler:^(FlutterMethodCall* call, FlutterResult result) {
        // TODO
    }];
    
    [GeneratedPluginRegistrant registerWithRegistry:self];
    return [super application:application didFinishLaunchingWithOptions:launchOptions];
}

@end


__weak typeof(self) weakSelf = self
[batteryChannel setMethodCallHandler:^(FlutterMethodCall* call, FlutterResult result) {
    if ([@"getBatteryLevel" isEqualToString:call.method]) {
        int batteryLevel = [weakSelf getBatteryLevel];
        
        if (batteryLevel == -1) {
            result([FlutterError errorWithCode:@"UNAVAILABLE"
                                       message:@"Battery info unavailable"
                                       details:nil]);
        } else {
            result(@(batteryLevel));
        }
    } else {
        result(FlutterMethodNotImplemented);
    }
}];
