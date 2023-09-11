//
//  PrivacySettingsCell.swift
//  TravioApp
//
//  Created by Elif Poyraz on 3.09.2023.
//

import UIKit
import TinyConstraints

class PrivacySettingsCell: UITableViewCell {
    
    let privacySettingCellVM = PrivacySettingsCellVM()
    var permissionType:PermissionType?
    var switchState: Bool?
    
    lazy var switchComponent: CustomComponentSwitch = {
        let component = CustomComponentSwitch()
        component.backgroundColor = CustomColor.White.color
        return component
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
        privacySettingCellVM.sendSwitchStateToVC = { switchState in
            self.switchState = switchState
        }
        guard let switchState = switchState else { return }
        self.switchComponent.switchControl.isOn = switchState
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLayout()
    {
        privacySettingCellVM.addObserver()
        self.contentView.backgroundColor = CustomColor.TravioWhite.color
        addSubview()
        switchComponent.topToSuperview()
        switchComponent.edgesToSuperview(excluding: [.top,.bottom],insets: .left(5) + .right(5))
        switchComponent.height(74)
        
        switchComponent.switchControl.addTarget(self, action: #selector(switchTryingChange(_:)), for: .valueChanged)
    }
    
    func addSubview(){
        self.contentView.addSubview(switchComponent)
    }
    
    func configureCell(cellData:PrivacySettingsData){
        switchComponent.lbl.text = cellData.titleText
        privacySettingCellVM.permissionType = cellData.perrmissionType
        
    }
    
    @objc func switchTryingChange(_ sender:UISwitch){
        
        if let settingsURL = URL(string: UIApplication.openSettingsURLString) {
            if UIApplication.shared.canOpenURL(settingsURL) {
                UIApplication.shared.open(settingsURL, options: [:], completionHandler: nil)
            }
        }
    }
    
}
