//
//  MyAddedPlacesCell.swift
//  TravioApp
//
//  Created by Kurumsal on 5.09.2023.
//

import UIKit
import SnapKit

class MyAddedPlacesCell: UICollectionViewCell {
    
    private lazy var image: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "pinkfloyd")
        return img
    }()
    
    private lazy var titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "abc"
        return lbl
    }()
    
    private lazy var locationLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "abc"
        return lbl
    }()
    
    private lazy var locationImage: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "map")
        return img
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        contentView.addSubview(image)
        contentView.addSubview(titleLabel)
        contentView.addSubview(locationLabel)
        contentView.addSubview(locationImage)
        makeConst()
    }
    
    func makeConst() {
        image.snp.makeConstraints { make in
            make.top.bottom.leading.equalToSuperview()
            make.width.equalTo(90)
        }
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.equalTo(image.snp.trailing).offset(8)
        }
        locationImage.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(6)
            make.leading.equalTo(image.snp.trailing).offset(8)
            make.width.equalTo(9)
            make.height.equalTo(12)
        }
        locationLabel.snp.makeConstraints { make in
            make.centerY.equalTo(locationImage.snp.centerY)
            make.leading.equalTo(locationImage.snp.trailing).offset(6)
        }
    }
}
