//
//  dentalCareLanguageManager.swift
//  Dental Care
//
//  Created by Sanju Mohamed Sageer on 21/11/2022.
//

import Foundation
class DCLanguageManager: NSObject {
    var bundle: Bundle!
    let customLang_ = CustomLanguage()

    class var sharedInstance: DCLanguageManager {
        struct Singleton {
            static let instance: DCLanguageManager = DCLanguageManager()
        }
        return Singleton.instance
    }
    
    func localizedStringForKey(key:String, comment:String) -> String {
        return bundle.localizedString(forKey: key, value: comment, table: nil)
    }
    
    func localizedImagePathForImg(imagename:String, type:String) -> String {
        guard let imagePath =  bundle.path(forResource: imagename, ofType: type) else {
            return ""
        }
        return imagePath
    }
    
    //MARK:- setLanguage
    // Sets the desired language of the ones you have.
    // If this function is not called it will use the default OS language.
    // If the language does not exists y returns the default OS language.
    func setLanguage(languageCode:String) {
        var appleLanguages = UserDefaults.standard.object(forKey: "AppleLanguages") as! [String]
        appleLanguages.remove(at: 0)
        appleLanguages.insert(languageCode, at: 0)
        UserDefaults.standard.set(appleLanguages, forKey: "AppleLanguages")
        UserDefaults.standard.synchronize() //needs restrat
                
        dcPlistManager.setValueForKey(USER_PREFERRED_LANGUAGE, value: languageCode as AnyObject, plistFileName: LANGUAGE_SETTINGS_PLIST)
        
        if let languageDirectoryPath = Bundle.main.path(forResource: languageCode, ofType: "lproj")  {
            bundle = Bundle.init(path: languageDirectoryPath)
        } else {
            resetLocalization()
        }
        //KeychainWrapper.shared.save(languageCode, forKey: LOCALE_LANGUAGE)
    }
    
    //MARK:- resetLocalization
    //Resets the localization system, so it uses the OS default language.
    func resetLocalization() {
        bundle = Bundle.main
    }
    
    //MARK:- getLanguage
    // Just gets the current setted up language.
    func getLanguage() -> String {
        var prefferedLanguage = "en"
        let prefLanFromCache = dcPlistManager.getValueForKey(USER_PREFERRED_LANGUAGE, plistFileName: LANGUAGE_SETTINGS_PLIST) as? String
        if prefLanFromCache != nil && prefLanFromCache != "" {
            prefferedLanguage = prefLanFromCache!
        }else {
            let appleLanguages = UserDefaults.standard.object(forKey: "AppleLanguages") as? [String]
            if appleLanguages != nil {
                prefferedLanguage = appleLanguages![0]
                if prefferedLanguage.contains("-") {
                    let array = prefferedLanguage.components(separatedBy: "-")
                    prefferedLanguage = array[0]
                }
            }
        }
        
       // KeychainWrapper.shared.save(prefferedLanguage, forKey: LOCALE_LANGUAGE)
        if APP_SUPPORTED_LANGUAGES.contains(prefferedLanguage) {
        }else {
            prefferedLanguage = "en"
        }
        
        return prefferedLanguage
    }
    
    func getDeviceLanguage()-> String? {
        var prefferedLanguage = "en"
        let appleLanguages = UserDefaults.standard.object(forKey: "AppleLanguages") as? [String]
        if appleLanguages != nil {
            prefferedLanguage = appleLanguages![0]
        }
        return prefferedLanguage
    }
    
    func getLocaleLanguage()->String {
        var lan = "en"
        let locale = DCLanguageManager.sharedInstance.getLanguage()
        if locale != "en" {
            lan = locale
        }
        return lan
    }

    class func get_localizedString(_ givenString : String) -> String {
        return NSLocalizedString(givenString, tableName: nil, bundle: DCLanguageManager.sharedInstance.customLang_.createBundlePath(), value: "", comment: "")
    }
}

struct CustomLanguage {
    func createBundlePath () -> Bundle {
        let selectedLanguage = DCLanguageManager.sharedInstance.getLanguage()//recover the language chosen by the user (in my case, from UserDefaults)
        var path = Bundle.main.path(forResource: selectedLanguage, ofType: "lproj")
        if path == nil {
            path = Bundle.main.path(forResource: "en", ofType: "lproj")
        }
        return Bundle(path: path!)!
    }
}
