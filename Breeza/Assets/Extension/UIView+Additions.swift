//
//  UIView+Extra.swift
//  Canary
//
//  Created by Esraa Apady on 1/27/17.
//  Copyright © 2017 canary. All rights reserved.
//

import UIKit
import Localize_Swift

extension UIImageView {
    @IBInspectable public var isDefaultArabic: Bool {
         get {
             return false
         }
         set {
             if newValue {
                if Localize.currentLanguage() == "en" {
                    transform = CGAffineTransform(scaleX: -1, y: 1)
                }
             } else {
                if Localize.currentLanguage() == "ar" {
                    transform = CGAffineTransform(scaleX: -1, y: 1)
                }
             }
         }
     }
}

extension UIView {

    @IBInspectable public var shadow1: Bool {
         get {
             return false
         }
         set {
             if newValue {
                self.addShadow(offset: CGSize(width: 0, height: 1), radius: 3, color: UIColor.lightGray, opacity: 0.3)
             }
         }
     }

    @IBInspectable public var gradient: Bool {
        get {
            return false
        }
        set {
            if newValue {
                self.gradient(startColor: UIColor.white, endColor: UIColor(hexString: "#000000", alpha: 0.18))
            }
        }
    }

    public func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }

    public func addShadow(offset: CGSize, radius: CGFloat, color: UIColor, opacity: Float, cornerRadius: CGFloat? = nil) {
        self.layer.shadowOffset = offset
        self.layer.shadowRadius = radius
        self.layer.shadowOpacity = opacity
        self.layer.shadowColor = color.cgColor
        if let r = cornerRadius {
            self.layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: r).cgPath
        }
        self.layer.masksToBounds = false
    }

    func applyNavBarConstraints(size: (width: Float, height: Float)) {
        let widthConstraint = self.widthAnchor.constraint(equalToConstant: CGFloat(size.width))
        let heightConstraint = self.heightAnchor.constraint(equalToConstant: CGFloat(size.height))
        heightConstraint.isActive = true
        widthConstraint.isActive = true
    }

    class func fromNib<T : UIView>() -> T {
        return Bundle.main.loadNibNamed(String(describing: T.self), owner: nil, options: nil)![0] as! T
    }

    func setShadow(with color:UIColor) {
        self.layer.masksToBounds = false
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOpacity = 0.3
        self.layer.shadowOffset = CGSize(width: 0, height: 1.0)
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: cornerRadius).cgPath
    }

//    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
//        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
//        let mask = CAShapeLayer()
//        mask.path = path.cgPath
//        layer.mask = mask
//    }

    public func addTapGesture(tapNumber: Int = 1, target: AnyObject, action: Selector) {
        let tap = UITapGestureRecognizer(target: target, action: action)
        tap.numberOfTapsRequired = tapNumber
        addGestureRecognizer(tap)
        isUserInteractionEnabled = true
    }

    /// EZSwiftExtensions - Make sure you use  "[weak self] (gesture) in" if you are using the keyword self inside the closure or there might be a memory leak
    public func addTapGesture(tapNumber: Int = 1, action: ((UITapGestureRecognizer) -> Void)?) {
        let tap = BlockTap(tapCount: tapNumber, fingerCount: 1, action: action)
        addGestureRecognizer(tap)
        isUserInteractionEnabled = true
    }

}

extension UIDevice {
    var iPhoneX: Bool {
        return UIScreen.main.nativeBounds.height == 2436
    }
    var iPhone: Bool {
        return UIDevice.current.userInterfaceIdiom == .phone
    }
    enum ScreenType: String {
        case iPhone4 = "iPhone 4 or iPhone 4S"
        case iPhones_5_5s_5c_SE = "iPhone 5, iPhone 5s, iPhone 5c or iPhone SE"
        case iPhones_6_6s_7_8 = "iPhone 6, iPhone 6S, iPhone 7 or iPhone 8"
        case iPhones_6Plus_6sPlus_7Plus_8Plus = "iPhone 6 Plus, iPhone 6S Plus, iPhone 7 Plus or iPhone 8 Plus"
        case iPhoneX = "iPhone X"
        case unknown
    }
    var screenType: ScreenType {
        switch UIScreen.main.nativeBounds.height {
        case 960:
            return .iPhone4
        case 1136:
            return .iPhones_5_5s_5c_SE
        case 1334:
            return .iPhones_6_6s_7_8
        case 1920, 2208:
            return .iPhones_6Plus_6sPlus_7Plus_8Plus
        case 2436:
            return .iPhoneX
        default:
            return .unknown
        }
    }
}

extension UINavigationBar {

    enum NavigationBarStyle {
        case transparent
        case transparentWithShadowLine
        case solid
        case solidNoShadow
        case translucent
    }

