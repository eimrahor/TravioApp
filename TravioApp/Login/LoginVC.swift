//
//  LoginVC.swift
//  TravioApp
//
//  Created by Elif Poyraz on 16.09.2023.
//

import UIKit
import SnapKit
import TinyConstraints

class LoginVC: MainViewController {

    // MARK: - Properties
    
    private lazy var logoImage: UIImageView = {
       let img = UIImageView()
        img.image = #imageLiteral(resourceName: "travio-logo 1")
        img.contentMode = .scaleAspectFit
        return img
    }()
    
    private lazy var welcomeLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Welcome to Travio"
        lbl.textAlignment = .center
        lbl.textColor = #colorLiteral(red: 0.3058650196, green: 0.30586496, blue: 0.3058649898, alpha: 1)
        lbl.font = UIFont(name: "Poppins-Medium", size: 24)
        return lbl
    }()
    
    private lazy var viewEmail: CustomComponentTextField = {
       let view = CustomComponentTextField()
       view.lbl.text = "Email"
       view.txtField.text = "Elif@mail.com"
       view.placeHolderConfig(placeHolderText: "developer@bilgeadam.com")
        return view
    }()
    
    private lazy var viewPassword: CustomComponentTextField = {
       let view = CustomComponentTextField()
       view.lbl.text = "Password"
       view.txtField.text = "1234De"
       view.placeHolderConfig(placeHolderText: "*********")
       view.txtField.isSecureTextEntry = true
        return view
    }()
    
    private lazy var loginButton: UICustomButton = {
        let btn = UICustomButton(title: "Login")
        btn.addTarget(self, action: #selector(actLoginButton), for: .touchUpInside)
        return btn
    }()
    
    private lazy var registerLabel: UICustomLabel = {
        let lbl = UICustomLabel(labelType: .customBlackSemiBold14(text: "Don't have any account?"))
        return lbl
    }()
    
    private lazy var registerButton: UICustomButton = {
       let bt = UICustomButton()
        bt.buttonSetAttributedTitle(Title: "Sign Up",underLineStyle: .single)
        bt.addTarget(self, action: #selector(actRegisterButton), for: .touchUpInside)
        return bt
    }()
    
    private lazy var registerStack: UIStackView = {
       let sv = UIStackView()
        sv.axis = .horizontal
        sv.spacing = 2
        return sv
    }()
    
    let viewModel = UserLoginVM()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
       
    }
    override func viewWillAppear(_ animated: Bool) {
        viewModel.showAlert = { errorType in
            AlertHelper.shared.showAlert(currentVC: self, errorType: errorType)
        }
    }
    
    // MARK: - Selectors
    
    @objc func actRegisterButton() {
        let vc = RegisterVC()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func actLoginButton() {
        guard let email = viewEmail.txtField.text, let pass = viewPassword.txtField.text else { return }
        
        if !checkCanLogin(email: email, pass: pass) {return}
        let param = [
            "email": email,
            "password": pass
        ]
        viewModel.postForUserLogin(params: param) {
                let vc = MainTabbarController()
                self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    // MARK: - Helpers
    
    override func setupLayout() {
        addSubviews()
       
        background.bottomToSuperview()
        background.height(to: self.view, multiplier: 0.70)
        background.width(to: self.view)
        background.centerXToSuperview()
        
        logoImage.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(64)
            make.centerX.equalTo(view.snp.centerX)
            make.width.equalTo(149)
            make.height.equalTo(178)
            make.bottom.equalTo(background.snp.top).offset(-24)
        }
        
        welcomeLabel.snp.makeConstraints { make in
            make.top.equalTo(logoImage.snp.bottom).offset(88)
            make.width.equalTo(226)
            make.height.equalTo(36)
            make.centerX.equalTo(view.snp.centerX)
        }
        
        viewEmail.snp.makeConstraints { make in
            make.height.equalTo(74)
            make.width.equalTo(342)
            make.top.equalTo(welcomeLabel.snp.bottom).offset(41)
            make.leading.equalTo(24)
        }
        
        viewPassword.snp.makeConstraints { make in
            make.height.equalTo(74)
            make.width.equalTo(342)
            make.top.equalTo(viewEmail.snp.bottom).offset(24)
            make.leading.equalTo(24)
        }
        
        loginButton.snp.makeConstraints { make in
            make.top.equalTo(viewPassword.snp.bottom).offset(48)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
            make.height.equalTo(54)
        }
        
        registerStack.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-21)
            make.centerX.equalTo(view.snp.centerX)
        }
        
        registerLabel.leadingToSuperview()
        registerLabel.width(200)
        registerButton.trailingToSuperview()
        registerButton.width(70)
    }
    
    override func addSubviews() {
        super.addSubviews()
        registerStack.addArrangedSubview(registerLabel)
        registerStack.addArrangedSubview(registerButton)
        self.view.addSubviews(background,logoImage,welcomeLabel,viewEmail,viewPassword,loginButton,registerStack)
    }
    
    func checkCanLogin(email:String,pass:String)->Bool{
        if email == "" || pass == "" {
            AlertHelper.shared.showAlert(currentVC: self, errorType: .emailOrPasswordEmpty)
            return false
        }
        return true
    }
}
