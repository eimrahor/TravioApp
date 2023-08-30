//
//  UIView.swift
//  ContinueAPI
//
//  Created by Kurumsal on 18.08.2023.
//

import UIKit

extension UIView {

    func roundCorners(_ corners: UIRectCorner, radius: CGFloat, shadow: Bool? = false) {
         let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
         let mask = CAShapeLayer()
         mask.path = path.cgPath
         self.layer.mask = mask
        
        guard let shadow = shadow else { return }
        if shadow {
            self.layer.shadowPath = path.cgPath
            self.layer.shadowColor = UIColor.black.cgColor
            self.layer.shadowOpacity = 2
            self.layer.shadowOffset = CGSize(width: 0, height: 0)
            self.layer.shadowRadius = 20
        }
    }
    
    func shadowAndRoundCorners(width: CGFloat, height: CGFloat) {
        let demoPath = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: width, height: height), byRoundingCorners:[.topLeft, .topRight, .bottomLeft], cornerRadii: CGSize(width: 16.0, height: 16.0)).cgPath
        
        let shadowLayer = CAShapeLayer()
        shadowLayer.path = demoPath
        shadowLayer.fillColor = UIColor.white.cgColor

        shadowLayer.shadowColor = UIColor.black.cgColor
        shadowLayer.shadowPath = shadowLayer.path
        shadowLayer.shadowOffset = CGSize(width: 0, height: 0)
        shadowLayer.shadowOpacity = 0.16
        shadowLayer.shadowRadius = 12

        self.layer.insertSublayer(shadowLayer, at: 0)
    }
    
    
}

extension UIImage {
    func resized(to newSize: CGSize) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
        draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return resizedImage
    }
}

extension UITextView {
    func changeColor() {
        
    }
}
