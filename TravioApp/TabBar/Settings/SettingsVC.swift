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
        v.backgroundColor = #colorLiteral(red: 0.9782040715, green: 0.9782040715, blue: 0.9782039523, alpha: 1)
        return v
    }()
    
    private lazy var titleLabel: UILabel = {
       let lbl = UILabel()
        lbl.text = "Settings"
        lbl.textColor = .white
        lbl.font = UIFont(name: "Poppins-SemiBold", size: 32)
        return lbl
    }()
    
    private lazy var image: UIImageView = {
       let img = UIImageView()
        img.image = UIImage(named: "bruce")
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
        return bt
    }()
    
    private lazy var tableView: UITableView = {
       let tv = UITableView()
        tv.delegate = self
        tv.dataSource = self
        tv.register(SettingsTableViewCell.self, forCellReuseIdentifier: "SettingsCell")
        return tv
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
    }
    
    override func viewDidLayoutSubviews() {
        secondView.roundCorners([.topLeft], radius: 80)
    }
    
    func setupViews() {
        view.addSubview(secondView)
        view.addSubview(titleLabel)
        view.addSubview(image)
        view.addSubview(nameLabel)
        view.addSubview(editButton)
        view.addSubview(tableView)
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
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(editButton.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview().offset(137)
        }
    }
}

extension SettingsVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 54
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
}

extension SettingsVC: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsCell", for: indexPath) as? SettingsTableViewCell else { return UITableViewCell() }
        
        return cell
    }
}
