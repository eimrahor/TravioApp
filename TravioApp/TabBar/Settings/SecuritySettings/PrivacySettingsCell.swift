//
//  PrivacySettingsCell.swift
//  TravioApp
//
//  Created by Elif Poyraz on 3.09.2023.
//

import UIKit



class PrivacySettingsCell: UICollectionViewCell {
    
    private lazy var switchComponent: CustomComponentSwitch = {
        let component = CustomComponentSwitch()
        component.backgroundColor = CustomColor.White.color
        return component
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
        switchComponent.edgesToSuperview()
    }
    
    func addSubview(){
        self.contentView.addSubview(switchComponent)
    }
    
    func configureCell(cellData:PrivacySettingsData){
        switchComponent.lbl.text = cellData.titleText
        switchComponent.switchControl.isOn = cellData.switchState
    }
}
