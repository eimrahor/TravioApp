//
//  UserRegisterVC.swift
//  ContinueAPI
//
//  Created by Kurumsal on 17.08.2023.
//

import UIKit
import SnapKit
import TinyConstraints

class UserRegisterVC: UIViewController {
    
    private lazy var lblPageTitle: UICustomLabel = {
        let lbl = UICustomLabel(labelType: .pageNameHeader(text: "Sign Up"))
        return lbl
    }()
    
    private lazy var btnBack : UICustomButton = {
        let btn = UICustomButton(title: "")
        let iv = UIImageView()
        iv.image = UIImage(named: "backArrow.png")
        iv.contentMode = .scaleAspectFit
        btn.addSubview(iv)
        iv.height(22)
        iv.width(24)
        btn.height(22)
        btn.width(24)
        btn.addTarget(self, action: #selector(actBack), for: .touchUpInside)
        return btn
    }()
    
    private lazy var svNavigationBar: UIStackView = {
        let sv = UIStackView()
        sv.addArrangedSubview(btnBack)
        sv.addArrangedSubview(lblPageTitle)
        sv.alignment = .center
        sv.spacing = 8
        sv.axis = .horizontal
        return sv
    }()
    
    private lazy var secondView: UIView = {
        let v = UIView()
        v.backgroundColor = #colorLiteral(red: 0.9764705882, green: 0.9764705882, blue: 0.9764705882, alpha: 1)
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
        setupViews()
    }
    
    override func viewDidLayoutSubviews() {
        secondView.roundCorners([.topLeft], radius: 80)
        registerButton.roundCorners([.topLeft,.bottomLeft,.topRight], radius: 12)
    }
    
    @objc func actBack() {
        self.navigationController?.popViewController(animated: true)
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
            self.navigationController?.navigationBar.isHidden = true
            
            view.backgroundColor = #colorLiteral(red: 0.258569181, green: 0.7276339531, blue: 0.7204007506, alpha: 1)
            
            view.addSubview(svNavigationBar)
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
            
            svNavigationBar.topToSuperview(offset: 19,usingSafeArea: true)
            svNavigationBar.edgesToSuperview(excluding: [.top,.bottom],insets: .left(20) + .right(20))
            
            lblPageTitle.centerXToSuperview()
            
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
                make.trailing.equalTo(userNameView.snp.trailing).offset(-12)
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
                make.trailing.equalTo(emailView.snp.trailing).offset(-12)
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
                make.trailing.equalTo(passwordView.snp.trailing).offset(-12)
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
                make.trailing.equalTo(passwordConfirmView.snp.trailing).offset(-12)
            }
            
            registerButton.snp.makeConstraints { make in
                make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-23)
                make.leading.equalToSuperview().offset(24)
                make.trailing.equalToSuperview().offset(-24)
                make.height.equalTo(54)
            }
        }
    }
    

