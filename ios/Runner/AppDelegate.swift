import UIKit
import Flutter
import flutter_downloader
import awesome_notifications
import uni_links
import UserNotifications
import Firebase

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
      UNUserNotificationCenter.current().delegate = self
      // Register notification categories
      // Request notification permissions
    requestNotificationPermissions()

    // Set up notification categories
    setupNotificationCategories()
      FirebaseApp.configure()
        
//    SwiftFlutterBackgroundServicePlugin.taskIdentifier = "your.custom.task.identifier"

    GeneratedPluginRegistrant.register(with: self)
      SwiftAwesomeNotificationsPlugin.setPluginRegistrantCallback { registry in
              SwiftAwesomeNotificationsPlugin.register(
                with: registry.registrar(forPlugin: "io.flutter.plugins.awesomenotifications.AwesomeNotificationsPlugin")!)
          }
    FlutterDownloaderPlugin.setPluginRegistrantCallback({ registry in
        FlutterDownloaderPlugin.register(with: registry.registrar(forPlugin: "FlutterDownloaderPlugin") as! FlutterPluginRegistrar)
                //GeneratedPluginRegistrant.register(with: registry)
    })

//    if let controller = window?.rootViewController as? FlutterViewController {
//            UniLinksPlugin.register(with: controller.registrar(forPlugin: "UniLinksPlugin")!)
//        }

    SwiftAwesomeNotificationsPlugin.setPluginRegistrantCallback { registry in
                    SwiftAwesomeNotificationsPlugin.register(
                      with: registry.registrar(forPlugin: "io.flutter.plugins.awesomenotifications.AwesomeNotificationsPlugin")!)}


    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
    
    override func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any],
                               fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
       // Handle background notification
       super.application(application, didReceiveRemoteNotification: userInfo, fetchCompletionHandler: completionHandler)
     }
    
    // Function to request notification permissions
        func requestNotificationPermissions() {
            UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
                if granted {
                    print("Notification permission granted.")
                } else {
                    print("Notification permission denied.")
                }
            }
        }
        
        // Function to set up notification categories
        func setupNotificationCategories() {
            let replyAction = UNNotificationAction(identifier: "REPLY_ACTION",
                                                   title: "Reply",
                                                   options: [.authenticationRequired, .foreground])
            let snoozeAction = UNNotificationAction(identifier: "SNOOZE_ACTION",
                                                    title: "Snooze",
                                                    options: [.destructive])
            let messageCategory = UNNotificationCategory(identifier: "NEW_MESSAGE_CATEGORY",
                                                         actions: [replyAction, snoozeAction],
                                                         intentIdentifiers: [],
                                                         options: [.customDismissAction])
            UNUserNotificationCenter.current().setNotificationCategories([messageCategory])
        }

   override func application(
        _ application: UIApplication,
        continue userActivity: NSUserActivity,
        restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void
    ) -> Bool {
        if userActivity.activityType == NSUserActivityTypeBrowsingWeb,
           let url = userActivity.webpageURL {
            return handleDeepLink(url)
        }
        return false
    }
    
    func handleDeepLink(_ url: URL) -> Bool {
        // Handle the deep link URL here
        
        return true
    }
}
