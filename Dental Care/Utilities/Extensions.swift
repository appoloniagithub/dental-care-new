//
//  Extensions.swift
//  Appolonia
//
//  Created by Sanju Mohamed Sageer on 17/08/2022.
//




import Foundation
import UIKit
extension String {
    func isValidEmail() -> Bool {
        // here, `try!` will always succeed because the pattern is valid
        let regex = try! NSRegularExpression(pattern: "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$", options: .caseInsensitive)
        return regex.firstMatch(in: self, options: [], range: NSRange(location: 0, length: count)) != nil
    }
}
extension UITextField {
    func datePicker<T>(target: T,
                       doneAction: Selector,
                       cancelAction: Selector,
                       datePickerMode: UIDatePicker.Mode = .date) {
        let screenWidth = UIScreen.main.bounds.width
        
        func buttonItem(withSystemItemStyle style: UIBarButtonItem.SystemItem) -> UIBarButtonItem {
            let buttonTarget = style == .flexibleSpace ? nil : target
            let action: Selector? = {
                switch style {
                case .cancel:
                    return cancelAction
                case .done:
                    return doneAction
                default:
                    return nil
                }
            }()
            
            let barButtonItem = UIBarButtonItem(barButtonSystemItem: style,
                                                target: buttonTarget,
                                                action: action)
            
            return barButtonItem
        }
        
        let datePicker = UIDatePicker(frame: CGRect(x: 0,
                                                    y: 0,
                                                    width: screenWidth,
                                                    height: 216))
        datePicker.datePickerMode = datePickerMode
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
        } else {
            // Fallback on earlier versions
        }
        self.inputView = datePicker
        
        let toolBar = UIToolbar(frame: CGRect(x: 0,
                                              y: 0,
                                              width: screenWidth,
                                              height: 44))
        toolBar.setItems([buttonItem(withSystemItemStyle: .cancel),
                          buttonItem(withSystemItemStyle: .flexibleSpace),
                          buttonItem(withSystemItemStyle: .done)],
                         animated: true)
        self.inputAccessoryView = toolBar
    }
}
extension UIColor {
    convenience init(hexFromString:String, alpha:CGFloat = 1.0) {
      var cString:String = hexFromString.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
      var rgbValue:UInt32 = 10066329 //color #999999 if string has wrong format

        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }

        if ((cString.count) == 6) {
            Scanner(string: cString).scanHexInt32(&rgbValue)
        }

        self.init(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: alpha
        )
    }
}

@IBDesignable
class GradientHorizontalProgressBar: UIView {
    @IBInspectable var color: UIColor = UIColor(hexFromString: "833177") {
        didSet { setNeedsDisplay() }
    }
    @IBInspectable var gradientColor: UIColor = .white {
        didSet { setNeedsDisplay() }
    }

    var progress: CGFloat = 0 {
        didSet { setNeedsDisplay() }
    }

    private let progressLayer = CALayer()
    private let gradientLayer = CAGradientLayer()
    private let backgroundMask = CAShapeLayer()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayers()
        createAnimation()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupLayers()
      //  createAnimation()
    }

    private func setupLayers() {
        layer.addSublayer(gradientLayer)

        gradientLayer.mask = progressLayer
        gradientLayer.locations = [0.35, 0.5, 0.65]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
    }

    private func createAnimation() {
        let flowAnimation = CABasicAnimation(keyPath: "locations")
        flowAnimation.fromValue = [-0.3, -0.15, 0]
        flowAnimation.toValue = [1, 1.15, 1.3]

        flowAnimation.isRemovedOnCompletion = false
        flowAnimation.repeatCount = Float.infinity
        flowAnimation.duration = 1

        gradientLayer.add(flowAnimation, forKey: "flowAnimation")
    }

    override func draw(_ rect: CGRect) {
        backgroundMask.path = UIBezierPath(roundedRect: rect, cornerRadius: rect.height * 0.25).cgPath
        layer.mask = backgroundMask

        let progressRect = CGRect(origin: .zero, size: CGSize(width: rect.width * progress, height: rect.height))

        progressLayer.frame = progressRect
        progressLayer.backgroundColor = UIColor.black.cgColor

        gradientLayer.frame = rect
        gradientLayer.colors = [color.cgColor, gradientColor.cgColor, color.cgColor]
        gradientLayer.endPoint = CGPoint(x: progress, y: 0.5)
    }
}
@IBDesignable class GradientView: UIView {
    @IBInspectable var firstColor: UIColor =   UIColor(hexFromString: "#A9C23F")
    @IBInspectable var secondColor: UIColor =  UIColor(hexFromString: "#556120")

    @IBInspectable var vertical: Bool = true

