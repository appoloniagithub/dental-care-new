//
//  utilities.swift
//  SampleTest
//
//  Created by Sanju Mohamed Sageer on 07/07/2022.
//

import Foundation
import UIKit
import WebKit
import AVFoundation
import KVSpinnerView
//@IBDesignable extension UIButton {
//    @IBInspectable  override var cornerRadius: CGFloat {
//        get { return layer.cornerRadius }
//
//        set {
//            layer.cornerRadius = newValue
//            layer.masksToBounds = (newValue > 0)
//        }
//    }
//}

@IBDesignable extension UIView {
  
    // Rounded corner raius
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return self.layer.cornerRadius
        }
        set {
            self.layer.cornerRadius = newValue
        }
    }
    
    // Shadow color
    @IBInspectable var shadowColor: UIColor {
        get {
            return UIColor(cgColor: self.layer.shadowColor!)
        }
        set {
            self.layer.shadowColor = newValue.cgColor
        }
    }
    
    // Shadow offsets
    @IBInspectable var shadowOffset: CGSize {
        get {
            return self.layer.shadowOffset
        }
        set {
            self.layer.shadowOffset = newValue
        }
    }
    
    // Shadow opacity
    @IBInspectable var shadowOpacity: Float {
        get {
            return self.layer.shadowOpacity
        }
        set {
            self.layer.shadowOpacity = newValue
        }
    }
    
    // Shadow radius
    @IBInspectable var shadowRadius: CGFloat {
        get {
            return self.layer.shadowRadius
        }
        set {
            self.layer.shadowRadius = newValue
        }
    }
    
    // Border width
    @IBInspectable var borderWidth: CGFloat {
        get {
            return self.layer.borderWidth
        }
        set {
            self.layer.borderWidth = newValue
        }
    }
    
    // Border color
    @IBInspectable var borderColor: UIColor {
        get {
            return UIColor(cgColor: self.layer.borderColor!)
        }
        set {
            self.layer.borderColor = newValue.cgColor
        }
    }
    
    // Background color
    @IBInspectable var layerBackgroundColor: UIColor {
        get {
            return UIColor(cgColor: self.layer.backgroundColor!)
        }
        set {
            self.backgroundColor = nil
            self.layer.backgroundColor = newValue.cgColor
        }
    }
  
    // Create bezier path of shadow for rasterize
    @IBInspectable var enableBezierPath: Bool {
        get {
            return self.layer.shadowPath != nil
        }
        set {
            if enableBezierPath {
                self.layer.shadowPath = UIBezierPath(roundedRect: self.layer.bounds, cornerRadius: self.layer.cornerRadius).cgPath
            } else {
                self.layer.shadowPath = nil
            }
        }
    }
    
    // Mask to bounds controll
    @IBInspectable var maskToBounds: Bool {
        get{
            return self.layer.masksToBounds
        }
        set {
            self.layer.masksToBounds = newValue
        }
    }
    
    // Rasterize option
    @IBInspectable var rasterize: Bool {
        get {
            return self.layer.shouldRasterize
        }
        set {
            self.layer.shouldRasterize = newValue
            self.layer.rasterizationScale = UIScreen.main.scale
        }
    }
    @IBInspectable var roundEdgeCorners:Bool {
        get{
            return self.roundEdgeCorners
        }
        set{
            if newValue{
                self.layer.cornerRadius = self.frame.height/2
            }else{
                self.layer.cornerRadius = cornerRadius
            }
        }
    }
}
public func getGreeting() -> String {
     let hour = Calendar.current.component(.hour, from: Date())

     switch hour {
     case 0..<4:
         return "Hello"
     case 4..<12:
         return "Good Morning"
     case 12..<18:
         return "Good Afternoon"
     case 18..<24:
         return "Good Evening"
     default:
         break
     }
     return "Hello"
 }
