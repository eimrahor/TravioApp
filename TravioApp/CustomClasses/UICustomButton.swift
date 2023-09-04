//
//  UICustomButton.swift
//  ContactsApp
//
//  Created by Elif Poyraz on 13.08.2023.
//

import UIKit
import SwiftUI

class UICustomButton: UIButton {

    override var isEnabled: Bool {
        didSet{
            if isEnabled
            { self.backgroundColor = CustomColor.TravioGreen.color}
            else {self.backgroundColor = CustomColor.TravioLightGray.color}
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.setTitleColor(CustomColor.White.color, for: .normal)
        self.roundCorners( [.bottomLeft,.topRight,.topLeft], radius: 16)
    }
    init(title: String = "Button")
    {
        super.init(frame: .zero)
        self.backgroundColor = CustomColor.TravioGreen.color
        self.titleLabel?.font = CustomFont.PoppinsSemiBold(16).font
        self.height(54)
        self.width(342)
        self.setTitle(title, for: .normal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func buttonSetAttributedTitle(Title:String = "Empty" , Color: CustomColor = CustomColor.TravioBlack, Font: CustomFont = CustomFont.PoppinsSemiBold(14))
    {
        self.height(21)
        self.backgroundColor = .clear
        let attrString = NSAttributedString(string: Title , attributes: [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue, NSAttributedString.Key.foregroundColor : Color.color,NSAttributedString.Key.font : Font.font])
   
        self.setAttributedTitle(attrString, for: .normal)
    }

}
