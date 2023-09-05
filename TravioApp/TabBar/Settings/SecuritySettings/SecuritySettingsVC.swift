//
//  SecuritySettingsVC.swift
//  TravioApp
//
//  Created by Kurumsal on 1.09.2023.
//

import UIKit
import TinyConstraints
import SnapKit

struct PasswordSettingsData{
    var titleText:String
    var placeHolderText:String
}

struct PrivacySettingsData{
    var titleText:String
    var switchState:Bool
}
enum SecuritySettingsCellType{
    case PrivacySettingCell
    case PasswordSettingCell
}

class SecuritySettingsVC: MainViewController, UICollectionViewDelegate {
    
    let securitySettingsVM = SecuritySettingsVM()
    
    // TODO: Add back button
    private lazy var lblPageTitle: UICustomLabel = {
        let lbl = UICustomLabel(labelType: .pageNameHeader(text: "Security Settings"))
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
        sv.spacing = 8
        sv.axis = .horizontal
        return sv
    }()
    
    private lazy var tvSecuritySettings: UITableView = {
        let tv = UITableView(frame: .zero, style: .grouped)
        tv.delegate = self
        tv.dataSource = self
        tv.backgroundColor = .clear
        tv.showsVerticalScrollIndicator = false
        tv.register(ChangePasswordSettingsCell.self, forCellReuseIdentifier: "PasswordSettings")
        tv.register(PrivacySettingsCell.self, forCellReuseIdentifier: "PrivacySettings")
        return tv
    }()
    
    private var btnSave: UICustomButton = {
        let btn = UICustomButton(title: "Save")
        btn.addTarget(self, action: #selector(saveSettings), for: .touchUpInside)
        return btn
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
    }

    override func setupLayout(backGroundMultiplier: CGFloat = 0.82) {
        
        super.setupLayout()
       // super.backGroundMultiplier = 0.7
       // super.changeBackgroundMultiplier(to: 0.70)    - ver2
        self.view.backgroundColor = CustomColor.TravioGreen.color
        self.navigationController?.isNavigationBarHidden = true
        
        addSubviews()
        
        svNavigationBar.topToSuperview(offset: 19,usingSafeArea: true)
        svNavigationBar.edgesToSuperview(excluding: [.top,.bottom],insets: .left(20) + .right(20))
        
        tvSecuritySettings.top(to: background,offset: 44)
        tvSecuritySettings.edgesToSuperview(excluding: .top,insets: .bottom(70) + .left(20) + .right(20))
        tvSecuritySettings.centerXToSuperview()
        
        btnSave.bottomToSuperview(offset:-18,usingSafeArea: true)
        btnSave.edgesToSuperview(excluding: [.top,.bottom],insets: .left(24) + .right(24))
    }
    
    override func addSubviews(){
        super.addSubviews()
        self.view.addSubview(svNavigationBar)
        self.view.addSubview(tvSecuritySettings)
        self.view.addSubview(btnSave)
    }
    
    @objc func saveSettings(){
        print("savesettings")
    }
    @objc func goPopView(){
        self.navigationController?.popViewController(animated: true)
    }
    
}
extension SecuritySettingsVC:UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return  83
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
           return "CHANGE PASSWORD"
        case 1:
            return "PRIVACY"
        default:
            return ""
        }
    }
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int){
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = UIColor.white
        header.textLabel?.font = CustomFont.PoppinsSemiBold(16).font
        header.textLabel?.textColor = CustomColor.TravioGreen.color
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        24
    }
}
extension SecuritySettingsVC:UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch section {
        case 0:
           return securitySettingsVM.passwordSettingsDatas.count
        case 1:
            return securitySettingsVM.privacySettingsDatas.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "PasswordSettings", for: indexPath) as? ChangePasswordSettingsCell else { return UITableViewCell() }
            let object = securitySettingsVM.passwordSettingsDatas[indexPath.row]
            cell.configureCell(cellData: object)
            return cell
            
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "PrivacySettings", for: indexPath) as? PrivacySettingsCell else { return UITableViewCell() }
            let object = securitySettingsVM.privacySettingsDatas[indexPath.row]
            cell.configureCell(cellData: object)
            return cell
        default:
            return UITableViewCell()
        }
    }
    
}
    
    