    // NOTE: color will only be applied to solid and translucent styles
    func setStyle(style : NavigationBarStyle,
                  tintColor : UIColor = .white,
                  forgroundColor: UIColor = .white,
                  backgroundColor : UIColor = .white) {

        switch style {
        case .transparent:
            self.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
            self.shadowImage = UIImage()
            self.isTranslucent = true
            self.backgroundColor = .clear
            self.tintColor = tintColor
        case .transparentWithShadowLine:
            self.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
            self.shadowImage = nil
            self.isTranslucent = true
            self.tintColor = tintColor
            self.backgroundColor = .clear
        case .solid:
            self.setBackgroundImage(nil, for: UIBarMetrics.default)
            self.shadowImage = nil
            self.isTranslucent = false
            self.tintColor = tintColor
            self.barTintColor = forgroundColor
        case .solidNoShadow:
            self.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
            self.shadowImage = UIImage()
            self.isTranslucent = false
            self.tintColor = tintColor
            self.barTintColor = forgroundColor
        case .translucent:
            self.setBackgroundImage(nil, for: UIBarMetrics.default)
            self.shadowImage = nil
            self.isTranslucent = true
            self.tintColor = tintColor
            self.backgroundColor = backgroundColor
            self.barTintColor = forgroundColor
        }
    }
}

class LocalizedLabel: UILabel{

    public override init(frame: CGRect) {
        super.init(frame: frame)
        if Localize.currentLanguage() == "en" {
            textAlignment = .left
        } else {
            textAlignment = .right
        }
    }
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    @IBInspectable
    public var localizedKey: String = "" {
        willSet {
            self.text = newValue.localized()
        }
    }

    @IBInspectable
    public var localizeFontSize: CGFloat = 0.0 {
        willSet {
            if Localize.currentLanguage() == "en" {
                self.font = UIFont(name: "Cairo-Regular", size: newValue)
            } else {
                self.font = UIFont(name: "Cairo-Regular", size: newValue)
            }
        }
    }
}

class LocalizedUnderlinedLabel: UILabel{

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    @IBInspectable
    public var localizedKey: String = "" {
        willSet {
            self.text = newValue.localized()
        }
    }

    @IBInspectable
    public var localizeFontSize: CGFloat = 0.0 {
        willSet {
            if Localize.currentLanguage() == "en" {
                self.font = UIFont(name: "Cairo-Regular", size: newValue)
            } else {
                self.font = UIFont(name: "Cairo-Regular", size: newValue)
            }
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        let textRange = NSRange(location: 0, length: (text?.count)!)
        let attributedText = NSMutableAttributedString(string: text!.localized())
        attributedText.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: textRange)
        self.attributedText = attributedText
    }

}



class LocalizedRoundedCornerButton: UIButton {

    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    @IBInspectable
    public var localizedKey: String = "" {
        willSet {
            self.setTitle(newValue.localized(), for: .normal)
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = self.frame.size.height/2
        self.clipsToBounds = true
        self.titleLabel?.textAlignment = .center
    }
}

class RoundedCornerView: UIView {

    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = self.frame.size.height/2
        self.clipsToBounds = true
    }
}

class RoundedCornerTextField: LocalizedTextField {

    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = self.frame.size.height/2
        self.clipsToBounds = true
    }
}

class LocalizedTextField: UITextField {

    public override init(frame: CGRect) {
        super.init(frame: frame)


    }
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        if textAlignment != .center {
            if Localize.currentLanguage() == "en" {
                textAlignment = .left
            } else {
                textAlignment = .right
            }
        }
    }

    @IBInspectable
    public var placeholderLocalizeKey: String = "" {
        willSet {
            //self.placeholder = newValue.localized()
            let attrs: [NSAttributedString.Key: Any] = [:]
            self.attributedPlaceholder  = NSMutableAttributedString(string: newValue.localized(), attributes: attrs)
        }
    }

    @IBInspectable override var placeHolderColor: UIColor? {
        get {
            return self.placeHolderColor
        }
        set {
            self.attributedPlaceholder = NSAttributedString(string: placeholderLocalizeKey.localized(), attributes:[NSAttributedString.Key.foregroundColor: newValue!])
        }
    }

    @IBInspectable
    public var localizeFontSize: CGFloat = 0.0 {
        willSet {
            if Localize.currentLanguage() == "en" {
                self.font = UIFont(name: "Cairo-Regular", size: newValue)
            } else {
                self.font = UIFont(name: "Cairo-Regular", size: newValue)
            }
        }
    }
}

class LocalizedTextView: UITextView {

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.textAlignment = Localize.currentLanguage() == "en" ? .left : .right
    }

    @IBInspectable
    public var placeholderLocalizeKey: String = "" {
        willSet {
            self.text = newValue.localized()
        }
    }
}

@IBDesignable
class RoundCornerView: UIView{

