//
//  ViewController.swift
//  ContinueAPI
//
//  Created by Kurumsal on 17.08.2023.
//

import UIKit
import SnapKit

class UserLoginVC: UIViewController {
    
    private lazy var logoImage: UIImageView = {
       let img = UIImageView()
        img.image = #imageLiteral(resourceName: "travio-logo 1")
        img.contentMode = .scaleAspectFit
        return img
    }()
    
    private lazy var secondView: UIView = {
        let v = UIView()
        v.backgroundColor = #colorLiteral(red: 0.9782040715, green: 0.9782040715, blue: 0.9782039523, alpha: 1)
        return v
    }()
    
    private lazy var welcomeLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Welcome to Travio"
        lbl.textAlignment = .center
        
        lbl.textColor = #colorLiteral(red: 0.3058650196, green: 0.30586496, blue: 0.3058649898, alpha: 1)
        lbl.font = UIFont(name: "Poppins-Medium", size: 24)
        return lbl
    }()
    
    private lazy var emailView: UIView = {
        let v = UIView()
        let width = view.frame.size.width - 48
        v.shadowAndRoundCorners(width: width, height: 74)
        return v
    }()
    
    private lazy var emailLabel: UILabel = {
       let lbl = UILabel()
        lbl.text = "Email"
        lbl.textColor = #colorLiteral(red: 0.3058650196, green: 0.30586496, blue: 0.3058649898, alpha: 1)
        lbl.font = UIFont(name: "Poppins-Medium", size: 14)
        return lbl
    }()
    
    private lazy var emailText: UITextField = {
       let tx = UITextField()
        tx.placeholder = "developer@bilgeadam.com"
        tx.text = "747172@gmail.com"
        tx.textColor = #colorLiteral(red: 0.7200164199, green: 0.7165551782, blue: 0.7164821029, alpha: 1)
        return tx
    }()
    
    private lazy var passwordView: UIView = {
        let v = UIView()
        let width = view.frame.size.width - 48
        v.shadowAndRoundCorners(width: width, height: 74)
        return v
    }()
    
    private lazy var passwordLabel: UILabel = {
       let lbl = UILabel()
        lbl.text = "Password"
        lbl.textColor = #colorLiteral(red: 0.3058650196, green: 0.30586496, blue: 0.3058649898, alpha: 1)
        lbl.font = UIFont(name: "Poppins-Medium", size: 14)
        return lbl
    }()
    
    private lazy var passText: UITextField = {
        let tx = UITextField()
        tx.placeholder = "*********"
        tx.text = "123123123"
        tx.textColor = #colorLiteral(red: 0.7200164199, green: 0.7165551782, blue: 0.7164821029, alpha: 1)
        tx.isSecureTextEntry = true
        return tx
    }()
    
    private lazy var loginButton: UIButton = {
       let bt = UIButton()
        bt.backgroundColor = #colorLiteral(red: 0.258569181, green: 0.7276339531, blue: 0.7204007506, alpha: 1)
        bt.tintColor = .white
        bt.addTarget(self, action: #selector(actLoginButton), for: .touchUpInside)
        bt.setTitle("Login", for: .normal)
        bt.titleLabel?.font = UIFont(name: "Poppins-SemiBold", size: 16)
        return bt
    }()
    
    private lazy var registerLabel: UILabel = {
       let lbl = UILabel()
        lbl.text = "Don't have any account?"
        lbl.textColor = #colorLiteral(red: 0.3058650196, green: 0.30586496, blue: 0.3058649898, alpha: 1)
        lbl.textAlignment = .right
        lbl.font = UIFont(name: "Poppins-SemiBold", size: 14)
        return lbl
    }()
    
    private lazy var registerButton: UIButton = {
       let bt = UIButton()
        bt.titleLabel?.font = UIFont(name: "Poppins-SemiBold", size: 14)
        bt.setTitleColor(#colorLiteral(red: 0.3058650196, green: 0.30586496, blue: 0.3058649898, alpha: 1), for: .normal)
        bt.addTarget(self, action: #selector(actRegisterButton), for: .touchUpInside)
        bt.setTitle("Sign Up", for: .normal)
        return bt
    }()
    
    private lazy var registerStack: UIStackView = {
       let sv = UIStackView()
        sv.axis = .horizontal
        sv.spacing = 2
        return sv
    }()
    
    let viewModel = UserLoginVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        secondView.roundCorners([.topLeft], radius: 80)
        loginButton.roundCorners([.topLeft, .topRight, .bottomLeft], radius: 12)
    }
    
    @objc func actLoginButton() {
        guard let email = emailText.text, let pass = passText.text else { return }
        let param = [
            "email": email,
            "password": pass
        ]
        viewModel.postForUserLogin(params: param) {
                let vc = MainTabbarController()
                self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @objc func actRegisterButton() {
        let vc = UserRegisterVC()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func setupViews() {
        view.backgroundColor = #colorLiteral(red: 0.258569181, green: 0.7276339531, blue: 0.7204007506, alpha: 1)
        
        registerStack.addArrangedSubview(registerLabel)
        registerStack.addArrangedSubview(registerButton)
        
        view.addSubview(logoImage)
        view.addSubview(secondView)
        view.addSubview(welcomeLabel)
        view.addSubview(emailView)
        view.addSubview(emailLabel)
        view.addSubview(emailText)
        view.addSubview(passwordView)
        view.addSubview(passwordLabel)
        view.addSubview(passText)
        view.addSubview(loginButton)
        view.addSubview(registerStack)
        makeConst()
    }
    
    func makeConst() {
        
        logoImage.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(64)
            make.centerX.equalTo(view.snp.centerX)
            make.width.equalTo(149)
            make.height.equalTo(178)
            make.bottom.equalTo(secondView.snp.top).offset(-24)
        }
        
        secondView.snp.makeConstraints { make in
            make.height.equalTo(view.snp.height).multipliedBy(0.7085)
            make.width.equalTo(view.snp.width)
            make.bottom.equalToSuperview()
        }
        
        welcomeLabel.snp.makeConstraints { make in
            make.top.equalTo(logoImage.snp.bottom).offset(88)
            make.width.equalTo(226)
            make.height.equalTo(36)
            make.centerX.equalTo(view.snp.centerX)
        }
        
        emailView.snp.makeConstraints { make in
            make.height.equalTo(74)
            make.width.equalTo(342)
            make.top.equalTo(welcomeLabel.snp.bottom).offset(41)
            make.leading.equalTo(24)
        }
        
        emailLabel.snp.makeConstraints { make in
            make.top.equalTo(emailView.snp.top).offset(8)
            make.leading.equalTo(emailView.snp.leading).offset(12)
            make.width.equalTo(39)
            make.height.equalTo(21)
        }
        
        emailText.snp.makeConstraints { make in
            make.bottom.equalTo(emailView.snp.bottom).offset(-19)
            make.leading.equalTo(emailLabel)
            make.trailing.equalTo(emailView.snp.trailing).offset(-12)
        }
        
        passwordView.snp.makeConstraints { make in
            make.height.equalTo(74)
            make.width.equalTo(342)
            make.top.equalTo(emailView.snp.bottom).offset(24)
            make.leading.equalTo(24)
        }
        
        passwordLabel.snp.makeConstraints { make in
            make.top.equalTo(passwordView.snp.top).offset(8)
            make.leading.equalTo(emailView.snp.leading).offset(12)
            make.width.equalTo(69)
            make.height.equalTo(21)
        }

        passText.snp.makeConstraints { make in
            make.bottom.equalTo(passwordView.snp.bottom).offset(-19)
            make.leading.equalTo(emailLabel)
            make.trailing.equalTo(passwordView.snp.trailing).offset(-12)
        }

        loginButton.snp.makeConstraints { make in
            make.top.equalTo(passwordView.snp.bottom).offset(48)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
            make.height.equalTo(54)
        }
        
        registerStack.snp.makeConstraints { make in
            make.bottom.equalTo(view.snp.bottom).offset(-21)
            make.centerX.equalTo(view.snp.centerX)
        }
    }

}

