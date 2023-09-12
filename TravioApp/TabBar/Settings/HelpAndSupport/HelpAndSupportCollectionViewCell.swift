//
//  HelpAndSupportCollectionViewCell.swift
//  TravioApp
//
//  Created by Kurumsal on 11.09.2023.
//

import UIKit

class HelpAndSupportCollectionViewCell: UICollectionViewCell {

    private lazy var lbl: UICustomLabel = {
        let l = UICustomLabel(labelType: .customTextFieldHeader(text: "Deneme"))
        l.height(50)
        l.numberOfLines = 0
        l.lineBreakMode = .byWordWrapping
        return l
    }()
    
    lazy var desclbl: UICustomLabel = {
        let l = UICustomLabel(labelType: .customTextViewDescription(text: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book."))
        l.numberOfLines = 0
        l.lineBreakMode = .byWordWrapping
        l.height(75)
        return l
    }()
    
    lazy var imageView: UIImageView = {
       let img = UIImageView()
        img.image = UIImage(systemName: "chevron.down")
        img.tintColor = CustomColor.TravioGreen.color
        img.contentMode = .scaleAspectFill
        return img
    }()
    
    private lazy var view: UIView = {
       let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    override init(frame: CGRect) {
            super.init(frame: frame)
            
            setupViews()
        }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        contentView.roundCornersWithShadow([.topLeft,.topRight,.bottomLeft], radius: 16)
    }
    
    func configure(title: String) {
        lbl.text = title
    }
    
    func setupViews() {
        contentView.addSubview(lbl)
        contentView.addSubview(desclbl)
        contentView.addSubview(imageView)
        contentView.backgroundColor = .white
        makeConst()
    }
    
    func makeConst() {
        lbl.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.equalToSuperview().offset(12)
            make.trailing.equalToSuperview().offset(-46)
        }
        
        desclbl.snp.makeConstraints { make in
            make.top.equalTo(lbl.snp.bottom).offset(12)
            make.leading.equalToSuperview().offset(12)
            make.trailing.equalToSuperview().offset(-15)
            make.bottom.equalTo(-16)
        }
        
        imageView.snp.makeConstraints { make in
            make.width.equalTo(10.41)
            make.height.equalTo(15.63)
            make.top.equalToSuperview().offset(19)
            make.trailing.equalToSuperview().offset(-18.37)
        }
        
        contentView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(2)
            make.leading.trailing.bottom.equalToSuperview()
            
        }
    }
}
