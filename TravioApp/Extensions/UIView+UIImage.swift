//
//  UIView.swift
//  ContinueAPI
//
//  Created by Kurumsal on 18.08.2023.
//

import UIKit


extension UICollectionViewCell {
    
    func radiusWithShadow(corners:UIRectCorner){
        
        let rectanglePath = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height), byRoundingCorners: corners, cornerRadii: CGSize(width: 16, height: 16))
        rectanglePath.close()
        
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.2
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowRadius = 4
        layer.shadowPath = rectanglePath.cgPath
        contentView.roundCorners(corners, radius: 16)
        contentView.layer.masksToBounds = true
    }
}


extension UIView {
    
    func roundCorners(_ corners:UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }

    func roundCornersWithShadow(_ corners: UIRectCorner, radius: CGFloat) {
                if #available(iOS 11.0, *) {
                    clipsToBounds = true
                    layer.cornerRadius = radius
                    layer.maskedCorners = CACornerMask(rawValue: corners.rawValue)
                } else {
                    let path = UIBezierPath(
                        roundedRect: bounds,
                        byRoundingCorners: corners,
                        cornerRadii: CGSize(width: radius, height: radius)
                    )
                    let mask = CAShapeLayer()
                    mask.path = path.cgPath
                    layer.mask = mask
                }
            
            self.layer.shadowColor = UIColor.black.cgColor
            self.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
            self.layer.shadowOpacity = 0.5
            self.layer.shadowRadius = 2
            self.layer.masksToBounds = false
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
        shadowLayer.shadowRadius = 5

        self.layer.insertSublayer(shadowLayer, at: 0)
    }
    
    func addSubviews(_ view: UIView...) {
        view.forEach({ v in
            self.addSubview(v)
        })
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
    
    func resizedImage(to size: CGSize) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        defer { UIGraphicsEndImageContext() }
        self.draw(in: CGRect(origin: .zero, size: size))
        return UIGraphicsGetImageFromCurrentImageContext()
    }
    

}

extension UITextView {
    func changeColor() {
    }
}
