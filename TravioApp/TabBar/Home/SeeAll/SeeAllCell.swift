//
//  MyAddedPlacesCell.swift
//  TravioApp
//
//  Created by Kurumsal on 5.09.2023.
//

import UIKit
import SnapKit
import TinyConstraints
import Kingfisher

class SeeAllCell: UICollectionViewCell {
    
    var currentPlace:Place?
    
    private lazy var imgPlace: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "pinkfloyd")
        return img
    }()
    
    private lazy var lblPlace: UICustomLabel = {
        let lbl = UICustomLabel(labelType: .standardBlackHeader(text: "Colleseum"))
        return lbl
    }()
    
    private lazy var lblCountry: UICustomLabel = {
        let lbl = UICustomLabel(labelType: .standardBlackSubtitle(text: "Rome"))
        return lbl
    }()
    
    private lazy var imgLocationLogo: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "map")
        img.tintColor = CustomColor.TravioBlack.color
        return img
    }()
    
    private lazy var svCountry: UIStackView = {
        let sv = UIStackView()
        sv.addArrangedSubview(imgLocationLogo)
        sv.addArrangedSubview(lblCountry)
        sv.alignment = .center
        sv.distribution = .fillProportionally
        sv.spacing = 6
        sv.axis = .horizontal
        return sv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLayout()
    {
        //self.contentView.roundCornersWithShadow([.bottomLeft,.topLeft,.topRight], radius: 18)
        self.radiusWithShadow(corners: [.bottomLeft,.topLeft,.topRight])
        self.contentView.backgroundColor = CustomColor.White.color
        
        addSubviews()
        
        imgPlace.edgesToSuperview(excluding: [.right],insets: .left(0) + .top(0) + .bottom(0))
        imgPlace.width(89)
        
        lblPlace.topToSuperview(offset:16)
        lblPlace.leadingToTrailing(of: imgPlace,offset: 8)
        
        svCountry.topToBottom(of: lblPlace)
        svCountry.leading(to: lblPlace)
        svCountry.trailingToSuperview(offset:24)
        svCountry.height(21)
        
        imgLocationLogo.width(12)
        imgLocationLogo.height(12)
    }
    
    func addSubviews(){
        contentView.addSubview(imgPlace)
        contentView.addSubview(lblPlace)
        contentView.addSubview(svCountry)
    }
    
    func configureCell(place:Place){
        
        let url = URL(string: place.cover_image_url)
        imgPlace.kf.setImage(with: url)
        
        lblPlace.text = place.title
        lblCountry.text = place.place
        
        currentPlace = place
    }
}
