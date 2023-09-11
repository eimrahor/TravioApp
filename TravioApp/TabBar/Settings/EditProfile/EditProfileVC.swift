//
//  EditProfileVC.swift
//  TravioApp
//
//  Created by Elif Poyraz on 10.09.2023.
//

import UIKit
import TinyConstraints

class EditProfileVC: MainViewController {

    let editProfileVM = EditPorfileVM()
    
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
        view.shadowAndRoundCorners(width: view.frame.width, height: view.frame.height)
    }()
    
    private lazy var imgProfile: UIImageView = {
       let img = UIImageView()
        img.image = UIImage(named: "bruce")
        return img
    }() 1998    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
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
        
        
    }
    
    override func addSubviews() {
        super.addSubviews()
        self.view.addSubviews(svNavigationBar,imgProfile,btnChangePhoto,lblName)
    }
    
    @objc func goPopView(){
        self.navigationController?.popViewController(animated: true)
    }
    @objc func changePhoto(){
        
    }

}
