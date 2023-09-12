//
//  EditProfileVC.swift
//  TravioApp
//
//  Created by Elif Poyraz on 10.09.2023.
//

import UIKit
import TinyConstraints

class EditProfileVC: MainViewController {

    let editProfileVM = EditProfileVM()
    
    private lazy var lblPageTitle: UICustomLabel = {
        let lbl = UICustomLabel(labelType: .pageNameHeader(text: "Edit Profile"))
        lbl.textAlignment = .left
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
        btn.addTarget(self, action: #selector(goPopView), for: .touchUpInside)
        return btn
    }()
    private lazy var svNavigationBar: UIStackView = {
        let sv = UIStackView()
        sv.addArrangedSubview(btnBack)
        sv.addArrangedSubview(lblPageTitle)
        sv.alignment = .center
        sv.distribution = .fillProportionally
        sv.spacing = 30
        sv.axis = .horizontal
        return sv
    }()
    
    private lazy var imgProfile: UIImageView = {
       let img = UIImageView()
        img.image = UIImage(named: "bruce")
        return img
    }()
    
    private lazy var btnChangePhoto: UIButton = {
       let bt = UIButton()
        bt.setTitle("Edit Profile", for: .normal)
        bt.titleLabel?.font = CustomFont.PoppinsRegular(12).font
        bt.setTitleColor(CustomColor.TravioGreen.color, for: .normal)
        bt.addTarget(self, action: #selector(changePhoto), for: .touchUpInside)
        return bt
    }()
    
    private lazy var lblName: UILabel = {
       let lbl = UILabel()
        lbl.text = "Bruce Wills"
        lbl.font = CustomFont.PoppinsSemiBold(24).font
        return lbl
    }()
    
    private lazy var viewRegisterDate:UIView = {
      let view = UIView()
        view.height(52); view.width(163)
        view.addSubview(svDate)
        return view
    }()
    
    private lazy var imgDateIcon: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "editProfileDateIcon")
        img.contentMode = .scaleAspectFit
        return img
    }()
    private lazy var lblDate: UICustomLabel = {
        let lbl = UICustomLabel(labelType: .standardBlackLabel(text: "30 Ağustos 2023"))
        return lbl
    }()
    private lazy var svDate: UIStackView = {
        let sv = UIStackView()
        sv.addArrangedSubview(imgDateIcon)
        sv.addArrangedSubview(lblDate)
        sv.distribution = .fillProportionally
        sv.alignment = .center
        sv.axis = .horizontal
        sv.spacing = 2
        return sv
    }()
    
    private lazy var viewRole:UIView = {
      let view = UIView()
        view.height(52); view.width(163)
        view.addSubview(svRole)
        return view
    }()
    private lazy var imgRoleIcon: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "editProfileRoleIcon")
        img.contentMode = .scaleAspectFit
        return img
    }()
    private lazy var lblRole: UICustomLabel = {
        let lbl = UICustomLabel(labelType: .standardBlackLabel(text: "Admin"))
        return lbl
    }()
    private lazy var svRole: UIStackView = {
        let sv = UIStackView()
        sv.addArrangedSubview(imgRoleIcon)
        sv.addArrangedSubview(lblRole)
        sv.distribution = .fillProportionally
        sv.alignment = .center
        sv.axis = .horizontal
        sv.spacing = 2
        return sv
    }()
    
    private lazy var viewFullName:CustomComponentTextField = {
        let view = CustomComponentTextField()
        view.lbl.text = "Full Name"
        view.lbl.textColor = #colorLiteral(red: 0.3058650196, green: 0.30586496, blue: 0.3058649898, alpha: 1)
        view.placeHolderConfig(placeHolderText: "bilge_adam")
        return view
    }()
    
    private lazy var viewEmail:CustomComponentTextField = {
        let view = CustomComponentTextField()
        view.lbl.text = "Email"
        view.lbl.textColor = #colorLiteral(red: 0.3058650196, green: 0.30586496, blue: 0.3058649898, alpha: 1)
        view.placeHolderConfig(placeHolderText: "developer@bilgeadam.com")
        return view
    }()
    
    private var btnSave: UICustomButton = {
        let btn = UICustomButton(title: "Save")
        btn.addTarget(self, action: #selector(saveChanges), for: .touchUpInside)
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
    }
    
    override func viewDidLayoutSubviews() {
        viewRegisterDate.shadowAndRoundCorners(width: viewRegisterDate.frame.width, height: viewRegisterDate.frame.height)
        viewRole.shadowAndRoundCorners(width: viewRole.frame.width, height: viewRole.frame.height)
        
    }
    
    override func setupLayout(backGroundMultiplier: CGFloat = 0.82) {
        super.setupLayout(backGroundMultiplier: backGroundMultiplier)
        self.navigationController?.isNavigationBarHidden = true
        
        addSubviews()
        
        svNavigationBar.topToSuperview(offset: 19,usingSafeArea: true)
        svNavigationBar.edgesToSuperview(excluding: [.top,.bottom],insets: .left(20) + .right(20))
        
        imgProfile.top(to: background,offset: 24)
        imgProfile.height(120); imgProfile.width(120)
        imgProfile.centerXToSuperview()
        
        btnChangePhoto.topToBottom(of: imgProfile,offset: 7)
        btnChangePhoto.centerXToSuperview()
        
        lblName.topToBottom(of: btnChangePhoto,offset: 7)
        lblName.centerXToSuperview()
        
        viewRegisterDate.topToBottom(of: lblName,offset: 21)
        viewRegisterDate.leadingToSuperview(offset:24)
        
        svDate.centerYToSuperview()
        svDate.leadingToSuperview(offset:16)
        
        svRole.centerYToSuperview()
        svRole.leadingToSuperview(offset:16)
        
        viewRole.topToBottom(of: lblName,offset: 21)
        viewRole.trailingToSuperview(offset:24)
        
        viewFullName.topToBottom(of: viewRegisterDate,offset: 19)
        viewFullName.edgesToSuperview(excluding: [.bottom,.top],insets: .left(24) + .right(24))
        
        viewEmail.topToBottom(of: viewFullName,offset: 19)
        viewEmail.edgesToSuperview(excluding: [.bottom,.top],insets: .left(24) + .right(24))
        
        btnSave.bottomToSuperview(offset:-18,usingSafeArea: true)
        btnSave.edgesToSuperview(excluding: [.top,.bottom],insets: .left(24) + .right(24))
        
    }
    
    override func addSubviews() {
        super.addSubviews()
        self.view.addSubviews(svNavigationBar,imgProfile,btnChangePhoto,lblName,viewRegisterDate,viewRole,viewFullName,viewEmail,btnSave)
    }
    
    @objc func goPopView(){
        self.navigationController?.popViewController(animated: true)
    }
    @objc func changePhoto(){
        
    }
    @objc func saveChanges(){
        
    }

}
