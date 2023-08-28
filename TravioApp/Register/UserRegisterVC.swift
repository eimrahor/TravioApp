//
//  UserRegisterVC.swift
//  ContinueAPI
//
//  Created by Kurumsal on 17.08.2023.
//

import UIKit
import SnapKit

class UserRegisterVC: UIViewController {
    
    private lazy var backButton: UIButton = {
        let bt = UIButton()
//        bt.setImage(UIImage(systemName: "arrow.left"), for: .normal)
//        bt.imageView?.contentMode = .scaleToFill
//        bt.tintColor = .purple
//        bt.frame = CGRect(x: 0, y: 0, width: 100, height: 22)
//        let barButton = UIBarButtonItem(customView: bt)
//        navigationItem.leftBarButtonItem = barButton
//        navigationItem.leftBarButtonItem?.tintColor = .white
        let largeConfig = UIImage.SymbolConfiguration(scale: .large)
        let largeSymbolImage = UIImage(systemName: "arrow.left", withConfiguration: largeConfig)
        let barButton = UIBarButtonItem(image: largeSymbolImage, style: .plain, target: self, action: nil)
        navigationItem.leftBarButtonItem = barButton
        navigationItem.leftBarButtonItem?.tintColor = .white
        return bt
    }()
    
    private lazy var secondView: UIView = {
        let v = UIView()
        v.backgroundColor = #colorLiteral(red: 0.9782040715, green: 0.9782040715, blue: 0.9782039523, alpha: 1)
        return v
    }()
    
    private lazy var userNameView: UIView = {
        let v = UIView()
        let width = view.frame.size.width - 48
        v.shadowAndRoundCorners(width: width, height: 74)
        return v
    }()
    
    private lazy var userNameLabel: UILabel = {
       let lbl = UILabel()
        lbl.text = "Username"
        lbl.textColor = #colorLiteral(red: 0.3058650196, green: 0.30586496, blue: 0.3058649898, alpha: 1)
        lbl.font = UIFont(name: "Poppins-Medium", size: 14)
        return lbl
    }()
    
