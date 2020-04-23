import UIKit


class NotificationViewController: UIViewController {
    
     private let center = UNUserNotificationCenter.current()
    private var timeInterval:TimeInterval = (Date().timeIntervalSinceNow + 15)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkNotificationAuthorization()
        
    }
    
    public func checkNotificationAuthorization() {//the settings var will give us imformation if we are authorized
         center.getNotificationSettings { (settings) in
           if settings.authorizationStatus == .authorized {
             print("app is authorized for notifications")
           } else {
             //if we will prone the user for permission
             self.requestNotificationPermissions()
           }
         }
       }

       private func requestNotificationPermissions(){
         center.requestAuthorization(options: [.alert,.sound]) { (granted, error) in
             
             if let error = error {
                 print("error \(error)")
                 return
             }
             
             if granted {
                 print("access granted")
             } else {
                 print("access denied")
             }
             
         }
       }
    
    public func createLocalNotifications(with message: String){
            let content = UNMutableNotificationContent()
            content.title = message
        
            content.sound = .default
            let identifier = UUID().uuidString
            if let imageURL = Bundle.main.url(forResource: "swift-logo", withExtension: "png") {
                
                do {
                    
            let attachment = try UNNotificationAttachment(identifier: identifier, url: imageURL, options: nil)
                    
                    content.attachments = [attachment]
                    
                } catch {
                    print("error with attachment \(error)")
                }
            
            } else {
                print("image resource could not be found")
            }
            
        
            
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: timeInterval, repeats: false)
            //creat request
            let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
            
            //add request to the UNNotification center
            UNUserNotificationCenter.current().add(request) { error in
                if let error = error {
                    print("error adding request \(error)")
                } else {
                    print("request was succesfully added")
            }
        }
    }
}

extension NotificationViewController: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler(.alert)
    }
    
    
   
}
