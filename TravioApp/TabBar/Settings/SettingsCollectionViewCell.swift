//
//  SettingsCollectionViewCell.swift
//  TravioApp
//
//  Created by imrahor on 31.08.2023.
//

import UIKit

class SettingsCollectionViewCell: UICollectionViewCell {
    
    private lazy var view: UIView = {
        let v = UIView()
        return v
    }()
    
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        configureRoundedCorners()
    }
    
    private func configureRoundedCorners() {
           let cornerRadius: CGFloat = 16.0
           let corners: UIRectCorner = [.topLeft, .topRight, .bottomLeft]
           let maskPath = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: cornerRadius, height: cornerRadius))
           
           let shapeLayer = CAShapeLayer()
           shapeLayer.path = maskPath.cgPath
           layer.mask = shapeLayer
       }
    
    func configure(item: Settings) {
        symbolImage.image = UIImage(named: item.icon)
        label.text = item.label
    }
    
    func setupViews() {
        
        view.addSubview(symbolImage)
        view.addSubview(label)
        view.addSubview(forwardImage)
        contentView.addSubview(view)
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
        
        view.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

