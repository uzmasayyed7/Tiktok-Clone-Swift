//
//  Utils.swift
//  Short Videos
//
//  Created by Uzma  on 08/07/24.
//  Copyright © 2024 Kaishan. All rights reserved.
//

import Foundation

public let baseWhiteColor = UIColor.rgb(red: 234, green: 236, blue: 238)
public let lineSeperatorColor = UIColor.rgb(red: 227, green: 227, blue: 227)

extension UIColor {
    
    @objc static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
    
    static let tealColor = UIColor(red: 48/255, green: 164/255, blue: 182/255, alpha: 1)
    static let lightRed = UIColor.init(red: 247/255, green: 66/255, blue: 82/255, alpha: 1)
    static let darkBlue = UIColor(red: 9/255, green: 45/255, blue: 64/255, alpha: 1)
    static let lightBlue = UIColor(red: 218/255, green: 235/255, blue: 243/255, alpha: 1)

}

struct AnchoredConstraints {
    var top, leading, bottom, trailing, width, height: NSLayoutConstraint?
}

extension UIView {
    
    @discardableResult
    func anchor(top: NSLayoutYAxisAnchor?, leading: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, trailing: NSLayoutXAxisAnchor?, padding: UIEdgeInsets = .zero, size: CGSize = .zero) -> AnchoredConstraints {
        
        translatesAutoresizingMaskIntoConstraints = false
        var anchoredConstraints = AnchoredConstraints()
        
        if let top = top {
            anchoredConstraints.top = topAnchor.constraint(equalTo: top, constant: padding.top)
        }
        
        if let leading = leading {
            anchoredConstraints.leading = leadingAnchor.constraint(equalTo: leading, constant: padding.left)
        }
        
        if let bottom = bottom {
            anchoredConstraints.bottom = bottomAnchor.constraint(equalTo: bottom, constant: -padding.bottom)
        }
        
        if let trailing = trailing {
            anchoredConstraints.trailing = trailingAnchor.constraint(equalTo: trailing, constant: -padding.right)
        }
        
        if size.width != 0 {
            anchoredConstraints.width = widthAnchor.constraint(equalToConstant: size.width)
        }
        
        if size.height != 0 {
            anchoredConstraints.height = heightAnchor.constraint(equalToConstant: size.height)
        }
        
        [anchoredConstraints.top, anchoredConstraints.leading, anchoredConstraints.bottom, anchoredConstraints.trailing, anchoredConstraints.width, anchoredConstraints.height].forEach{ $0?.isActive = true }
        
        return anchoredConstraints
    }
    
    @objc func fillSuperview(padding: UIEdgeInsets = .zero) {
        translatesAutoresizingMaskIntoConstraints = false
        if let superviewTopAnchor = superview?.topAnchor {
            topAnchor.constraint(equalTo: superviewTopAnchor, constant: padding.top).isActive = true
        }
        
        if let superviewBottomAnchor = superview?.bottomAnchor {
            bottomAnchor.constraint(equalTo: superviewBottomAnchor, constant: -padding.bottom).isActive = true
        }
        
        if let superviewLeadingAnchor = superview?.leadingAnchor {
            leadingAnchor.constraint(equalTo: superviewLeadingAnchor, constant: padding.left).isActive = true
        }
        
        if let superviewTrailingAnchor = superview?.trailingAnchor {
            trailingAnchor.constraint(equalTo: superviewTrailingAnchor, constant: -padding.right).isActive = true
        }
    }
    
