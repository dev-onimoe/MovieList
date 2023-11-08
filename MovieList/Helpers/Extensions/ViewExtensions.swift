//
//  ViewExtensions.swift
//  MovieList
//
//  Created by Masud Onikeku on 07/11/2023.
//

import Foundation
import UIKit
import SDWebImage

extension UIImageView {
    func setImageTintColor(color: UIColor) {
        let templateImage = self.image?.withRenderingMode(.alwaysTemplate)
        self.image = templateImage
        self.tintColor = color
    }
    
    func setImageSd(url: String, placeHolder: String? = nil, isIndicatorShow: Bool = true){
        
        if let loadUrl = URL.init(string: url){
            if UIApplication.shared.canOpenURL(loadUrl){
                self.sd_imageIndicator = SDWebImageActivityIndicator.gray
                sd_setImage(with: loadUrl, placeholderImage: placeHolder != nil ? UIImage.init(named: placeHolder!) : nil, completed: nil)
            }else{
                self.image = placeHolder != nil ? UIImage.init(named: placeHolder!) : nil
            }
            
        }else{
            self.image = placeHolder != nil ? UIImage.init(named: placeHolder!) : nil
        }
    }
    
}

extension UIView {
    
    func constraint (equalToTop: NSLayoutYAxisAnchor? = nil,
                     equalToBottom: NSLayoutYAxisAnchor? = nil,
                     equalToLeft: NSLayoutXAxisAnchor? = nil,
                     equalToRight: NSLayoutXAxisAnchor? = nil,
                     paddingTop: CGFloat = 0,
                     paddingBottom: CGFloat = 0,
                     paddingLeft: CGFloat = 0,
                     paddingRight: CGFloat = 0,
                     width: CGFloat? = nil,
                     height: CGFloat? = nil
    ) {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let equalToTop = equalToTop {
            
            topAnchor.constraint(equalTo: equalToTop, constant: paddingTop).isActive = true
        }
        
        if let equalTobottom = equalToBottom {
            
            bottomAnchor.constraint(equalTo: equalTobottom, constant: -paddingBottom).isActive = true
        }
        
        if let equalToLeft = equalToLeft {
            
            leadingAnchor.constraint(equalTo: equalToLeft, constant: paddingLeft).isActive = true
        }
        
        if let equalToRight = equalToRight {
            
            trailingAnchor.constraint(equalTo: equalToRight, constant: -paddingRight).isActive = true
        }
        
        if let width = width {
            
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        
        if let height = height {
            
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
    
    
    func centre (centerX: NSLayoutXAxisAnchor? = nil, centreY: NSLayoutYAxisAnchor? = nil) {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let centerx = centerX {
            
            centerXAnchor.constraint(equalTo: centerx).isActive = true
        }
        
        if let centery = centreY {
            
            centerYAnchor.constraint(equalTo: centery).isActive = true
        }
    }
    
    
    func removeProperly() {
        
        for view in self.subviews {
            
            view.removeFromSuperview()
        }
        self.removeFromSuperview()
    }
    
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
    
    func makeRounded() {
        self.layer.masksToBounds = false
        self.layer.cornerRadius = self.frame.height / 2
        self.clipsToBounds = true
    }
    
    func shadowBorder (){
        
        //self.layer.cornerRadius = 10
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 1.75)
        self.layer.shadowRadius = 10
        self.layer.shadowOpacity = 0.2
        self.layer.masksToBounds = false
        
    }
    
    func centreHorizontally(view : UIView, y : Double, height : Double, width: Double) {
        
        view.frame = CGRect(x: (frame.width/2.0) - (width/2.0), y: y, width: width, height: height)
        
        addSubview(view)
        
    }
    
    func centreVertically(view : UIView, x : Double, height : Double, width: Double) {
        
        view.frame = CGRect(x: x, y: (frame.height/2.0) - (height/2.0), width: width, height: height)
        
        addSubview(view)
        
    }
    
    func animateInOut() {
        
        let y = self.frame.origin.y
        
        UIView.animate(withDuration: 1, animations: {self.frame.origin.y = y - 75}, completion: {bool in
            
            UIView.animate(withDuration: 1, animations: {self.frame.origin.y = y}, completion: {bool in
                
                self.removeProperly()
            })
            
            
        })
    }
    
    /// Corner radius of view; also inspectable from Storyboard.
    @IBInspectable public var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = abs(CGFloat(Int(newValue * 100)) / 100)
        }
    }
    /// : Shadow color of view; also inspectable from Storyboard.
    
    
    @IBInspectable public var borderColor: UIColor? {
        get {
            guard let color = layer.borderColor else { return nil }
            return UIColor(cgColor: color)
        }
        set {
            guard let color = newValue else {
                layer.borderColor = nil
                return
            }
            layer.borderColor = color.cgColor
        }
    }
    
    /// : Border width of view; also inspectable from Storyboard.
    @IBInspectable public var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }

}
