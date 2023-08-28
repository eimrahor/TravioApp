//
//  UIView.swift
//  ContinueAPI
//
//  Created by Kurumsal on 18.08.2023.
//

import UIKit

extension UIView {

    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
         let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
         let mask = CAShapeLayer()
         mask.path = path.cgPath
         self.layer.mask = mask
    }
    
    func shadowAndRoundCorners(width: CGFloat) {
        let demoPath = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: width, height: 74), byRoundingCorners:[.topLeft, .topRight, .bottomLeft], cornerRadii: CGSize(width: 16.0, height: 16.0)).cgPath
        
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
