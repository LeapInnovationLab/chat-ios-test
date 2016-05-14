import Foundation
import CoreData

@objc(User)
class User: NSManagedObject {
    @NSManaged var userId: String
    @NSManaged var firstName: String
    @NSManaged var lastName: String
    @NSManaged var avatar: String
    var phone: String!
    var name: String? {
        return firstName + " " + lastName
    }
    var initials: String? {
        var initials: String?
        for name in [firstName, lastName] {
            let initial = name.substringToIndex(name.startIndex.advancedBy(1))
            if initial.lengthOfBytesUsingEncoding(NSNEXTSTEPStringEncoding) > 0 {
                initials = (initials == nil ? initial : initials! + initial)
            }
        }
        return initials
    }
    
    func getAvatarData() -> NSData {
        let avatarUrl = NSURL(string: self.avatar)
        let avatarData = NSData(contentsOfURL: avatarUrl!)
        return avatarData!
    }
}
