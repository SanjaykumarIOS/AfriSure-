


import SwiftUI

extension Extensions {
    static var reloadLanguage = false
}

class Extensions: NSObject
{
    
    class var userName : String
    {
        get {
            if let userName = UserDefaults.standard.value(forKey: "userName") as? String {
                return userName
            }
            return ""
            
        } set{
            UserDefaults.standard.set(newValue, forKey: "userName")
        }
    }
    
    class var emailID : String
    {
        get {
            if let emailID = UserDefaults.standard.value(forKey: "emailID") as? String {
                return emailID
            }
            return ""
            
        }set{
            UserDefaults.standard.set(newValue, forKey: "emailID")
        }
    }
    
    class var productID : Int
    {
        get {
            if let productID = UserDefaults.standard.value(forKey: "productID") as? Int {
                return productID
            }
            return 0
            
        }set{
            UserDefaults.standard.set(newValue, forKey: "productID")
        }
    }

    class var quotationDetailRefID : String
    {
        get {
            if let quotationDetailRefID = UserDefaults.standard.value(forKey: "quotationDetailRefID") as? String {
                return quotationDetailRefID
            }
            return ""
            
        }set{
            UserDefaults.standard.set(newValue, forKey: "quotationDetailRefID")
        }
    }

    class var userUid : String
    {
        get {
            if let userUid = UserDefaults.standard.value(forKey: "userUid") as? String {
                return userUid
            }
            return ""
            
        }set{
            UserDefaults.standard.set(newValue, forKey: "userUid")
        }
    }

    class var lineOfBusinessID : String
    {
        get {
            if let lineOfBusinessID = UserDefaults.standard.value(forKey: "lineOfBusinessID") as? String {
                return lineOfBusinessID
            }
            return ""
            
        }set{
            UserDefaults.standard.set(newValue, forKey: "lineOfBusinessID")
        }
    }
    
    
    class var token : String
    {
        get {
            if let token = UserDefaults.standard.value(forKey: "token") as? String {
                return token
            }
            return ""
            
        }set{
            UserDefaults.standard.set(newValue, forKey: "token")
        }
    }
    
    class var policyID : String
    {
        get {
            if let policyID = UserDefaults.standard.value(forKey: "policyID") as? String {
                return policyID
            }
            return ""
            
        }set{
            UserDefaults.standard.set(newValue, forKey: "policyID")
        }
    }

    
    class var organisationAppID: String
    {
        get {
            if let organisationAppID = UserDefaults.standard.value(forKey: "organisationAppID") as? String {
                return organisationAppID
            }
            return ""
            
        }set{
            UserDefaults.standard.set(newValue, forKey: "organisationAppID")
        }
    }

    
    class var selectedLineOfBusiness : String
    {
        get {
            if let selectedLineOfBusiness = UserDefaults.standard.value(forKey: "selectedLineOfBusiness") as? String {
                return selectedLineOfBusiness
            }
            return ""
            
        }set{
            UserDefaults.standard.set(newValue, forKey: "selectedLineOfBusiness")
        }
    }
    
    class var quotationID : String
    {
        get {
            if let quotationID = UserDefaults.standard.value(forKey: "quotationID") as? String {
                return quotationID
            }
            return ""
            
        }set{
            UserDefaults.standard.set(newValue, forKey: "quotationID")
        }
    }
    
    class var selectedItem: Set<String> {
           get {
               if let selectedItems = UserDefaults.standard.value(forKey: "selectedItem") as? [String] {
                   return Set(selectedItems)
               }
               return []
           }
           set {
               UserDefaults.standard.set(Array(newValue), forKey: "selectedItem")
           }
       }
    
    class func getValidationDict()->NSDictionary
    {
        let errorDict = ["ERR001":"Please select your organisation to continue!",
                         "ERR002":"Please enter your email address to continue!",
                         "ERR003":"Please enter valid email address to continue!",
                         "ERR004":"Please enter your password to continue!",
                         "ERR005":"Please enter your full name to continue!",
                         "ERR006":"Please enter your phone number to continue!",
                         "ERR007":"Please enter your valid phone number to continue!",
                         "ERR008":"Please select adjustment type to continue!",
                         "ERR009":"Please select risk category to continue!",
                         "ERR010":"Please enter amount to continue!",
                         "ERR011":"Amount value cannot be 0.",
                         "ERR012":"Amount exceeds the maximum limit of ",
                         "ERR013":"Please enter comments to continue!",
                         "ERR014":"Something went wrong",
                         "ERR015":"Customer Type is required",
                         "ERR016":"Either Customer ID or Customer Name is required",
                         "ERR017":"Please select the customer",
                         "API001":"Server Error: Oops! Something went wrong on our end. Our servers are experiencing technical difficulties. We apologize for the inconvenience. Please try again later."
                        ]
        return errorDict as NSDictionary
    }
    
    
    class var selectedLanguage : String
    {
        get {
            if let selectedLanguage = UserDefaults.standard.value(forKey: "selectedLanguage") as? String {
                return selectedLanguage
            }
            return ""
            
        } set {
            UserDefaults.standard.set(newValue, forKey: "selectedLanguage")
        }
    }


}



extension Text {
    func halfTextColorChange(fullText: String, changeText: String) -> Text {
        guard let range = fullText.range(of: changeText) else {
            return self
        }
        
        let beforeChange = String(fullText[..<range.lowerBound])
        let afterChange = String(fullText[range.upperBound...])
        
        return Text(beforeChange)
            .foregroundColor(.black) +
            Text(changeText)
            .foregroundColor(toolbarcolor) +
            Text(afterChange)
            .foregroundColor(.black)
    }
}
