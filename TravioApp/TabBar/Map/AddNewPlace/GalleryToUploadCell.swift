//
//  GalleryToUploadCell.swift
//  TravioApp
//
//  Created by Elif Poyraz on 29.08.2023.
//

import UIKit
import SnapKit

class GalleryToUploadCell: UICollectionViewCell {
    
    private lazy var image: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFit
        let defaultImg = UIImage(systemName: "camera.fill")
        img.image = defaultImg
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
        self.contentView.backgroundColor = CustomColor.White.color
        contentView.addSubview(image)
        makeConst()
    }
    
    func makeConst() {
        image.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
