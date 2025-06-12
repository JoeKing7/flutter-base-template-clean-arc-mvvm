import Flutter
import UIKit

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
        let deviceChannel = FlutterMethodChannel(name: "com.example.base_template/device_id",
                                                 binaryMessenger: controller.binaryMessenger)
        
        deviceChannel.setMethodCallHandler { (call, result) in
            if call.method == "getDeviceId" {
                if let uuid = UIDevice.current.identifierForVendor?.uuidString {
                    result(uuid)
                } else {
                    result(FlutterError(code: "UNAVAILABLE",
                                        message: "Device ID not available",
                                        details: nil))
                }
            } else {
                result(FlutterMethodNotImplemented)
            }
        }
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
