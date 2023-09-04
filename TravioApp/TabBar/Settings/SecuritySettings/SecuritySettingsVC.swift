//
//  SecuritySettingsVC.swift
//  TravioApp
//
//  Created by Kurumsal on 1.09.2023.
//

import UIKit
import TinyConstraints
import SnapKit

class SecuritySettingsVC: MainViewController {
    
    let securitySettingsVM = SecuritySettingsVM()
    
    // TODO: Add back button
    private lazy var lblPageTitle: UICustomLabel = {
        let lbl = UICustomLabel(labelType: .pageNameHeader(text: "Security Settings"))
        return lbl
    }()
    
    private lazy var lblChangePassword: UICustomLabel = {
        let lbl = UICustomLabel(labelType: .standardGreenHeader(text: "Change Password"))
        return lbl
    }()
    
    private lazy var cvPasswordSettings: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
         layout.minimumLineSpacing = 8
         layout.minimumInteritemSpacing = 8
         layout.scrollDirection = .vertical
         let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
         cv.showsVerticalScrollIndicator = false
         cv.delegate = self
         cv.dataSource = self
         cv.backgroundColor = .clear
         cv.register(ChangePasswordSettingsCell.self, forCellWithReuseIdentifier: "PasswordSettings")
         return cv
    }()
    
    private lazy var lblPrivacy: UICustomLabel = {
        let lbl = UICustomLabel(labelType: .standardGreenHeader(text: "Privacy"))
        return lbl
    }()
    
    private lazy var cvPrivacySettings: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
         layout.minimumLineSpacing = 8
         layout.minimumInteritemSpacing = 8
         layout.scrollDirection = .vertical
         let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
         cv.showsVerticalScrollIndicator = false
         cv.delegate = self
         cv.dataSource = self
         cv.backgroundColor = .clear
         cv.register(PrivacySettingsCell.self, forCellWithReuseIdentifier: "PrivacySettings")
         return cv
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
        lblPageTitle.bottomToTop(of: background,offset: -54)
        lblPageTitle.centerXToSuperview()
        
        lblChangePassword.top(to: background,offset: 44)
        lblChangePassword.leftToSuperview(offset:24)
        //156
        cvPasswordSettings.topToBottom(of: lblChangePassword,offset: 8)
        cvPasswordSettings.height(156)
        cvPasswordSettings.width(342)
        cvPasswordSettings.centerXToSuperview()
        
        lblPrivacy.topToBottom(of: cvPasswordSettings,offset: 24)
        lblPrivacy.leftToSuperview(offset:24)
        //156
        cvPrivacySettings.topToBottom(of: lblPrivacy,offset: 8)
        cvPrivacySettings.height(238)
        cvPrivacySettings.width(342)
        cvPrivacySettings.centerXToSuperview()
       
    }
    
    override func addSubviews(){
        super.addSubviews()
        self.view.addSubview(lblPageTitle)
        self.view.addSubview(lblChangePassword)
        self.view.addSubview(cvPasswordSettings)
        self.view.addSubview(lblPrivacy)
        self.view.addSubview(cvPrivacySettings)
    }

}
extension SecuritySettingsVC:UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 74)
    }
}
extension SecuritySettingsVC:UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case cvPasswordSettings :
            return securitySettingsVM.passwordSettingsDatas.count
        case cvPrivacySettings :
            return securitySettingsVM.privacySettingsDatas.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch collectionView {
            
        case cvPasswordSettings :
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PasswordSettings", for: indexPath) as? ChangePasswordSettingsCell else { return UICollectionViewCell() }
            cell.configureCell(cellData: securitySettingsVM.passwordSettingsDatas[indexPath.row])
            cell.backgroundColor = .white
            return cell
            
        case cvPrivacySettings :
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PrivacySettings", for: indexPath) as? PrivacySettingsCell else { return UICollectionViewCell() }
            cell.configureCell(cellData: securitySettingsVM.privacySettingsDatas[indexPath.row])
            cell.backgroundColor = .white
            return cell
            
        default:
            return UICollectionViewCell()
        }
       
        }
}
    
    

