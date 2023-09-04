////
////  SecuritySettingsCell.swift
////  TravioApp
////
////  Created by Elif Poyraz on 4.09.2023.
////
//
import UIKit
import TinyConstraints

struct PasswordSettingsData{
    var titleText:String
    var placeHolderText:String
}

struct PrivacySettingsData{
    var titleText:String
    var switchState:Bool
}

class SecuritySettingsCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupLayout()
    {
        self.contentView.backgroundColor = CustomColor.TravioWhite.color
        addSubview()
        view.edgesToSuperview()
    }

    func addSubview(){
        self.contentView.addSubview(view)
    }

    func configureCell(cellData:PasswordSettingsData){
        view.lbl.text = cellData.titleText
        view.placeHolderConfig(placeHolderText: cellData.placeHolderText)
    }

}
