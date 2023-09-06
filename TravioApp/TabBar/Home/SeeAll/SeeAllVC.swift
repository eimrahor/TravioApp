//
//  MyAddedPlacesVC.swift
//  TravioApp
//
//  Created by Kurumsal on 5.09.2023.
//

import UIKit
import SnapKit
import TinyConstraints

class SeeAllVC: MainViewController {

    private lazy var lblPageTitle: UICustomLabel = {
        let lbl = UICustomLabel(labelType: .pageNameHeader(text: "Popular Places"))
        return lbl
    }()
    
    private lazy var btnBack : UICustomButton = {
        let btn = UICustomButton(title: "")
        let iv = UIImageView()
        iv.image = UIImage(named: "backArrow.png")
        iv.contentMode = .scaleAspectFit
        btn.addSubview(iv)
        iv.height(22);iv.width(24);btn.height(22);btn.width(24)
        btn.addTarget(self, action: #selector(goPopView), for: .touchUpInside)
        return btn
    }()
    private lazy var svNavigationBar: UIStackView = {
        let sv = UIStackView()
        sv.addArrangedSubview(btnBack)
        sv.addArrangedSubview(lblPageTitle)
        sv.alignment = .center
        sv.distribution = .fillProportionally
        sv.spacing = 8
        sv.axis = .horizontal
        return sv
    }()
    
    private lazy var buttonSortAtoZ: UIButton = {
        let bt = UIButton()
        bt.setImage(UIImage(named: "btn_AtoZ"), for: .normal)
        return bt
    }()
    private lazy var buttonSortZtoA: UIButton = {
        let bt = UIButton()
        bt.setImage(UIImage(named: "btn_ZtoA"), for: .normal)
        return bt
    }()
    
    private lazy var cvPlaces: UICollectionView = {
       let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 16
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 4, left: 24, bottom: 4, right: 24)
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        cv.delegate = self
        cv.dataSource = self
        cv.showsVerticalScrollIndicator = false
        cv.register(SeeAllCell.self, forCellWithReuseIdentifier: "SeeAllCell")
        return cv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
    }
    
    override func setupLayout(backGroundMultiplier: CGFloat = 0.82) {
        
        super.setupLayout(backGroundMultiplier: backGroundMultiplier)
        self.navigationController?.isNavigationBarHidden = true
        addSubviews()
        
        svNavigationBar.topToSuperview(offset: 19,usingSafeArea: true)
        svNavigationBar.edgesToSuperview(excluding: [.top,.bottom],insets: .left(20) + .right(20))
        
        buttonSortAtoZ.top(to: background,offset: 24)
        buttonSortAtoZ.trailingToSuperview(offset: 24)
        buttonSortAtoZ.width(21.87)
        buttonSortAtoZ.height(21.88)
   
        cvPlaces.topToBottom(of: buttonSortAtoZ,offset: 24.12)
        cvPlaces.edgesToSuperview(excluding: [.top],insets: .left(0) + .right(0) + .bottom(0),usingSafeArea: true)
    }
    
    override func addSubviews() {
        super.addSubviews()
        view.addSubview(svNavigationBar)
        view.addSubview(buttonSortAtoZ)
        view.addSubview(cvPlaces)
    }
    
    @objc func goPopView(){
        self.navigationController?.popViewController(animated: true)
    }
    
    
}

extension SeeAllVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.size.width - 48, height: 89)
    }
}

extension SeeAllVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SeeAllCell", for: indexPath) as? SeeAllCell else { return UICollectionViewCell() }
        
        return cell
    }
    
    
}
