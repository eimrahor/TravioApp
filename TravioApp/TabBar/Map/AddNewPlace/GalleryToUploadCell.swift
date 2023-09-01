//
//  GalleryToUploadCell.swift
//  TravioApp
//
//  Created by Elif Poyraz on 29.08.2023.
//

import UIKit
import SnapKit
import TinyConstraints

class GalleryToUploadCell: UICollectionViewCell {
    
    lazy var image: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFit
       // img.backgroundColor = .clear
        return img
    }()
    
    private lazy var imgCameraLogo: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFit
        let defaultImg = UIImage(named: "cameraLogo.png")
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

    func configureImage(image:UIImage?){
        guard let imageUW = image else {return}
        self.image.image = imageUW
    }
    
    func setupViews() {
        self.contentView.backgroundColor = CustomColor.White.color
        contentView.addSubview(imgCameraLogo)
        contentView.addSubview(image)
        makeConst()
    }
    
    func makeConst() {
        
        imgCameraLogo.edgesToSuperview(insets: .left(70) + .right(70) + .bottom(70) + .top(70))
        image.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
