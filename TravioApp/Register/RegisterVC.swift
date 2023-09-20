//
//  RegisterVC.swift
//  TravioApp
//
//  Created by Elif Poyraz on 16.09.2023.
//

import UIKit
import SnapKit
import TinyConstraints

class RegisterVC: MainViewController {
     
    private lazy var lblPageTitle: UICustomLabel = {
        let lbl = UICustomLabel(labelType: .pageNameHeader(text: "Sign Up"))
        return lbl
    }()
    private lazy var btnBack : UICustomButtonBack = {
        let btn = UICustomButtonBack()
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
    private lazy var viewName: CustomComponentTextField = {
        let view = CustomComponentTextField()
        view.lbl.text = "Username"
        view.placeHolderConfig(placeHolderText: "bilge_adam")
        return view
    }()

    private lazy var viewEmail: CustomComponentTextField = {
        let view = CustomComponentTextField()
        view.lbl.text = "Email"
        view.placeHolderConfig(placeHolderText: "developer@bilgeadam.com")
        return view
    }()
    private lazy var viewPassword: CustomComponentTextField = {
        let view = CustomComponentTextField()
        view.lbl.text = "Password"
        view.placeHolderConfig(placeHolderText: "********")
        view.txtField.isSecureTextEntry = true
        return view
    }()
    private lazy var viewPasswordConfirm: CustomComponentTextField = {
        let view = CustomComponentTextField()
        view.lbl.text = "Password Confirm"
        view.placeHolderConfig(placeHolderText: "********")
        view.txtField.isSecureTextEntry = true
        return view
    }()

    private lazy var registerButton: UICustomButton = {
        let btn = UICustomButton(title: "Sign Up")
        btn.addTarget(self, action: #selector(signUp), for: .touchUpInside)
        return btn
    }()

    var viewModel = UserRegisterVM()
    var sendUsersArr: ((User)->Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        configureAlertClosures()
      
    }

    override func setupLayout() {
        super.setupLayout()
        self.navigationController?.navigationBar.isHidden = true
        
        addSubviews()
        
        svNavigationBar.topToSuperview(offset: 19,usingSafeArea: true)
        svNavigationBar.edgesToSuperview(excluding: [.top,.bottom],insets: .left(20) + .right(20))
        
        lblPageTitle.centerXToSuperview()
        
        viewName.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(196)
            make.width.equalTo(342)
            make.height.equalTo(74)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
        }
        
        viewEmail.snp.makeConstraints { make in
            make.top.equalTo(viewName.snp.bottom).offset(24)
            make.leading.trailing.equalTo(viewName)
            make.width.equalTo(342)
            make.height.equalTo(74)
        }

        viewPassword.snp.makeConstraints { make in
            make.top.equalTo(viewEmail.snp.bottom).offset(24)
            make.leading.trailing.equalTo(viewEmail)
            make.width.equalTo(342)
            make.height.equalTo(74)
        }

        viewPasswordConfirm.snp.makeConstraints { make in
            make.top.equalTo(viewPassword.snp.bottom).offset(24)
            make.leading.trailing.equalTo(viewPassword)
            make.width.equalTo(342)
            make.height.equalTo(74)
        }
        
        registerButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-23)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
            make.height.equalTo(54)
        }
    }
 
    override func addSubviews() {
        super.addSubviews()
        view.addSubviews(svNavigationBar,viewName,viewEmail,viewPassword,viewPasswordConfirm,registerButton)
    }
    
    @objc func actBack() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func signUp(){
        
        guard let fullname = viewName.txtField.text,
              let email = viewEmail.txtField.text,
              let password = viewPassword.txtField.text,
              let passwordConfirm = viewPasswordConfirm.txtField.text
            else { AlertHelper.shared.showAlert(currentVC: self, errorType: .valuesNil)
            return }
        
        if !viewModel.checkCanSignUp(name: fullname, email: email, password: password, passwordConfirm: passwordConfirm){return}
        
        let user = User(fullName: fullname, email: email, password: password)
        
        viewModel.postForRegisterData(user: user)
    }
    
    func configureAlertClosures(){
        
        viewModel.showAlert = { errorType in
            AlertHelper.shared.showAlert(currentVC: self, errorType: errorType)
        }
        let action = UIAlertAction(title: "OK", style: .default){
            handler in
            self.navigationController?.popViewController(animated: true)
        }
        viewModel.showSuccesfullyRegisterAlert = { message in
            AlertHelper.shared.showAlert(currentVC: self, errorType: .registerCompletedSuccessfully(action,message))
        }
    }

 }
