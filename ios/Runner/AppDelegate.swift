import UIKit
import Flutter
import CoreBluetooth

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    private static let CHANNEL = "your.neww.name"

    override func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let controller: FlutterViewController = self.window?.rootViewController as! FlutterViewController
        let channel = FlutterMethodChannel(name: AppDelegate.CHANNEL, binaryMessenger: controller.binaryMessenger)
        channel.setMethodCallHandler { (call: FlutterMethodCall, result: @escaping FlutterResult) in
            if call.method == "enableBluetooth" {
                self.enableBluetooth(result: result)
            } else {
                result(FlutterMethodNotImplemented)
            }
        }

        GeneratedPluginRegistrant.register(with: self)
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }

    private func enableBluetooth(result: @escaping FlutterResult) {
        let centralManager = CBCentralManager(delegate: nil, queue: nil)
        if centralManager.state == .poweredOn {
            result(true)
        } else {
            // Show Bluetooth dialog if needed
            showBluetoothDialogIfNeeded(result: result)
        }
    }
    
    private func showBluetoothDialogIfNeeded(result: @escaping FlutterResult) {
        let alertController = UIAlertController(
            title: "Enable Bluetooth",
            message: "Please enable Bluetooth to use this feature.",
            preferredStyle: .alert
        )
        
        alertController.addAction(UIAlertAction(title: "Settings", style: .default) { _ in
            if let settingsURL = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(settingsURL, options: [:], completionHandler: nil)
            }
        })
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel) { _ in
            result(false) // Return false if user cancels
        })
        
        if let rootViewController = window?.rootViewController {
            rootViewController.present(alertController, animated: true, completion: nil)
        }
    }
}
