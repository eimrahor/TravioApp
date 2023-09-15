//
//  HomeCollectionViewCell.swift
//  TravioApp
//
//  Created by imrahor on 30.08.2023.
//

import UIKit
import Kingfisher

class HomeCollectionViewCell: UICollectionViewCell {
    
    var holdingPlace:Place?
    
    private lazy var image: UIImageView = {
       let img = UIImageView()
        img.contentMode = .scaleAspectFill
        img.image = UIImage(named: "pinkfloyd")
        return img
    }()
    
    private lazy var labelTitle: UILabel = {
       let lbl = UILabel()
        lbl.font = UIFont(name: "Poppins-SemiBold", size: 24)
        lbl.textColor = .white
        lbl.numberOfLines = 0
        lbl.lineBreakMode = .byWordWrapping
        return lbl
    }()
    
    private lazy var labelDesc: UILabel = {
       let lbl = UILabel()
        lbl.font = UIFont(name: "Poppins-Light", size: 14)
        lbl.textColor = .white
        return lbl
    }()
    
    private lazy var locationImage: UIImageView = {
       let img = UIImageView()
        img.image = UIImage(named: "map")?.withRenderingMode(.alwaysTemplate)
        img.tintColor = .white
        img.frame.size = CGSize(width: 9, height: 12)
        return img
    }()
    
    lazy var spinner: UIActivityIndicatorView = {
       let s = UIActivityIndicatorView()
        s.hidesWhenStopped = true
        s.style = .large
        s.color = .black
        return s
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(place: Place, status: Bool) {
        holdingPlace = place
        let url = URL(string: place.cover_image_url)
        image.kf.setImage(with: url)
        labelTitle.text = place.title
        labelDesc.text = place.place.returnSpecialStringText()
        if !status {
            spinner.stopAnimating()
        }
    }
    
    func setupViews() {
        
        self.backgroundColor = CustomColor.TravioWhite.color
        //FIXME: fix shadow and round corners.
        self.radiusWithShadow(corners: [.bottomLeft,.topLeft,.topRight])
        contentView.addSubview(image)
        contentView.addSubview(labelTitle)
        contentView.addSubview(labelDesc)
        contentView.addSubview(locationImage)
        contentView.addSubview(spinner)
        makeConst()
    }
    
    func makeConst() {
        image.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        labelTitle.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-29)
            make.leading.equalToSuperview().offset(22)
            make.trailing.equalToSuperview().offset(-22)
        }
        
        locationImage.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-8)
            make.leading.equalToSuperview().offset(22)
            make.width.equalTo(12)
            make.height.equalTo(15)
        }
        
        labelDesc.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-8)
            make.leading.equalToSuperview().offset(37)
        }
        
        spinner.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}
