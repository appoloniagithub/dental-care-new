//
//  banner.swift
//  SampleTest
//
//  Created by Sanju Mohamed Sageer on 15/08/2022.
//


import Foundation
import NotificationBannerSwift



import UIKit
import NotificationBannerSwift

class BannerNotification{
    
    private init() {
        
    }
    
    static func successBanner(message:String){
        successBanner(title: "", message: message)
    }
    
    static func successBanner(title:String,message:String){
        if NotificationBannerQueue.default.numberOfBanners == 0 {
            let banner = FloatingNotificationBanner(title: title,
                                                    subtitle: message,
                                                    subtitleTextAlign:.center,
                                                    style: .success)
            banner.backgroundColor = UIColor.systemGreen
            banner.titleLabel?.textColor = UIColor.white
            
                banner.show(
                    
                cornerRadius: 15,
                shadowColor: UIColor(red: 0.431, green: 0.459, blue: 0.494, alpha: 1),
                shadowBlurRadius: 16,
                shadowEdgeInsets: UIEdgeInsets(top: 8, left: 8, bottom: 0, right: 8))
        }
    }
    
    static func failureBanner(title:String,message:String){
        if NotificationBannerQueue.default.numberOfBanners == 0{
            let banner = FloatingNotificationBanner(title: title,
                                                    subtitle: message,
                                                    subtitleTextAlign:.center,
                                                    style: .danger)
            banner.show(
                cornerRadius: 15,
                shadowColor: UIColor(red: 0.431, green: 0.459, blue: 0.494, alpha: 1),
                shadowBlurRadius: 16,
                shadowEdgeInsets: UIEdgeInsets(top: 8, left: 8, bottom: 0, right: 8))
        }
    }
    
    static func failureBanner(message:String){
        failureBanner(title: "", message: message)
    }
    
}
