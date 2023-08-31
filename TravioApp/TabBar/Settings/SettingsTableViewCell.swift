//
//  SettingsTableViewCell.swift
//  TravioApp
//
//  Created by Kurumsal on 31.08.2023.
//

import UIKit
import SnapKit

class SettingsTableViewCell: UITableViewCell {
    
    private lazy var symbolImage: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "user-alt")
        return img
    }()
    
    private lazy var label: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: "Poppins-Light", size: 14)
        lbl.textColor = #colorLiteral(red: 0.3058650196, green: 0.30586496, blue: 0.3058649898, alpha: 1)
        lbl.text = "Security Settings"
        return lbl
    }()
    
    private lazy var forwardImage: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "forwardVector")
        return img
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
//    override func layoutSubviews() {
//        super.layoutSubviews()
//
//        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 8, left: 0, bottom: 0, right: 0))
//    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupViews() {
        contentView.addSubview(symbolImage)
        contentView.addSubview(label)
        contentView.addSubview(forwardImage)
        makeConst()
    }
    
    func makeConst() {
        symbolImage.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(17)
            make.leading.equalToSuperview().offset(16.51)
            make.width.equalTo(20.63)
            make.height.equalTo(20)
        }
        
        label.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(18)
            make.leading.equalTo(symbolImage.snp.trailing).offset(7.86)
        }
        
        forwardImage.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(19)
            make.trailing.equalToSuperview().offset(-19.37)
            make.width.equalTo(10.41)
            make.height.equalTo(15.63)
        }
    }
}