    @objc func centerInSuperview(size: CGSize = .zero) {
        translatesAutoresizingMaskIntoConstraints = false
        if let superviewCenterXAnchor = superview?.centerXAnchor {
            centerXAnchor.constraint(equalTo: superviewCenterXAnchor).isActive = true
        }
        
        if let superviewCenterYAnchor = superview?.centerYAnchor {
            centerYAnchor.constraint(equalTo: superviewCenterYAnchor).isActive = true
        }
        
        if size.width != 0 {
            widthAnchor.constraint(equalToConstant: size.width).isActive = true
        }
        
        if size.height != 0 {
            heightAnchor.constraint(equalToConstant: size.height).isActive = true
        }
    }
    
    
    
    
    func centerXInSuperview() {
        translatesAutoresizingMaskIntoConstraints = false
        if let superViewCenterXAnchor = superview?.centerXAnchor {
            centerXAnchor.constraint(equalTo: superViewCenterXAnchor).isActive = true
        }
    }
    
    
    func constrainToTop(paddingTop: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        if let top = superview?.topAnchor {
            self.topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
        }
        
    }
    
    
    func constrainToBottom(paddingBottom: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        if let bottom = superview?.bottomAnchor {
            self.bottomAnchor.constraint(equalTo: bottom, constant: paddingBottom).isActive = true
        }
        
    }
    
    func constrainToLeft(paddingLeft: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        if let left = superview?.leftAnchor {
            self.leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
        }
    }
    
    
    func constrainToRight(paddingRight: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        if let right = superview?.rightAnchor {
            self.rightAnchor.constraint(equalTo: right, constant: paddingRight).isActive = true
        }
    }
    
    func constrainToRight(paddingRight: CGFloat, superView: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        let right = superView.rightAnchor
        self.rightAnchor.constraint(equalTo: right, constant: paddingRight).isActive = true
        
    }
    
    
    func constrainToTop(paddingTop: CGFloat, superView: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
         let top = superView.topAnchor
        self.topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
    }
    
    
    func constrainToBottom(paddingBottom: CGFloat, superView: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        let bottom = superView.bottomAnchor
        self.bottomAnchor.constraint(equalTo: bottom, constant: paddingBottom).isActive = true
        
    }
    
    
    
    
    func constrainToLeft(paddingLeft: CGFloat, superView: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        let left = superView.rightAnchor
        self.leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
        
    }
    
    
    func centerYInSuperview() {
        translatesAutoresizingMaskIntoConstraints = false
        if let centerY = superview?.centerYAnchor {
            centerYAnchor.constraint(equalTo: centerY).isActive = true
        }
    }
    
    func constrainWidth(constant: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalToConstant: constant).isActive = true
    }
    
    func constrainHeight(constant: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: constant).isActive = true
    }
    
    
}


extension UIView {
    
    /// Flip view horizontally.
    func flipX() {
        transform = CGAffineTransform(scaleX: -transform.a, y: transform.d)
    }
    
    /// Flip view vertically.
    func flipY() {
        transform = CGAffineTransform(scaleX: transform.a, y: -transform.d)
    }
    
    
    /// Flip view 180, slight delay then 360.
    func handleRotate360() {
        UIView.animate(withDuration: 0.5) { () -> Void in
            self.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        }
        
        UIView.animate(withDuration: 0.5, delay: 0.45, options: .curveEaseIn, animations: { () -> Void in
            self.transform = CGAffineTransform(rotationAngle: CGFloat.pi * 2.0)
        }, completion: nil)
    }
    
    
    
    /// Flip view 180, true to rotate 180, false to return to identity
    func handleRotate180(rotate: Bool) {
        UIView.animate(withDuration: 0.5) { () -> Void in
            self.transform = rotate == true ? CGAffineTransform(rotationAngle: CGFloat.pi) : .identity
        }
        
    }
    
    
    
}


public func handleAnimateHighLighted(view: UIView, highlighted: Bool) {
    //usingSpringWithDamping: 1, initialSpringVelocity: 1
    UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: .curveEaseOut, animations: { [weak view] in
        
        if highlighted == true {
            view?.transform = .init(scaleX: 0.9, y: 0.9) //0.9
            
            
        } else {
            
            view?.transform = .identity
        }
        
    }) { (completed) in
        //
    }
}


///removes all chars from textview
public func removeSpecialCharsFromString(_ str: String) -> String {
    struct Constants {
        static let validChars = Set("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLKMNOPQRSTUVWXYZ0123456789_")
    }
    return String(str.filter { Constants.validChars.contains($0)})
}


//public func removeSpecialCharsFromStringButLeaveWhiteSpaces(_ str: String) -> String {
//    struct Constants {
//        static let validChars = Set("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLKMNOPQRSTUVWXYZ0123456789_ ")
//    }
//    return String(str.filter { Constants.validChars.contains($0)})
//}


