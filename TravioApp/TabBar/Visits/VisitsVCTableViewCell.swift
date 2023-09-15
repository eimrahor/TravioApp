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
        img.contentMode = .scaleAspectFill
        return img
    }()
    
    private lazy var locationImg: UIImageView = {
       let img = UIImageView()
        return img
    }()
    
    private lazy var labelCity: UILabel = {
       let lbl = UILabel()
        lbl.textColor = .white
        lbl.numberOfLines = 1
        return lbl
    }()
    
    private lazy var placeTitle: UILabel = {
       let lbl = UILabel()
        lbl.textColor = .white
        lbl.font = UIFont(name: "Poppins-SemiBold", size: 30)
        lbl.numberOfLines = 1
        return lbl
    }()
    
    var travel : Place?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        layoutIfNeeded()
        img.roundCorners([.topLeft,.topRight,.bottomLeft], radius: 16)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(object: Visit) {
        let url = URL(string: object.place.cover_image_url)
        img.kf.setImage(with: url)
        
        locationImg.image = UIImage(named: "map")
        locationImg.image = locationImg.image?.withRenderingMode(.alwaysTemplate)
        locationImg.tintColor = .white
        placeTitle.text = object.place.title
        labelCity.text = object.place.place.returnSpecialStringText()
    }
    
    func setupViews() {
        contentView.backgroundColor = #colorLiteral(red: 0.9782040715, green: 0.9782040715, blue: 0.9782039523, alpha: 1)
        
        contentView.addSubview(img)
        contentView.addSubview(placeTitle)
        contentView.addSubview(locationImg)
        contentView.addSubview(labelCity)
        
        makeConsts()
    }
    
    func makeConsts() {
        img.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.centerX.equalTo(contentView.snp.centerX)
            make.height.equalTo(219)
            make.width.equalTo(344)
        }
        
        placeTitle.snp.makeConstraints { make in
            make.top.equalTo(img.snp.top).offset(142)
            make.leading.equalTo(img.snp.leading).offset(8)
            make.trailing.equalTo(img.snp.trailing).offset(-37)
        }
        
        locationImg.snp.makeConstraints { make in
            make.leading.equalTo(img).offset(8)
            make.top.equalTo(img.snp.top).offset(189)
            make.width.equalTo(15)
            make.height.equalTo(20)
        }

        labelCity.snp.makeConstraints { make in
            make.top.equalTo(img.snp.top).offset(187)
            make.leading.equalTo(locationImg.snp.trailing).offset(6)
            make.trailing.equalToSuperview().offset(-6)
        }
    }
}