    lazy var gradientLayer: CAGradientLayer = {
        let layer = CAGradientLayer()
        layer.colors = [firstColor.cgColor, secondColor.cgColor]
        layer.startPoint = CGPoint.zero
        return layer
    }()

    //MARK: -

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        applyGradient()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        applyGradient()
    }

    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        applyGradient()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        updateGradientFrame()
    }

    //MARK: -

    func applyGradient() {
        updateGradientDirection()
        layer.sublayers = [gradientLayer]
    }

    func updateGradientFrame() {
        gradientLayer.frame = bounds
    }

    func updateGradientDirection() {
        gradientLayer.endPoint = vertical ? CGPoint(x: 0, y: 1) : CGPoint(x: 1, y: 0)
    }
}

@IBDesignable class ThreeColorsGradientView: UIView {
    @IBInspectable var firstColor: UIColor = UIColor.red
    @IBInspectable var secondColor: UIColor = UIColor.green
    @IBInspectable var thirdColor: UIColor = UIColor.blue

    @IBInspectable var vertical: Bool = true {
        didSet {
            updateGradientDirection()
        }
    }

    lazy var gradientLayer: CAGradientLayer = {
        let layer = CAGradientLayer()
        layer.colors = [firstColor.cgColor, secondColor.cgColor, thirdColor.cgColor]
        layer.startPoint = CGPoint.zero
        return layer
    }()

    //MARK: -

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        applyGradient()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        applyGradient()
    }

    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        applyGradient()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        updateGradientFrame()
    }

    //MARK: -

    func applyGradient() {
        updateGradientDirection()
        layer.sublayers = [gradientLayer]
    }

    func updateGradientFrame() {
        gradientLayer.frame = bounds
    }

    func updateGradientDirection() {
        gradientLayer.endPoint = vertical ? CGPoint(x: 0, y: 1) : CGPoint(x: 1, y: 0)
    }
}
extension UIImage {
    func rotate(radians: CGFloat) -> UIImage {
        let rotatedSize = CGRect(origin: .zero, size: size)
            .applying(CGAffineTransform(rotationAngle: CGFloat(radians)))
            .integral.size
        UIGraphicsBeginImageContext(rotatedSize)
        if let context = UIGraphicsGetCurrentContext() {
            let origin = CGPoint(x: rotatedSize.width / 2.0,
                                 y: rotatedSize.height / 2.0)
            context.translateBy(x: origin.x, y: origin.y)
            context.rotate(by: radians)
            draw(in: CGRect(x: -origin.y, y: -origin.x,
                            width: size.width, height: size.height))
            let rotatedImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            return rotatedImage ?? self
        }
        
        return self
    }
}
@IBDesignable class GradientBlueView: UIView {
    @IBInspectable var firstColor: UIColor =   UIColor(hexFromString: "#A9C23F")
    @IBInspectable var secondColor: UIColor =  UIColor(hexFromString: "#19578B")

    @IBInspectable var vertical: Bool = true

    lazy var gradientLayer: CAGradientLayer = {
        let layer = CAGradientLayer()
        layer.colors = [firstColor.cgColor, secondColor.cgColor]
        layer.startPoint = CGPoint.zero
        return layer
    }()

    //MARK: -

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        applyGradient()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        applyGradient()
    }

    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        applyGradient()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        updateGradientFrame()
    }

    //MARK: -

    func applyGradient() {
        updateGradientDirection()
        layer.sublayers = [gradientLayer]
    }

    func updateGradientFrame() {
        gradientLayer.frame = bounds
    }

    func updateGradientDirection() {
        gradientLayer.endPoint = vertical ? CGPoint(x: 0, y: 1) : CGPoint(x: 1, y: 0)
    }
}
public func formatDateandtime(date: String) -> String {
   let dateFormatterGet = DateFormatter()
   dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
   // dateFormatterGet.dateFormat = "HH:mm:ss.SSS'Z'"

   let dateFormatter = DateFormatter()
   dateFormatter.dateStyle = .medium
    dateFormatter.timeStyle = .medium
       //dateFormatter.locale = Locale(identifier: "en_US") //uncomment if you don't want to get the system default format.

   let dateObj: Date? = dateFormatterGet.date(from: date)

    return dateFormatter.string(from: dateObj!)
}
public func formatDate(date: String) -> String {
   let dateFormatterGet = DateFormatter()
   dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"

   let dateFormatter = DateFormatter()
   dateFormatter.dateStyle = .medium
    dateFormatter.timeStyle = .none
      // dateFormatter.locale = Locale(identifier: "en_US") //uncomment if you don't want to get the system default format.

   let dateObj: Date? = dateFormatterGet.date(from: date)

   return dateFormatter.string(from: dateObj!)
}


