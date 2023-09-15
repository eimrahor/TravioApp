//
//  MenuVC.swift
//  ContinueAPI
//
//  Created by imrahor on 19.08.2023.
//

import UIKit
import SnapKit

class SettingsVC: UIViewController {

    private lazy var secondView: UIView = {
       let v = UIView()
        v.backgroundColor = #colorLiteral(red: 0.9725490196, green: 0.9725490196, blue: 0.9725490196, alpha: 1)
        return v
    }()
    
    private lazy var titleLabel: UILabel = {
       let lbl = UILabel()
        lbl.text = "Settings"
        lbl.textColor = .white
        lbl.font = UIFont(name: "Poppins-SemiBold", size: 32)
        return lbl
    }()
    
    private lazy var logoutBtn: UIButton = {
        let bt = UIButton()
        bt.setImage(UIImage(named: "logoutButton"), for: .normal)
        bt.addTarget(self, action: #selector(actLogoutButton), for: .touchUpInside)
        return bt
    }()
    
    private lazy var image: UIImageView = {
       let img = UIImageView()
        img.contentMode = .scaleAspectFill
        img.tintColor = CustomColor.TravioGreen.color
        return img
    }()
    
    private lazy var nameLabel: UILabel = {
       let lbl = UILabel()
        lbl.text = "Bruce Wills"
        lbl.font = UIFont(name: "Poppins-SemiBold", size: 16)
        return lbl
    }()
    
    private lazy var editButton: UIButton = {
       let bt = UIButton()
        bt.setTitle("Edit Profile", for: .normal)
        bt.titleLabel?.font = UIFont(name: "Poppins-Regular", size: 12)
        bt.setTitleColor(#colorLiteral(red: 0, green: 0.7960889935, blue: 0.9382097721, alpha: 1), for: .normal)
        bt.addTarget(self, action: #selector(goEditProfile), for: .touchUpInside)
        return bt
    }()
    
    private lazy var collectionView: UICollectionView = {
       let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 8
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.showsVerticalScrollIndicator = false
        cv.delegate = self
        cv.dataSource = self
        cv.backgroundColor = .clear
        cv.register(SettingsCollectionViewCell.self, forCellWithReuseIdentifier: "SettingsCell")
        return cv
    }()
    
    let viewModel = SettingsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        initVM()
    }
    func initVM(){
        viewModel.sendUserDataToVC = { user in
            self.nameLabel.text = user.full_name
            guard let stringURL = user.pp_url else {
                self.image.image = UIImage(systemName: "person.circle.fill")
                return}
            
            let url = URL(string: stringURL)
            self.image.kf.indicatorType = .activity
            self.image.kf.setImage(with: url)
            if user.pp_url == "" {
                self.image.image = UIImage(systemName: "person.circle.fill")
            }
        }
        viewModel.getUserProfile()
    }
    
    override func viewDidLayoutSubviews() {
        navigationController?.navigationBar.isHidden = true 
        secondView.roundCorners([.topLeft], radius: 80)
        
        let maskPath = UIBezierPath(roundedRect: image.bounds, cornerRadius: 60)
        let maskLayer = CAShapeLayer()
        maskLayer.path = maskPath.cgPath
        image.layer.mask = maskLayer
    }
    
    @objc func actLogoutButton() {
        KeyChainHelper.shared.deleteKey(account: "ios")
        
        let loginVC = UserLoginVC()
        let navigationController = UINavigationController(rootViewController: loginVC)
                
        let windowsSD = (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.window
        windowsSD?.rootViewController = navigationController
        windowsSD?.makeKeyAndVisible()
    }
    
    @objc func goEditProfile(){
        let targetVC = EditProfileVC()
        targetVC.editProfileVM.userProfile = viewModel.user
        self.navigationController?.pushViewController(targetVC, animated: true)
    }
    
    func setupViews() {
        view.addSubview(secondView)
        view.addSubview(titleLabel)
        view.addSubview(logoutBtn)
        view.addSubview(image)
        view.addSubview(nameLabel)
        view.addSubview(editButton)
        view.addSubview(collectionView)
        makeConst()
    }
    
    func makeConst() {
        
        secondView.snp.makeConstraints { make in
            make.height.equalTo(view.snp.height).multipliedBy(0.82)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.bottom.equalTo(secondView.snp.top).offset(-54)
        }
        
        logoutBtn.snp.makeConstraints { make in
            make.bottom.equalTo(secondView.snp.top).offset(-61.1)
            make.trailing.equalToSuperview().offset(-24)
            make.height.equalTo(30.9)
            make.width.equalTo(30)
        }
        
        image.snp.makeConstraints { make in
            make.top.equalTo(secondView.snp.top).offset(24)
            make.centerX.equalTo(view.snp.centerX)
            make.height.equalTo(120)
            make.width.equalTo(120)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(image.snp.bottom).offset(8)
            make.centerX.equalTo(view.snp.centerX)
        }
        
        editButton.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom)
            make.centerX.equalTo(view.snp.centerX)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(editButton.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview()
        }
    }
}

extension SettingsVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 54)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let targetVC = viewModel.arr[indexPath.row].targetVC
        if let targetVC = targetVC as? SeeAllVC {
            targetVC.listedPlacesType = .myAddedPlaces
        }
        self.navigationController?.pushViewController(targetVC, animated: true)
    }
}

extension SettingsVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.countofArr()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SettingsCell", for: indexPath) as? SettingsCollectionViewCell else { return UICollectionViewCell() }
            cell.configure(item: viewModel.arr[indexPath.row])
        cell.backgroundColor = .white
            return cell
        }
}

