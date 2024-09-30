import Flutter
import UIKit

@main
@objc class AppDelegate: FlutterAppDelegate {
private let CHANNEL = "com.example/battery"

  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    let controller: FlutterViewController = window?.rootViewController as! FlutterViewController
    let batteryChannel = FlutterMethodChannel(name: CHANNEL, binaryMessenger: controller.binaryMessenger)

    batteryChannel.setMethodCallHandler { (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
      if call.method == "getBatteryLevel" {
        self.receiveBatteryLevel(result: result)
      } else {
        result(FlutterMethodNotImplemented)
      }
    }

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  private func receiveBatteryLevel(result: FlutterResult) {
    UIDevice.current.isBatteryMonitoringEnabled = true
    let batteryLevel = Int(UIDevice.current.batteryLevel * 100)

    if batteryLevel == -1 {
      result(FlutterError(code: "UNAVAILABLE", message: "Battery level not available.", details: nil))
    } else {
      result(batteryLevel)
    }
  }
}
