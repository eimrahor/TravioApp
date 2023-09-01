//
//  SecuritySettingsVC.swift
//  TravioApp
//
//  Created by Kurumsal on 1.09.2023.
//

import UIKit
import TinyConstraints
import SnapKit

class SecuritySettingsVC: UIViewController {
    
    let securitySettingsVM = SecuritySettingsVM()

    private lazy var background = BackgroundView()
    
    private lazy var lblChangePassword: UICustomLabel = {
        let lbl = UICustomLabel()
        lbl.text = "Change Password"
        lbl.font = CustomFont.PoppinsSemiBold(16).font
        return lbl
    }()
    
    private lazy var newPasswordView: CustomViewWithTextField = {
        let view = CustomViewWithTextField()
        view.txtField.isSecureTextEntry = true
        view.txtField.text = "New Password"
        return view
    }()
    
    private lazy var newPasswordConfirmView: UIView = {
        let view = CustomViewWithTextField()
        view.txtField.isSecureTextEntry = true
        view.txtField.text = "New Password Confirm"
        return view
    }()
    
    private lazy var stackView: UIStackView = {
        let sv = UIStackView()
        sv.addArrangedSubview(lblChangePassword)
        sv.addArrangedSubview(newPasswordView)
        sv.addArrangedSubview(newPasswordConfirmView)
        // FIXME: complete stackview
        return sv
    }()
    
    private lazy var lblPrivacy: UICustomLabel = {
        let lbl = UICustomLabel()
        lbl.text = "Privacy"
        lbl.font = CustomFont.PoppinsSemiBold(16).font
        return lbl
    }()
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
    }

    func setupLayout(){
        
        self.view.backgroundColor = CustomColor.TravioGreen.color
        addSubviews()
        
        background.bottomToSuperview()
        background.height(to: self.view,multiplier: 0.82)
        background.width(to: self.view)
    }
    
    func addSubviews(){
        self.view.addSubview(background)
       
    }

}