extension UILabel {
    func UILableTextShadow(color: UIColor){
        self.textColor = color
        self.layer.masksToBounds = false
        self.layer.shadowOffset = .zero//CGSize(width: 1, height: 1)
        self.layer.rasterizationScale = UIScreen.main.scale
        self.layer.shadowRadius = 6.0
        self.layer.shadowOpacity = 1.0
    }
}


extension String {
    var withoutSpecialCharacters: String {
        return self.components(separatedBy: CharacterSet.symbols).joined(separator: "")
    }
}

func defaultFont(size: CGFloat)-> UIFont {
    let defaultFont = UIFont(name: "AppleSDGothicNeo-Bold", size: size)!
    return defaultFont

}


func navBarFont(size: CGFloat)-> UIFont {
//    let defaultFont = UIFont(name: Fonts.soundsGood, size: size)!
    let defaultFont = UIFont.systemFont(ofSize: size, weight: .heavy)

    return defaultFont

}

func appleSDGothicNeoMedium(size: CGFloat)-> UIFont {
    let defaultFont = UIFont(name: "AppleSDGothicNeo-Medium", size: size)!
    return defaultFont

}

func appleNeoBold(size: CGFloat)-> UIFont {
    let defaultFont = UIFont(name: "AppleSDGothicNeo-Bold", size: size)!
    return defaultFont

    
}
func avenirBoldFont(size: CGFloat)-> UIFont {
    let defaultFont = UIFont(name: "AvenirNext-Bold", size: size)!
    return defaultFont
}

func avenirRomanFont(size: CGFloat)-> UIFont {
    let defaultFont = UIFont(name: "Avenir-Roman", size: size)!
    return defaultFont
    
}



public func setupAttributedTextWithFonts(titleString: String, subTitleString: String, attributedTextColor: UIColor, mainColor: UIColor, mainfont: UIFont, subFont: UIFont) -> NSMutableAttributedString{
    let attributedText = NSMutableAttributedString(string: "\(titleString)", attributes: [NSAttributedString.Key.foregroundColor : mainColor, NSAttributedString.Key.font : mainfont])
    
    attributedText.append(NSMutableAttributedString(string: "\(subTitleString)", attributes: [NSAttributedString.Key.foregroundColor : attributedTextColor, NSAttributedString.Key.font: subFont]))
    return attributedText
}




public func handleHide_ShowNavLine(navController: UINavigationController?, showLine: Bool) {
    if showLine == true {
        navController?.navigationBar.setBackgroundImage(UIImage(named: ""), for: UIBarMetrics.default)
        navController?.navigationBar.shadowImage = UIImage(named: "")
    } else {
        navController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navController?.navigationBar.shadowImage = UIImage()

    }
   
}



extension UICollectionView {
    
    func setupEmptyState(with message: String, animateIndicatorView: Bool) {
        
        let loadingLabel: UILabel = {
            let label = UILabel()
            label.text = message
            label.font = UIFont.boldSystemFont(ofSize: 10)
            label.textAlignment = .center
            label.textColor = .darkGray
            return label
        }()
        
        
        let indicatorView: UIActivityIndicatorView = {
            let iv = UIActivityIndicatorView(style: .white)
            iv.color = .darkGray
            iv.translatesAutoresizingMaskIntoConstraints = false
            return iv
        }()
        
        let collectionViewBackgroundView = UIView()
        collectionViewBackgroundView.addSubview(indicatorView)
        collectionViewBackgroundView.addSubview(loadingLabel)
        indicatorView.centerInSuperview()
        loadingLabel.topAnchor.constraint(equalTo: indicatorView.bottomAnchor, constant: 6).isActive = true
        loadingLabel.centerXInSuperview()
        animateIndicatorView == true ? indicatorView.startAnimating() : indicatorView.stopAnimating()
        self.backgroundView = collectionViewBackgroundView
    }
    
    
    func removeloadingView(afterDelay: TimeInterval) {
        //removes loading indicator and label with nice animation
        UIView.animate(withDuration: 0.5, delay: afterDelay, options: .curveEaseIn, animations: { [weak self] in
            self?.backgroundView = nil
        })
    }
}



