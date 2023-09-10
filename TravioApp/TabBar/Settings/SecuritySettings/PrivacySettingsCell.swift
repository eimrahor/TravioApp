//
//  PrivacySettingsCell.swift
//  TravioApp
//
//  Created by Elif Poyraz on 3.09.2023.
//

import UIKit
import TinyConstraints

class PrivacySettingsCell: UITableViewCell {
    
    var permissionType:PermissionType?
    
    private lazy var switchComponent: CustomComponentSwitch = {
        let component = CustomComponentSwitch()
        component.backgroundColor = CustomColor.White.color
        return component
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
       
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLayout()
    {
        self.contentView.backgroundColor = CustomColor.TravioWhite.color
        addSubview()
        switchComponent.topToSuperview()
        switchComponent.edgesToSuperview(excluding: [.top,.bottom],insets: .left(5) + .right(5))
        switchComponent.height(74)
        switchComponent.switchControl.addTarget(self, action: #selector(switchChanged(_:)), for: .valueChanged)
    }
    
    func addSubview(){
        self.contentView.addSubview(switchComponent)
    }
    
    func configureCell(cellData:PrivacySettingsData){
        switchComponent.lbl.text = cellData.titleText
        switchComponent.switchControl.isOn = cellData.switchState
        permissionType = cellData.perrmissionType
    }
    
    @objc func switchChanged(_ sender:UISwitch){
        
        if let settingsURL = URL(string: UIApplication.openSettingsURLString +  Bundle.main.bundleIdentifier!) {
            if UIApplication.shared.canOpenURL(settingsURL) {
                UIApplication.shared.open(settingsURL, options: [:], completionHandler: nil)
            }
        }
    }
    
}
