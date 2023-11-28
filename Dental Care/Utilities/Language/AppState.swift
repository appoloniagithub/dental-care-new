//
//  AppState.swift
//  Dental Care
//
//  Created by Sanju Mohamed Sageer on 21/11/2022.
//

import Foundation
class AppState {
    enum EXLanguage :String {
        case en = "en"
        case ar = "ar"
    }
    
    static let userDefaults = UserDefaults.standard
    
    static var userID: Int? {
        get {
            if let value = userDefaults.value(forKey: "userId") as? Int {
                return value
            } else {
                return nil
            }
        } set {
            userDefaults.set(newValue, forKey: "userId")
            print("============= AppState ============\n Login Status :\(isLoggedIn) \n ==========================")
        }
    }
    static var languageselected: Bool? {
        get {
            if let value = userDefaults.value(forKey: "Languageselected") as? Bool {
                return value
            } else {
                return nil
            }
        } set {
            userDefaults.set(newValue, forKey: "Languageselected")
        }
    }
    
    static var currentLanguage:EXLanguage {
        get {
            return isEnglish ? .en : .ar
        }
    }
    
    static var isEnglish:Bool {
           get {
               if let value = userDefaults.value(forKey: "isEnglish") as? Bool {
                   return value
               } else {
                   return true
               }
           } set {
               userDefaults.set(newValue, forKey: "isEnglish")
           }
       }
    
    
    static var userName: String? {
           get {
               if let value = userDefaults.value(forKey: "userName") as? String {
                   return value
               } else {
                   return "Hi Guest"
               }
           } set {
               userDefaults.set(newValue, forKey: "userName")
           }
       }
    
    static var userMail: String? {
           get {
               if let value = userDefaults.value(forKey: "userMail") as? String {
                   return value
               } else {
                   return ""
               }
           } set {
               userDefaults.set(newValue, forKey: "userMail")
           }
       }
    static var orderid: Int? {
           get {
               if let value = userDefaults.value(forKey: "orderId") as? Int {
                   return value
               } else {
                   return -1
                
               }
           } set {
               userDefaults.set(newValue, forKey: "orderId")
           }
       }
    
    
    static var session:String {
        get {
            if let value = userDefaults.value(forKey: "session") as? String {
                return value
            } else {
                return ""
            }
        } set {
            print("========= Saving New Session ========= \n \(newValue) \n ===================")
            userDefaults.set(newValue, forKey: "session")
        }
    }
    static var stepsfinished:String {
        get {
            if let value = userDefaults.value(forKey: "stepsfinished") as? String {
                return value
            } else {
                return ""
            }
        } set {
           // print("========= Saving New Session ========= \n \(newValue) \n ===================")
            userDefaults.set(newValue, forKey: "stepsfinished")
        }
    }
    
    static var tempSession:String?
    
    static var preUserID:Int {
        get {
            if let value = userDefaults.value(forKey: "preUserID") as? Int {
                return value
            } else {
                return -1
            }
        } set {
            print("============= AppState ============\n changing presuser id :\(newValue) \n ==========================")
            userDefaults.set(newValue, forKey: "preUserID")
        }
    }
    
    static var isLoggedIn: Bool {
        get {
            if let _ = userID {
                return true
            } else {
                return false
            }
        }
    }
    
    static var isAGuestUser : Bool {
        get {
            if let value = userDefaults.value(forKey: "isAGuestUser") as? Bool {
                return value
            } else {
                return false
            }
        } set {
            userDefaults.set(newValue, forKey: "isAGuestUser")
        }
    }
    
    static var isAGuestCheckout:Bool {
           get {
               if let value = userDefaults.value(forKey: "isAGuestCheckout") as? Bool {
                   return value
               } else {
                   return false
               }
           } set {
               userDefaults.set(newValue, forKey: "isAGuestCheckout")
           }
       }
    
    static var guestAddress: String? {
        get {
            if let value = userDefaults.value(forKey: "guestAddress") as? String {
                return value
            } else {
                return nil
            }
        } set {
            userDefaults.set(newValue, forKey: "guestAddress")
        }
    }
    static var locationindex: Int? {
           get {
               if let value = userDefaults.value(forKey: "locationindex") as? Int {
                   return value
               } else {
                   return 0
               }
           } set {
               userDefaults.set(newValue, forKey: "locationindex")
           }
       }
 
    static var imageurl:String {
        get {
            if let value = userDefaults.value(forKey: "imageurl") as? String {
                return value
            } else {
                return ""
            }
        } set {
           // print("========= Saving New Session ========= \n \(newValue) \n ===================")
            userDefaults.set(newValue, forKey: "imageurl")
        }
    }
    static var learninglevel:String {
        get {
            if let value = userDefaults.value(forKey: "learninglevel") as? String {
                return value
            } else {
                return ""
            }
        } set {
           // print("========= Saving New Session ========= \n \(newValue) \n ===================")
            userDefaults.set(newValue, forKey: "learninglevel")
        }
    }
    static var availableteachers:Int {
        get {
            if let value = userDefaults.value(forKey: "availableteachers") as? Int {
                return value
            } else {
                return 0
            }
        } set {
           // print("========= Saving New Session ========= \n \(newValue) \n ===================")
            userDefaults.set(newValue, forKey: "availableteachers")
        }
    }
    static var about:String {
        get {
            if let value = userDefaults.value(forKey: "about") as? String {
                return value
            } else {
                return ""
            }
        } set {
           // print("========= Saving New Session ========= \n \(newValue) \n ===================")
            userDefaults.set(newValue, forKey: "about")
        }
    }
    

    

    

    
    
    static var isFromCart : Bool = false
    
    static var deviceToken : String  = ""
    

    
    
}