    private lazy var fullNameText: UITextField = {
       let tx = UITextField()
        tx.placeholder = "bilge_adam"
        tx.textColor = #colorLiteral(red: 0.7200164199, green: 0.7165551782, blue: 0.7164821029, alpha: 1)
        return tx
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
    
    private lazy var passwordText: UITextField = {
       let tx = UITextField()
        tx.textColor = #colorLiteral(red: 0.7200164199, green: 0.7165551782, blue: 0.7164821029, alpha: 1)
        tx.placeholder = "*********"
        tx.isSecureTextEntry = true
        return tx
    }()
    
    private lazy var passwordConfirmView: UIView = {
        let v = UIView()
        let width = view.frame.size.width - 48
        v.shadowAndRoundCorners(width: width, height: 74)
        return v
    }()
    
    private lazy var passwordConfirmLabel: UILabel = {
       let lbl = UILabel()
        lbl.text = "Password Confirm"
        lbl.textColor = #colorLiteral(red: 0.3058650196, green: 0.30586496, blue: 0.3058649898, alpha: 1)
        lbl.font = UIFont(name: "Poppins-Medium", size: 14)
        return lbl
    }()
    
    private lazy var passwordConfirmText: UITextField = {
       let tx = UITextField()
        tx.textColor = #colorLiteral(red: 0.7200164199, green: 0.7165551782, blue: 0.7164821029, alpha: 1)
        tx.placeholder = "*********"
        tx.isSecureTextEntry = true
        return tx
    }()
    
    private lazy var registerButton: UIButton = {
       let bt = UIButton()
        bt.backgroundColor = #colorLiteral(red: 0.6, green: 0.6, blue: 0.6, alpha: 1)
        bt.tintColor = .white
        bt.addTarget(self, action: #selector(actButton), for: .touchUpInside)
        bt.setTitle("Register", for: .normal)
        bt.titleLabel?.font = UIFont(name: "Poppins-SemiBold", size: 16)
        return bt
    }()
    
    var viewModel = UserRegisterVM()
    var sendUsersArr: ((User)->Void)?
    var user: User?
    
    
        override func viewDidLoad() {
            super.viewDidLoad()
            initVM()
            setupViews()
        }
    
    override func viewDidLayoutSubviews() {
        secondView.roundCorners([.topLeft], radius: 80)
        registerButton.roundCorners([.topLeft,.bottomLeft,.topRight], radius: 12)
    }
    
    
    func initVM() {
        
    }
    
    @objc func actButton() {
        guard let fullname = fullNameText.text, let email = emailText.text, let password = passwordText.text else { return }
        viewModel.postForRegisterData(params: [
            "full_name":fullname,
            "email":email,
            "password":password
        ])
        
        user = User(full_name: fullname, email: email, password: password)
        self.navigationController?.popViewController(animated: true)
    }
        
        func setupViews() {
            navigationItem.hidesBackButton = true
            
            let titleView = UILabel()
            titleView.text = "Sign Up"
            titleView.textColor = .white
            titleView.font = UIFont(name: "Poppins-SemiBold", size: 34)
            navigationItem.titleView = titleView
            
            
            view.backgroundColor = #colorLiteral(red: 0.258569181, green: 0.7276339531, blue: 0.7204007506, alpha: 1)
            
            view.addSubview(backButton)
            view.addSubview(secondView)
            view.addSubview(userNameView)
            view.addSubview(userNameLabel)
            view.addSubview(fullNameText)
            view.addSubview(emailView)
            view.addSubview(emailLabel)
            view.addSubview(emailText)
            view.addSubview(passwordView)
            view.addSubview(passwordLabel)
            view.addSubview(passwordText)
            view.addSubview(passwordConfirmView)
            view.addSubview(passwordConfirmLabel)
            view.addSubview(passwordConfirmText)
            view.addSubview(registerButton)
            makeConst()
        }
        
        func makeConst() {
            
            backButton.snp.makeConstraints { make in
                make.height.equalTo(22)
                make.width.equalTo(156)
            }
            
            secondView.snp.makeConstraints { make in
                make.height.equalTo(view.snp.height).multipliedBy(0.82)
                make.width.equalTo(view.snp.width)
                make.bottom.equalToSuperview()
            }
            
            userNameView.snp.makeConstraints { make in
                make.top.equalToSuperview().offset(196)
                make.width.equalTo(342)
                make.height.equalTo(74)
                make.leading.equalToSuperview().offset(24)
                make.trailing.equalToSuperview().offset(-24)
            }

            userNameLabel.snp.makeConstraints { make in
                make.top.equalTo(userNameView.snp.top).offset(8)
                make.leading.equalTo(userNameView.snp.leading).offset(12)
            }

            fullNameText.snp.makeConstraints { make in
                make.bottom.equalTo(userNameView.snp.bottom).offset(-19)
                make.leading.equalTo(userNameView.snp.leading).offset(12)
            }
            
            emailView.snp.makeConstraints { make in
                make.top.equalTo(userNameView.snp.bottom).offset(24)
                make.leading.trailing.equalTo(userNameView)
                make.width.equalTo(342)
                make.height.equalTo(74)
            }

            emailLabel.snp.makeConstraints { make in
                make.top.equalTo(emailView.snp.top).offset(8)
                make.leading.equalTo(emailView.snp.leading).offset(12)
            }

            emailText.snp.makeConstraints { make in
                make.bottom.equalTo(emailView.snp.bottom).offset(-19)
                make.leading.equalTo(emailView.snp.leading).offset(12)
            }
//
            passwordView.snp.makeConstraints { make in
                make.top.equalTo(emailView.snp.bottom).offset(24)
                make.leading.trailing.equalTo(userNameView)
                make.width.equalTo(342)
                make.height.equalTo(74)
            }

            passwordLabel.snp.makeConstraints { make in
                make.top.equalTo(passwordView.snp.top).offset(8)
                make.leading.equalTo(passwordView.snp.leading).offset(12)
            }

            passwordText.snp.makeConstraints { make in
                make.bottom.equalTo(passwordView.snp.bottom).offset(-19)
                make.leading.equalTo(passwordView.snp.leading).offset(12)
            }

            passwordConfirmView.snp.makeConstraints { make in
                make.top.equalTo(passwordView.snp.bottom).offset(24)
                make.leading.trailing.equalTo(userNameView)
                make.width.equalTo(342)
                make.height.equalTo(74)
            }

            passwordConfirmLabel.snp.makeConstraints { make in
                make.top.equalTo(passwordConfirmView.snp.top).offset(8)
                make.leading.equalTo(passwordConfirmView.snp.leading).offset(12)
            }

            passwordConfirmText.snp.makeConstraints { make in
                make.bottom.equalTo(passwordConfirmView.snp.bottom).offset(-19)
                make.leading.equalTo(passwordConfirmView.snp.leading).offset(12)
            }
            
            registerButton.snp.makeConstraints { make in
                make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-23)
                make.leading.equalToSuperview().offset(24)
                make.trailing.equalToSuperview().offset(-24)
                make.height.equalTo(54)
            }
        }
    }
    