class UILabelWithInsets : UILabel {
    var textInsets = UIEdgeInsets.zero {
        didSet { invalidateIntrinsicContentSize() }
    }
    
    override func textRect(forBounds bounds: CGRect, limitedToNumberOfLines numberOfLines: Int) -> CGRect {
        let insetRect = bounds.inset(by: textInsets)
        let textRect = super.textRect(forBounds: insetRect, limitedToNumberOfLines: numberOfLines)
        let invertedInsets = UIEdgeInsets(top: -textInsets.top,
                                          left: -textInsets.left,
                                          bottom: -textInsets.bottom,
                                          right: -textInsets.right)
        return textRect.inset(by: invertedInsets)
    }
    
    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: textInsets))
        //canceld it out because im already doing it
        //        self.numberOfLines = 0
        //        self.adjustsFontSizeToFitWidth = true
        //        self.minimumScaleFactor = 0.1
        //        self.baselineAdjustment = .alignCenters
        
        
    }
}




public func handleSetUpAttributedText(titleString: String, secondString: String, mainColor: UIColor, mainfont: UIFont, secondColor: UIColor, subFont: UIFont, lastString: String, usernameMentionColor: UIColor, usernameString: String) -> NSMutableAttributedString {
       
       let mainAttributes = [NSAttributedString.Key.foregroundColor : mainColor, NSAttributedString.Key.font : mainfont]
       let mainAttributedText = NSMutableAttributedString(string: titleString, attributes: mainAttributes)
       
       
       let usernameAttributes = [NSAttributedString.Key.foregroundColor : usernameMentionColor, NSAttributedString.Key.font : subFont]

       let usernameTextAttribute = NSMutableAttributedString(string: usernameString, attributes: usernameAttributes)
       
       let subAttributes = [NSAttributedString.Key.foregroundColor : secondColor, NSAttributedString.Key.font : subFont]
       
       let subAttributedText = NSMutableAttributedString(string: secondString, attributes: subAttributes)
       
       let lastAttributes = [NSAttributedString.Key.foregroundColor : secondColor, NSAttributedString.Key.font : subFont]

       let lastAttributedText = NSMutableAttributedString(string: lastString, attributes: lastAttributes)
       
       
       mainAttributedText.append(subAttributedText)
       mainAttributedText.append(usernameTextAttribute)
       mainAttributedText.append(lastAttributedText)

       
       return mainAttributedText
   }





  
//MARK: - Network Utils
//
//  Reachability.swift
//  DigAdmin
//
//  Created by Osaretin Uyigue on 5/17/18.
//  Copyright © 2018 Osaretin Uyigue. All rights reserved.
//
import UIKit
import SystemConfiguration
class Reachability {
    class func isConnectedToNetwork() -> Bool {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {$0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            
            }
            
        }
        
        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
            return false
        }
        
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        return (isReachable && !needConnection)
        
    }
    
}

// func checkForConnection() -> Bool {
//    var connectivityIsAvailable: Bool = false
//    //first check if there is network before proceeding with upload to storage
//    if Reachability.isConnectedToNetwork() {
//        print("Yes there is network")
//        connectivityIsAvailable = true
//    } else {
//        print("No network!!")
//        presentNetworkErrorMessage()
//        connectivityIsAvailable = false
//    }
//    
//    return connectivityIsAvailable
//}



 func checkForConnectionWithOutSVProgressHud() -> Bool {
    var connectivityIsAvailable: Bool = false
    //first check if there is network before proceeding with upload to storage
    if Reachability.isConnectedToNetwork() {
        connectivityIsAvailable = true
    } else {
        connectivityIsAvailable = false
    }
    
    return connectivityIsAvailable
}

 
 func handleNetworkCheck() {
       //first check if there is network before proceeding with upload to storage
       if Reachability.isConnectedToNetwork() {
           print("Yes there is network")
       } else {
           print("No network!!")
//           presentNetworkErrorMessage()
       }
   }
   


