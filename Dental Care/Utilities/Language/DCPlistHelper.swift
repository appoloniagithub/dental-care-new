//
//  DCPlistHelper.swift
//  Dental Care
//
//  Created by Sanju Mohamed Sageer on 21/11/2022.
//

import Foundation
let appGroupIdentifier_ = "com.appolonia-dental.Dental-Care"

class dcPlistManager {
    class func setValueForKey(_ key:String, value:AnyObject, plistFileName:String) {
        let fileManager = FileManager.default
        let groupURL = fileManager
            .containerURL(forSecurityApplicationGroupIdentifier: appGroupIdentifier_)
        if groupURL != nil {
            let storagePathUrl = groupURL!.appendingPathComponent(plistFileName)
            let storagePath = storagePathUrl.path
            if fileManager.fileExists(atPath: storagePath) {
                let configDic = NSMutableDictionary(contentsOfFile: storagePathUrl.path)
                if configDic != nil {
                    configDic?.setObject(value, forKey: key as NSCopying)
                    configDic?.write(toFile: storagePathUrl.path, atomically: true)
                }
            }
        }
    }
    
    class func getValueForKey(_ plistItem:String, plistFileName:String)->AnyObject?{
        var retVal: AnyObject?
        let fileManager = FileManager.default
        let groupURL = fileManager
            .containerURL(forSecurityApplicationGroupIdentifier: appGroupIdentifier_)
        if groupURL != nil {
            let storagePathUrl = groupURL!.appendingPathComponent(plistFileName)
            let configDic = NSMutableDictionary(contentsOfFile: storagePathUrl.path)
            if configDic != nil {
                if (configDic?.allKeys.count)! > 0 {
                    retVal = configDic?.value(forKey: plistItem) as AnyObject?
                }
            }
        }
        return retVal
    }
}