extension UINavigationController {
  func popToViewController(ofClass: AnyClass, animated: Bool = true) {
    if let vc = viewControllers.last(where: { $0.isKind(of: ofClass) }) {
      popToViewController(vc, animated: animated)
    }
  }
}
extension UIView {
  func addDashedBorder() {
    let color = UIColor.red.cgColor

    let shapeLayer:CAShapeLayer = CAShapeLayer()
    let frameSize = self.frame.size
    let shapeRect = CGRect(x: 0, y: 0, width: frameSize.width, height: frameSize.height)

    shapeLayer.bounds = shapeRect
    shapeLayer.position = CGPoint(x: frameSize.width/2, y: frameSize.height/2)
    shapeLayer.fillColor = UIColor.clear.cgColor
    shapeLayer.strokeColor = color
    shapeLayer.lineWidth = 2
    shapeLayer.lineJoin = CAShapeLayerLineJoin.round
    shapeLayer.lineDashPattern = [6,3]
    shapeLayer.path = UIBezierPath(roundedRect: shapeRect, cornerRadius: 5).cgPath

    self.layer.addSublayer(shapeLayer)
    }
}
public func convertBase64ToImage(imageString: String) -> UIImage {
   
    let imageData = Data(base64Encoded: imageString ,
                             options: Data.Base64DecodingOptions.ignoreUnknownCharacters)!
    return UIImage(data: imageData)!
    }
extension Array where Element: Sequence {
    func joined() -> Array<Element.Element> {
        return self.reduce([], +)
    }
}
extension UIView {
    public func takeScreenshot() -> UIImage {
        
        // Begin context
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, false, UIScreen.main.scale)
        
        // Draw view in that context
        drawHierarchy(in: self.bounds, afterScreenUpdates: true)
        
        // And finally, get image
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        if (image != nil)
        {
            return image!
        }
        return UIImage()
    }



}
class Utility: NSObject {
class func changeLayoutCorrespondingToLanguage() {
    let selLanguage = DCLanguageManager.sharedInstance.getLanguage()
    if selLanguage == "ar" {
       // UIView.appearance().semanticContentAttribute = .forceRightToLeft
        UICollectionView.appearance().semanticContentAttribute = .forceRightToLeft
        UITableView.appearance().semanticContentAttribute = .forceRightToLeft
        UIScrollView.appearance().semanticContentAttribute = .forceRightToLeft
        WKWebView.appearance().semanticContentAttribute = .forceRightToLeft
        UILabel.appearance().semanticContentAttribute = .forceRightToLeft
        UITextView.appearance().semanticContentAttribute = .forceRightToLeft
        UIButton.appearance().semanticContentAttribute = .forceRightToLeft
        
    }else {
        UIView.appearance().semanticContentAttribute = .forceLeftToRight
        UICollectionView.appearance().semanticContentAttribute = .forceLeftToRight
        UITableView.appearance().semanticContentAttribute = .forceLeftToRight
        UIScrollView.appearance().semanticContentAttribute = .forceLeftToRight
        WKWebView.appearance().semanticContentAttribute = .forceLeftToRight
        UILabel.appearance().semanticContentAttribute = .forceLeftToRight
        UITextView.appearance().semanticContentAttribute = .forceLeftToRight
        UIButton.appearance().semanticContentAttribute = .forceLeftToRight
    }
}
}
//public func toggleTorch(on: Bool) {
//    guard let device = AVCaptureDevice.default(for: AVMediaType.video)
//    else {return}
//    
//    if device.hasTorch {
//        do {
//            try device.lockForConfiguration()
//          
//            
//            if on == true {
//                device.torchMode = .on
//                
//            } else {
//                device.torchMode = .off
//            }
//            
//            device.unlockForConfiguration()
//        } catch {
//            print("Torch could not be used")
//        }
//    } else {
//        print("Torch is not available")
//    }
//}
class RefreshTocken:UIViewController {
    
    static let shared = RefreshTocken()
    
    static var myProperty: String = ""
    static var refreshdone:Int = 0
   // var navigationController: UINavigationController?
   
   
//        let rootViewController = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "LoginVC")
//        guard let navigationController = senavigationController else { return }
//        var navigationArray = navigationController.viewControllers // To get all UIViewController stack as Array
//        navigationArray.removeAll()// To remove previous UIViewController
//        navigationArray.append(rootViewController)
//
//        navigationController?.viewControllers = navigationArray
//      }
    private init() {
            super.init(nibName: nil, bundle: nil)
                
        }
    override func viewDidLoad() {
           super.viewDidLoad()
        let rootViewController = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "LoginVC")
        guard let navigationController = navigationController else { return }
        var navigationArray = navigationController.viewControllers // To get all UIViewController stack as Array
        navigationArray.removeAll()// To remove previous UIViewController
        navigationArray.append(rootViewController)

