import Flutter
import UIKit
import GoogleMaps

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    
    GMSServices.provideAPIKey("AIzaSyBbYLPuhexAOd4QO8e3UI_s2qdoZJQEIdY")
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}

#include "AppDelegate.h"
#include "GeneratedpluginRegistrant.h"
#import "GoogleMaps/GoogleMaps.h"

@implementation AppDelegate

- (Bool)application:(UIApplication *)application
didFinishLaunchingWithOptions:(NSDictioinary *)launchOptions
[GMSServices provideAPIKey:@"AIzaSyBbYLPuhexAOd4QO8e3UI_s2qdoZJQEIdY"];
[GeneratedPluginRegistrant registerWithRegistry:self];
return [super application:application didFinishLaunchingWithOptions]

@end
