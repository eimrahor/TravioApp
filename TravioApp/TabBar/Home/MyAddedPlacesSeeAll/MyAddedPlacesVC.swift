//
//  MyAddedPlacesVC.swift
//  TravioApp
//
//  Created by Kurumsal on 5.09.2023.
//

import UIKit
import SnapKit

class MyAddedPlacesVC: MainViewController {

    private lazy var buttonAtoZ: UIButton = {
        let bt = UIButton()
        bt.setImage(UIImage(named: "AtoZ"), for: .normal)
        return bt
    }()
    
    private lazy var collectionView: UICollectionView = {
       let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 16
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.delegate = self
        cv.dataSource = self
        cv.showsVerticalScrollIndicator = false
        cv.register(MyAddedPlacesCell.self, forCellWithReuseIdentifier: "CollectionCell")
        return cv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
    }
    
    func setupViews() {
        view.addSubview(buttonAtoZ)
        view.addSubview(collectionView)
        makeConst()
    }
    
    func makeConst() {
        buttonAtoZ.snp.makeConstraints { make in
            make.top.equalTo(background.snp.top).offset(24)
            make.trailing.equalToSuperview().offset(-23.13)
            make.width.equalTo(21.87)
            make.height.equalTo(21.88)
        }
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(background.snp.top).offset(70)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
            make.bottom.equalToSuperview()
        }
    }
}

extension MyAddedPlacesVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.size.width - 48, height: 89)
    }
}

extension MyAddedPlacesVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionCell", for: indexPath) as? MyAddedPlacesCell else { return UICollectionViewCell() }
        
        return cell
    }
    
    
}
