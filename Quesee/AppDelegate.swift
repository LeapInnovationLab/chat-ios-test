import UIKit
import CoreData
import Alamofire

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject : AnyObject]?) -> Bool {
        account.addObserver(self, forKeyPath: "accessToken", options: NSKeyValueObservingOptions(0), context: nil) // always
        let storyboard = UIStoryboard(name: "Onboarding", bundle: nil)
        let loginView = storyboard.instantiateViewControllerWithIdentifier("onboarding") as! UIViewController

        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        window!.backgroundColor = UIColor.whiteColor()
        window!.rootViewController = loginView //UINavigationController(rootViewController: loginView)
        window!.makeKeyAndVisible()
        return true
    }

    // MARK: NSKeyValueObserving

    override func observeValueForKeyPath(keyPath: String, ofObject object: AnyObject, change: [NSObject : AnyObject], context: UnsafeMutablePointer<Void>) {
        if account.accessToken != nil {
            let headers =  ["X-QUESEE-AUTHTOKEN": account.accessToken]
            Alamofire.Manager.sharedInstance.session.configuration.HTTPAdditionalHeaders = headers
            account.loadSelf({ (user) -> () in
              self.window!.rootViewController = createTabBarController()
            })
            account.loadContacts(0, page: 1, completionBlock: { (error) -> () in
                // do something in the UI after loading contacts
                
                account.loadConversations(10, page: 1, completionBlock: { (error) -> () in
                    // do something in the UI after loading conversations
                })
            })
        } else {
            println(self.window!.rootViewController)
            if self.window!.rootViewController is LoginController {
                var alert = UIAlertController(title: "Quesee", message: "Invalid email or password, please try again", preferredStyle: UIAlertControllerStyle.Alert)
                let axtion = UIAlertAction(title: "Close", style: UIAlertActionStyle.Default, handler: nil)
                alert.addAction(axtion)
                window!.rootViewController!.presentViewController(alert, animated: true, completion: nil)
            } else {
                let storyboard = UIStoryboard(name: "Onboarding", bundle: nil)
                let loginView = storyboard.instantiateViewControllerWithIdentifier("onboarding") as! UIViewController
                window!.rootViewController = loginView //UINavigationController(rootViewController: loginView)
            }
        }
    }
}

func createTabBarController() -> UITabBarController {
    // Creat home
    let homeController = HomeController()
    homeController.tabBarItem.image = UIImage(named: "Home")
    let homeNavigationController = UINavigationController(rootViewController: homeController)
    
    // Create `usersCollectionViewController`
    let usersCollectionViewController = UsersCollectionViewController()
    usersCollectionViewController.tabBarItem.image = UIImage(named: "Users")
    let usersNavigationController = UINavigationController(rootViewController: usersCollectionViewController)

    // Create `chatsTableViewController`
    let chatsTableViewController = ChatsTableViewController()
    chatsTableViewController.tabBarItem.image = UIImage(named: "Chats")
    let chatsNavigationController = UINavigationController(rootViewController: chatsTableViewController)

    // Create `profileTableViewController`
    let profileTableViewController = ProfileTableViewController(user: account.user)
    profileTableViewController.tabBarItem.image = UIImage(named: "Profile")
    let profileNavigationController = UINavigationController(rootViewController: profileTableViewController)

    // Create `settingsTableViewController`
    let settingsTableViewController = SettingsTableViewController()
    settingsTableViewController.tabBarItem.image = UIImage(named: "Settings")
    let settingsNavigationController = UINavigationController(rootViewController: settingsTableViewController)

    let tabBarController = UITabBarController(nibName: nil, bundle: nil)
    tabBarController.viewControllers = [homeNavigationController, usersNavigationController, chatsNavigationController, profileNavigationController, settingsNavigationController]
    return tabBarController
}
