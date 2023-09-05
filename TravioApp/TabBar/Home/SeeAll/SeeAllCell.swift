//
//  MyAddedPlacesCell.swift
//  TravioApp
//
//  Created by Kurumsal on 5.09.2023.
//

import UIKit
import SnapKit
import TinyConstraints

class SeeAllCell: UICollectionViewCell {
    
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
        lbl.text = "abc"
        return lbl
    }()
    
    private lazy var imgLocationLogo: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "map")
        return img
    }()
    
    private lazy var svCountry: UIStackView = {
        let sv = UIStackView()
        sv.addArrangedSubview(imgLocationLogo)
        sv.addArrangedSubview(lblCountry)
        sv.alignment = .center
        sv.distribution = .fillProportionally
        sv.spacing = 1
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
        self.contentView.backgroundColor = CustomColor.TravioWhite.color
        addSubviews()
        
        imgPlace.edgesToSuperview(excluding: [.right],insets: .left(0) + .top(0) + .bottom(0))
        imgPlace.width()
        
    }
    
    func addSubviews(){
        contentView.addSubview(imgPlace)
        contentView.addSubview(lblPlace)
        contentView.addSubview(svCountry)
    }
}