        navigationController.viewControllers = navigationArray
       }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func myMethod() {
        // Method code here
    }
    public func refreshtokenapi() {
       // navigationController?.navigationBar.isUserInteractionEnabled = true
        
     
        let parameters = [
            
            "fileId" :  UserDefaults.standard.string(forKey: "fileID")!,
            "refreshToken":UserDefaults.standard.string(forKey: "refresh_token")!
        ] as [String : Any]
        
       // KVSpinnerView.show(saying: "Please Wait")
        NetworkManager.webcallWithErrorCode(urlString: remote_Base_URL + "api/user/refreshToken", methodeType: .post,parameter: parameters) {  (status, response) in
            print(response)
            switch status {
            case .noNetwork:
                print("network error")
                BannerNotification.failureBanner(message: "No network Connection")
                
            case .success :
              //  KVSpinnerView.dismiss()
                print("success")
                //      print(response["data"]!)
                if let data = response["data"] as? Json{
                    
                    if response["success"] as? String  == "1" {
                        if let access = response["access_token"] {
                            
                            
                            
                            
                            UserDefaults.standard.set(access, forKey: "access_token")
                        }
              }
                    
                      

                        
                            
                       

                    }
                
                
            case .failure :
                print("failure")
                if let data = response["data"] as? Json{
                    
                    
                    
                    
                    if data["success"] as! Int  == 1 {
                        if let access = response["accessToken"] {
                            
                            
                            
                            
                            UserDefaults.standard.set(access, forKey: "access_token")
                        }
                      //  BannerNotification.failureBanner(message: "\(response["message"]!)")
                        RefreshTocken.refreshdone = 1
//                        UserDefaults.standard.set("", forKey: "fileID")
//                        UserDefaults.standard.set(false, forKey: "isUserLoggedIn")
//                        UserDefaults.standard.set("", forKey: "userid")
//                        let vc = UIStoryboard.init(name: "Main", bundle:      Bundle.main).instantiateViewController(withIdentifier: "LoginVC")   as! LoginVC
//                        self.navigationController?.navigationBar.isHidden = true
//                        self.navigationController?.tabBarController?.tabBar.isHidden = true
//                        self.navigationController?.pushViewController(vc, animated: true)
                        
                    }}
                KVSpinnerView.dismiss()
               // BannerNotification.failureBanner(message: "\(response["message"]!)")
            case .unknown:
                print("unknown")
                KVSpinnerView.dismiss()
                if DCLanguageManager.sharedInstance.getDeviceLanguage() == "en" {
                    BannerNotification.failureBanner(message: "Oops! something went wrong")
                }else {
                    BannerNotification.failureBanner(message: "Oops! something went wrong")

                    
                }
            }
            
        }    }
    }


@IBDesignable class UIVerticalTextView: UIView {

    var textView = UITextView()
    let rotationView = UIView()

    var underlyingTextView: UITextView {
        get {
            return textView
        }
        set {
            textView = newValue
        }
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override init(frame: CGRect){
        super.init(frame: frame)
        self.setup()
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        self.setup()
    }

    func setup() {

        rotationView.backgroundColor = UIColor.red
        textView.backgroundColor = UIColor.yellow
        self.addSubview(rotationView)
        rotationView.addSubview(textView)

        // could also do this with auto layout constraints
        textView.frame = rotationView.bounds
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        rotationView.transform = CGAffineTransformIdentity // *** key line ***

        rotationView.frame = CGRect(origin: CGPointZero, size: CGSize(width: self.bounds.height, height: self.bounds.width))
        rotationView.transform = translateRotateFlip()
    }

    func translateRotateFlip() -> CGAffineTransform {

        var transform = CGAffineTransformIdentity

        // translate to new center
        transform = CGAffineTransformTranslate(transform, (self.bounds.width / 2)-(self.bounds.height / 2), (self.bounds.height / 2)-(self.bounds.width / 2))
        // rotate counterclockwise around center
        transform = CGAffineTransformRotate(transform, CGFloat(-M_PI_2))
        // flip vertically
        transform = CGAffineTransformScale(transform, -1, 1)

        return transform
    }
}


//}



