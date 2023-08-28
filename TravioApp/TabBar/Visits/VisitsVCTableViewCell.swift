//
//  VisitsVCTableViewCell.swift
//  ContinueAPI
//
//  Created by Kurumsal on 21.08.2023.
//

import UIKit
import SnapKit
import Kingfisher

class VisitsVCTableViewCell: UITableViewCell {

    private lazy var img: UIImageView = {
       let img = UIImageView()
        img.contentMode = .scaleToFill
        return img
    }()
    
    private lazy var locationImg: UIImageView = {
       let img = UIImageView()
        return img
    }()
    
    private lazy var labelCity: UILabel = {
       let lbl = UILabel()
        lbl.textColor = .white
        return lbl
    }()
    
    var travel : Place?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        layoutIfNeeded()
        img.roundCorners([.topLeft], radius: 16)
    }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(object: Place) {
        let url = URL(string: object.cover_image_url)
        img.kf.setImage(with: url)
        
        locationImg.image = UIImage(named: "map")
        locationImg.image = locationImg.image?.withRenderingMode(.alwaysTemplate)
        locationImg.tintColor = .white
        
        labelCity.text = object.place
    }
    
    func setupViews() {
        contentView.backgroundColor = #colorLiteral(red: 0.9782040715, green: 0.9782040715, blue: 0.9782039523, alpha: 1)
        contentView.addSubview(img)
        contentView.addSubview(locationImg)
        contentView.addSubview(labelCity)
        
        makeConsts()
    }
    
    func makeConsts() {
        img.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(219)
            make.width.equalTo(344)
        }
        
        locationImg.snp.makeConstraints { make in
            make.leading.equalTo(img).offset(8)
            make.bottom.equalTo(img).offset(-6)
            make.width.equalTo(15)
            make.height.equalTo(20)
        }

        labelCity.snp.makeConstraints { make in
            make.leading.equalTo(locationImg.snp.trailing).offset(6)
            make.bottom.equalTo(img.snp.bottom).offset(-6)
        }
    }
}
