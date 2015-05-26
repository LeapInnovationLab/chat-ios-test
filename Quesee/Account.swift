import ObjectiveC.NSObject
import JSONJoy
import Alamofire
import CoreData

let account = Account()

class Account: NSObject {
    dynamic var accessToken: String!
    var userId: String!
    var user: User!
    var error: ErrorApi!
    
    var users = [User]()
    var chats = [Chat]()

    func logOut() {
        accessToken = nil
        user = nil
    }

    func deleteAccount() {
        logOut()
    }
    
    func loadSelf(completionBlock: (User?) -> ()) {        
        Alamofire.request(.GET, "https://dev.quesee.co:443/v1/users")
            .response { (request, response, data, error) in
                if response?.statusCode == 200 {
                    let datax = data as! NSData
                    self.user = UserApi(JSONDecoder(datax)).toUser()
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        completionBlock(self.user)
                    })
                } else if response?.statusCode == 400 {
                    self.accessToken = nil
                } else {
                    // manage other errors (500)
                }
                
        }
    }
    
    func loadConversations(count: Int, page: Int, completionBlock: (NSError?) -> ()) {
        let params: Dictionary<String,AnyObject> = [
            "count": count,
            "page": page
        ]
        Alamofire.request(.GET, "https://dev.quesee.co/v1/conversations", parameters: params)
            .response { (request, response, data, error) in
                if response?.statusCode == 200 {
                    let datax = data as! NSData
                    self.chats = ConversationListApi(JSONDecoder(datax)).toChats()
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        completionBlock(error)
                    })
                } else if response?.statusCode == 400 {
                    self.accessToken = nil
                } else {
                    // handle other errors (500)
                }
        }
    }
    
    func loadContacts(count: Int, page: Int, completionBlock: (NSError?) -> ()) {
        let params: Dictionary<String,AnyObject> = [
            "count": count,
            "page": page
        ]
        Alamofire.request(.GET, "https://dev.quesee.co/v1/contacts", parameters: params)
            .response { (request, response, data, error) in
                if response?.statusCode == 200 {
                    let datax = data as! NSData                    
                    //Synch contacts list
                    let contactList = ContactListApi(JSONDecoder(datax))
                    contactList.synchLocal()
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        completionBlock(error)
                    })
                } else if response?.statusCode == 400 {
                    self.accessToken = nil
                } else {
                    // handle other errors (500)
                }
        }
    }
    
    func login(email: String, password: String) {
        let params: Dictionary<String,AnyObject> = [
            "userAgent": "param1",
            "platform": "2",
            "cloudId": UIDevice.currentDevice().identifierForVendor,
            "email": email,
            "password" : password
        ]
        Alamofire.request(.POST, "https://dev.quesee.co/v1/sessions", parameters: params)
            .response { (request, response, data, error) in
                if response?.statusCode == 200 {
                    self.error = nil
                    self.userId = response?.allHeaderFields["X-QUESEE-AUTHTOKEN"] as! String
                    self.accessToken = response?.allHeaderFields["X-QUESEE-AUTHTOKEN"] as! String
                } else {
                    let datax = data as! NSData
                    self.error = ErrorApi(JSONDecoder(datax))
                    self.accessToken = nil
                }
                
        }
    }
}
