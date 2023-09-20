//
//  UICustomTextField.swift
//  ContactsApp
//
//  Created by Elif Poyraz on 13.08.2023.
//

import UIKit

class UICustomTextField: UITextField {

    var insets:UIEdgeInsets
    
    var LeftViewImageSystemName:String = "person.fill"{
        didSet{
            SetLeftView(SystemIconName: LeftViewImageSystemName,LeftView:true)
        }
    }
    var LeftViewImageName:String = "person.fill"{
        didSet{
            SetLeftView(IconName: LeftViewImageName, LeftView: true)
        }
    }
    var RightViewImageSystemName:String = "person.fill"{
        didSet{
            SetLeftView(SystemIconName: LeftViewImageSystemName,LeftView:false)
        }
    }
    var RightViewImageName:String = "person.fill"{
        didSet{
            SetLeftView(IconName: LeftViewImageName, LeftView: false)
        }
    }
    
    init(insets:UIEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 30))
    {
        self.insets = insets
        super.init(frame: .zero)
        self.textColor = CustomColor.Black.color
        self.font = CustomFont.Avenirmedium(14).font
    
        self.backgroundColor = CustomColor.White.color
        self.layer.borderWidth = 0.7
        self.layer.borderColor = #colorLiteral(red: 0.9999999404, green: 0.9999999404, blue: 1, alpha: 0.6464891245)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func SetLeftView(IconName:String,LeftView:Bool)
    {
        let imageView = UIImageView(frame: CGRect(x: 11, y: 11, width: 22, height: 22))
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: IconName)
        imageView.tintColor = CustomColor.Blue.color
        
        let View = UIView(frame: CGRect(x: 0, y: 2, width: 44, height: 44))
        View.addSubview(imageView)
        
        if LeftView == true {self.leftView = View}
        else {self.rightView = View}
    }
    
    func SetLeftView(SystemIconName:String,LeftView:Bool)
    {
        let imageView = UIImageView(frame: CGRect(x: 11, y: 11, width: 22, height: 22))
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(systemName: SystemIconName)
        imageView.tintColor = CustomColor.Blue.color
        
        let View = UIView(frame: CGRect(x: 0, y: 2, width: 44, height: 44))
        View.addSubview(imageView)
        
        if LeftView == true {self.leftView = View}
        else {self.rightView = View}
    }

}