    @IBInspectable
    public var radius: CGFloat = 2 {
        willSet {
            self.layer.cornerRadius = self.frame.size.height/newValue
        }
    }



    override func layoutSubviews() {
        super.layoutSubviews()
        //self.setCornerRadius(radius: self.size.height / 2)
        self.clipsToBounds = true
    }
}

@IBDesignable
class CardView: UIView {

    @IBInspectable var shadowOffsetWidth: Int = 5
    @IBInspectable var shadowOffsetHeight: Int = 12
    @IBInspectable var shadowOffsetColor: UIColor? = UIColor.black
    @IBInspectable var shadowOpacity1: Float = 0.5


    override func layoutSubviews() {
        layer.cornerRadius = cornerRadius
        let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)

        layer.masksToBounds = true
        layer.shadowColor = shadowOffsetColor?.cgColor
        layer.shadowOffset = CGSize(width: shadowOffsetWidth, height: shadowOffsetHeight);
        layer.shadowOpacity = shadowOpacity1
        layer.shadowPath = shadowPath.cgPath
    }

}

@IBDesignable
class CircleImageView: UIImageView{

    @IBInspectable var shadowOffsetWidth: Int = 0
    @IBInspectable var shadowOffsetHeight: Int = 1//3
    @IBInspectable var shadowOffsetColor: UIColor? = UIColor.black
    @IBInspectable var shadowOpacity1: Float = 0.5

    override func layoutSubviews() {

        layer.cornerRadius = layer.frame.size.width / 2

        let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: layer.frame.size.width / 2)

        layer.masksToBounds = false
        layer.shadowColor = shadowOffsetColor?.cgColor
        layer.shadowOffset = CGSize(width: shadowOffsetWidth, height: shadowOffsetHeight);
        layer.shadowOpacity = shadowOpacity1
        layer.shadowPath = shadowPath.cgPath
        self.clipsToBounds = true
    }
}


@IBDesignable
class LocalizedButton: UIButton {

    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    @IBInspectable
    public var localizedKey: String = "" {
        willSet {
            self.setTitle(newValue.localized(), for: .normal)
        }
    }

    @IBInspectable
    public var localizeFontSize: CGFloat = 0.0 {
        willSet {
            if Localize.currentLanguage() == "en" {
                self.titleLabel?.font = UIFont(name: "Cairo-Regular", size: newValue)
            } else {
                self.titleLabel?.font = UIFont(name: "Cairo-Regular", size: newValue)
            }
        }
    }

}


@IBDesignable extension UIView {

    func embed(_ viewController:UIViewController, inParent controller:UIViewController, inView view:UIView){
           viewController.willMove(toParent: controller)
           viewController.view.frame = view.bounds
           view.addSubview(viewController.view)
           controller.addChild(viewController)
           viewController.didMove(toParent: controller)
       }

    @IBInspectable var borderColor: UIColor? {
        set {
            layer.borderColor = newValue?.cgColor
        }
        get {
            if let color = layer.borderColor {
                return UIColor(cgColor:color)
            } else {
                return nil
            }
        }
    }

    @IBInspectable var borderWidth: CGFloat {
        set {
            layer.borderWidth = newValue
        }
        get {
            return layer.borderWidth
        }
    }

    @IBInspectable var cornerRadius: CGFloat {
        set {
            layer.cornerRadius = newValue

        }
        get {
            return layer.cornerRadius
        }
    }

    @IBInspectable var surroundWithShadow: Bool {
        get {
            return self.surroundWithShadow
        }
        set {
            if newValue {
                self.layer.shadowColor = UIColor.black.cgColor
                self.layer.shadowOpacity = 0.11
                self.layer.shadowOffset = CGSize(width: 0, height: 1.0)
                self.layer.shadowRadius = 5  // shadow blur
                self.layer.masksToBounds = false
            }
        }
    }

    @IBInspectable var underlineColor: UIColor? {
        get {
            return nil
        }
        set (value) {
            self.setBottomBorder(value)
        }
    }

    @IBInspectable var isCircular: Bool {
        get {
            return self.isCircular
        }
        set (value) {
            if (value) {
                self.layer.cornerRadius = self.bounds.size.width/2
                self.clipsToBounds = true
            }
        }
    }

    func setBottomBorder(_ color: UIColor?) {
        guard let color = color else { return }
        self.layer.masksToBounds = false
        self.borders(for: [.bottom], color: color)
    }

