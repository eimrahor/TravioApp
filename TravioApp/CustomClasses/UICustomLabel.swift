//
//  UICustomLabel.swift
//  ContactsApp
//
//  Created by Elif Poyraz on 13.08.2023.
//

import UIKit
enum CustomLabelTypes{
    case pageNameHeader(text:String = "")
    case customTextViewHeader(text:String = "")
    case customTextFieldHeader(text:String = "")
    case standardBlackHeader(text:String = "")
    case standardBlackSubtitle(text:String = "")
    case standardGreenHeader(text:String = "")
    case standardBlackLabel(text:String = "")
    case customTextViewDescription(text: String = "")
    case customGreenHeaderOfCollectionView(text: String = "")
}

class UICustomLabel: UILabel {

    init(labelType:CustomLabelTypes)
    {
        super.init(frame: .zero)
        
        switch labelType {
            
        case .pageNameHeader(let text):
            self.textColor = CustomColor.White.color
            self.text = text
            self.textAlignment = .center
            self.font = CustomFont.PoppinsSemiBold(32).font
            
        case .customTextViewHeader(let text):
            self.textColor = CustomColor.TravioBlack.color
            self.text = text
            self.textAlignment = .left
            self.font = CustomFont.PoppindMedium(14).font
            
        case .customTextFieldHeader(let text):
            self.textColor = CustomColor.TravioBlack.color
            self.text = text
            self.textAlignment = .left
            self.font = CustomFont.PoppindMedium(14).font
            
        case .standardBlackHeader(let text):
            self.textColor = CustomColor.TravioBlack.color
            self.text = text
            self.textAlignment = .center
            self.font = CustomFont.PoppinsSemiBold(24).font
        
        case .standardBlackSubtitle(let text):
            self.textColor = CustomColor.TravioBlack.color
            self.text = text
            self.textAlignment = .left
            self.font = CustomFont.PoppinsRegular(14).font
        
        case .standardGreenHeader(let text):
            self.textColor = CustomColor.TravioGreen.color
            self.text = text
            self.textAlignment = .left
            self.font = CustomFont.PoppinsSemiBold(16).font
            
        case .standardBlackLabel(let text):
            self.textColor = CustomColor.TravioBlack.color
            self.text = text
            self.textAlignment = .left
            self.font = CustomFont.PoppindMedium(12).font
            
        case .customTextViewDescription(let text):
            self.textColor = CustomColor.TravioBlack.color
            self.text = text
            self.textAlignment = .left
            self.font = CustomFont.PoppinsRegular(10).font
            
        case .customGreenHeaderOfCollectionView(let text):
            self.textColor = CustomColor.TravioGreen.color
            self.text = text
            self.textAlignment = .left
            self.font = CustomFont.PoppinsSemiBold(24).font
            
        default:
            self.textColor = CustomColor.Black.color
            self.text = text
            self.textAlignment = .center
            self.font = CustomFont.PoppinsRegular(24).font
        }
       
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
