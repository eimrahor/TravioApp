//
//  DetailVisitsCell.swift
//  ContinueAPI
//
//  Created by Kurumsal on 23.08.2023.
//

import UIKit
import SnapKit

class DetailVisitsCell: UICollectionViewCell {
    
    private lazy var image: UIImageView = {
       let img = UIImageView()
        img.contentMode = .scaleAspectFill
        return img
    }()
    
    private lazy var spinner: UIActivityIndicatorView = {
        let s = UIActivityIndicatorView()
        s.hidesWhenStopped = true
        s.color = .black
        s.style = .large
        return s
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(object: Image) {
        spinner.startAnimating()
        let url = URL(string: object.image_url)
        image.kf.setImage(with: url) { result in
            switch result {
            case .success(_):
                self.spinner.stopAnimating()
            case .failure(_):
                self.spinner.stopAnimating()
            }
        }
    }
    
    func setupViews() {
        contentView.addSubview(image)
        contentView.addSubview(spinner)
        makeConst()
    }
    
    func makeConst() {
        image.snp.makeConstraints { make in
            make.height.equalTo(249)
            make.width.equalTo(390)
            make.top.leading.trailing.bottom.equalToSuperview()
        }
        
        spinner.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}
