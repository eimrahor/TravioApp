//
//  ChangePasswordSettingsCell.swift
//  TravioApp
//
//  Created by Elif Poyraz on 3.09.2023.
//

import UIKit
import TinyConstraints

struct PasswordSettingsData{
    var titleText:String
    var placeHolderText:String
}

class ChangePasswordSettingsCell: UICollectionViewCell {
    
    private lazy var view: CustomComponentTextField = {
        let view = CustomComponentTextField()
        view.backgroundColor = CustomColor.White.color
        return view
    }()
    
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
