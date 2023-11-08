//
//  Utility.swift
//  TemyLine
//
//  Created by Masud Onikeku on 07/11/2023.
//

import Foundation
import SystemConfiguration
import UIKit
import CoreData
import CoreLocation
import SwiftyJSON
import SwiftMessages
import AVKit
import Photos

public var backView = UIView()

func rotateAnimation(imageView:UIImageView,duration: CFTimeInterval = 2.0) {
    let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation")
    rotateAnimation.fromValue = 0.0
    rotateAnimation.toValue = CGFloat(.pi * 2.0)
    rotateAnimation.duration = duration
    rotateAnimation.repeatCount = Float.greatestFiniteMagnitude;
    imageView.layer.add(rotateAnimation, forKey: nil)
}

class Utility: NSObject {
    /// Check newtork is available or not
    class func isConnectedToNetwork() -> Bool{
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout<sockaddr_in>.size)
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                SCNetworkReachabilityCreateWithAddress(nil, $0)
            }
        }) else{
            return false
        }
        
        var flags: SCNetworkReachabilityFlags = []
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) {
            return false
        }
        
        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        
        return (isReachable && !needsConnection)
    }
    
    class func showErrorMessage(msg: String) {
        let view = MessageView.viewFromNib(layout: .cardView)
        
        // Theme message elements with the warning style.
        view.configureTheme(.error)
        view.button?.isHidden = true
        view.iconImageView?.isHidden = true
        // Add a drop shadow.
        view.configureDropShadow()
        view.configureContent(title: "", body: msg)
        // Increase the external margin around the card. In general, the effect of this setting
        // depends on how the given layout is constrained to the layout margins.
        view.layoutMarginAdditions = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        
        // Reduce the corner radius (applicable to layouts featuring rounded corners).
        //(view.backgroundView as? CornerRoundingView)?.cornerRadius = 10
        
        // Show the message.
        var config = SwiftMessages.Config()
        config.interactiveHide = true
        config.duration = SwiftMessages.Duration.seconds(seconds: 3)
        SwiftMessages.show(config: config, view: view)
    }
    
    class func showSuccessMessage(msg: String){
        let view = MessageView.viewFromNib(layout: .cardView)
        
        // Theme message elements with the warning style.
        view.configureTheme(.success)
        view.button?.isHidden = true
        view.iconImageView?.isHidden = true
        // Add a drop shadow.
        view.configureDropShadow()
        view.backgroundColor = .white
        view.configureContent(title: "", body: msg)
        // Increase the external margin around the card. In general, the effect of this setting
        // depends on how the given layout is constrained to the layout margins.
        view.layoutMarginAdditions = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        
        // Reduce the corner radius (applicable to layouts featuring rounded corners).
        //(view.backgroundView as? CornerRoundingView)?.cornerRadius = 10
        
        // Show the message.
        var config = SwiftMessages.Config()
        config.interactiveHide = true
        config.duration = SwiftMessages.Duration.seconds(seconds: 3)
        SwiftMessages.show(config: config, view: view)
    }
    
    class func showProgressHUD(){
        for subUIView in backView.subviews as! [UIImageView] {
            subUIView.removeFromSuperview()
        }
        self.hideProgressHUD()
        //let window = appdelegate.window?.frame
        backView.frame =  CGRect(x: 0, y: 0, width:  appdelegate!.window!!.frame.size.width, height: appdelegate!.window!!.frame.size.height)
        backView.backgroundColor = UIColor.black.withAlphaComponent(0.30)
        let imgViewRing = UIImageView(image: UIImage(named: "Loading"))
        imgViewRing.setImageTintColor(color: Constants.tmBlue)
        imgViewRing.removeFromSuperview()
        imgViewRing.contentMode = .scaleAspectFit
        imgViewRing.frame = CGRect(x: 0, y: 0, width: 35, height: 35)
        //    imgViewRing.frame = CGRect(x: 0, y: 0, width: backView.frame.size.width/6.0, height: backView.frame.size.width/6.0)
        imgViewRing.center = CGPoint(x: backView.frame.size.width/2.0, y: backView.frame.size.height/2.0)
        rotateAnimation(imageView: imgViewRing)
        backView.addSubview(imgViewRing)
        appdelegate!.window!!.addSubview(backView)
        //    actualView.view.addSubview(backView)
    }
    
    class func hideProgressHUD(){
        backView.removeFromSuperview()
        appdelegate!.window!!.setNeedsLayout()
    }
    
    
    class func convertToJsonString(from object:Any) -> String? {
        guard let data = try? JSONSerialization.data(withJSONObject: object, options: []) else {
            return nil
        }
        return String(data: data, encoding: String.Encoding.utf8)
    }
    
}