    func borders(for edges:[UIRectEdge], width:CGFloat = 1, color: UIColor = .black) {

        if edges.contains(.all) {
            layer.borderWidth = width
            layer.borderColor = color.cgColor
        } else {
            let allSpecificBorders:[UIRectEdge] = [.top, .bottom, .left, .right]

            for edge in allSpecificBorders {
                if let v = viewWithTag(Int(edge.rawValue)) {
                    v.removeFromSuperview()
                }

                if edges.contains(edge) {
                    let v = UIView()
                    v.tag = Int(edge.rawValue)
                    v.backgroundColor = color
                    v.translatesAutoresizingMaskIntoConstraints = false
                    addSubview(v)

                    var horizontalVisualFormat = "H:"
                    var verticalVisualFormat = "V:"

                    switch edge {
                    case UIRectEdge.bottom:
                        horizontalVisualFormat += "|-(0)-[v]-(0)-|"
                        verticalVisualFormat += "[v(\(width))]-(0)-|"
                    case UIRectEdge.top:
                        horizontalVisualFormat += "|-(0)-[v]-(0)-|"
                        verticalVisualFormat += "|-(0)-[v(\(width))]"
                    case UIRectEdge.left:
                        horizontalVisualFormat += "|-(0)-[v(\(width))]"
                        verticalVisualFormat += "|-(0)-[v]-(0)-|"
                    case UIRectEdge.right:
                        horizontalVisualFormat += "[v(\(width))]-(0)-|"
                        verticalVisualFormat += "|-(0)-[v]-(0)-|"
                    default:
                        break
                    }

                    self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: horizontalVisualFormat, options: .directionLeadingToTrailing, metrics: nil, views: ["v": v]))
                    self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: verticalVisualFormat, options: .directionLeadingToTrailing, metrics: nil, views: ["v": v]))
                }
            }
        }
    }



}

extension UIImageView {

    func downloaded(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFill, completion: @escaping (UIImage) -> ()) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() {
                completion(image)
            }
        }.resume()
    }
}

extension UITextField{
    @IBInspectable var placeHolderColor: UIColor? {
        get {
            return self.placeHolderColor
        }
        set {
            self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "", attributes:[NSAttributedString.Key.foregroundColor: newValue!])
        }
    }
}
@IBDesignable extension UIView {
     @IBInspectable var shadowColor: UIColor? {
        set {
            layer.shadowColor = newValue!.cgColor
        }
        get {
            if let color = layer.shadowColor {
                return UIColor(cgColor: color)
            }
            else {
                return nil
            }
        }
    }

    /* The opacity of the shadow. Defaults to 0. Specifying a value outside the
     * [0,1] range will give undefined results. Animatable. */
    @IBInspectable var shadowOpacity: Float {
        set {
            layer.shadowOpacity = newValue
        }
        get {
            return layer.shadowOpacity
        }
    }

    /* The shadow offset. Defaults to (0, -3). Animatable. */
    @IBInspectable var shadowOffset: CGPoint {
        set {
            layer.shadowOffset = CGSize(width: newValue.x, height: newValue.y)
        }
        get {
            return CGPoint(x: layer.shadowOffset.width, y:layer.shadowOffset.height)
        }
    }

    /* The blur radius used to create the shadow. Defaults to 3. Animatable. */
    @IBInspectable var shadowRadius: CGFloat {
        set {
            layer.shadowRadius = newValue
        }
        get {
            return layer.shadowRadius
        }
    }
}
@IBDesignable extension UIView {

    /* The corner radius of the view. */
    @IBInspectable var cornerRadiusMe: CGFloat {
        set {
            layer.cornerRadius = newValue
        }
        get {
            return layer.cornerRadius
        }
    }
}
//extension UIView {
//
//    /**
//     Rotate a view by specified degrees
//
//     - parameter angle: angle in degrees
//     */
//     func rotate(angle: CGFloat) {
//        let radians = angle / 180.0 * CGFloat.pi
//        let rotation = self.transform.rotated(by: radians);
//        self.transform = rotation
//    }
//
//}
@IBDesignable
class CustomView: UIView {

    @IBInspectable var rotation: Double = 0 {
        didSet {
            rotateButton(rotation: rotation)
        }
    }

    func rotateButton(rotation: Double)  {
        self.transform = CGAffineTransform(rotationAngle: CGFloat(.pi/2 + rotation))
    }
}

// MARK: - Rounded Corners
extension UIView {

    func withRoundedCorner(_ radius: CGFloat = UIScreen.main.bounds.height*0.05, topEdgesOnly:Bool = false,bottomEdgesOnly:Bool = false){
        if topEdgesOnly{
            self.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner]
        }
        if bottomEdgesOnly{
            self.layer.maskedCorners = [.layerMinXMaxYCorner,.layerMaxXMaxYCorner]
        }
        self.layer.cornerRadius = radius
        self.clipsToBounds = true
    }
}

// MARK: - Apply Gradient Style To All Buttons
extension UIButton {
    func withGradientStyle() {
        self.gradient(startColor: UIColor(hexString: "#749BC4"), endColor: UIColor(hexString: "#87D4C2"))
        self.clipsToBounds = true
        self.cornerRadius = 20
    }
}

