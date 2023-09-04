//
//  HomeTableViewCell.swift
//  TravioApp
//
//  Created by imrahor on 30.08.2023.
//

import UIKit

class HomeTableViewCell: UITableViewCell {
    
    private lazy var titleLabel: UILabel = {
       let lbl = UILabel()
        lbl.text = "nab"
        lbl.font = UIFont(name: "Poppins-Medium", size: 20)
        lbl.textColor = #colorLiteral(red: 0.3058650196, green: 0.30586496, blue: 0.3058649898, alpha: 1)
        return lbl
    }()
    
    private lazy var seeAllButton: UIButton = {
       let bt = UIButton()
        bt.titleLabel?.font = UIFont(name: "Poppins-Medium", size: 14)
        bt.setTitleColor(#colorLiteral(red: 0.09019607843, green: 0.7529411765, blue: 0.9215686275, alpha: 1), for: .normal)
        bt.setTitle("See All", for: .normal)
        return bt
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 16.4
        layout.scrollDirection = .horizontal
        let c = UICollectionView(frame: .zero, collectionViewLayout: layout)
        c.showsHorizontalScrollIndicator = false
        c.delegate = self
        c.dataSource = self
        c.register(HomeCollectionViewCell.self, forCellWithReuseIdentifier: "cvCell")
        c.backgroundColor = .clear
        return c
    }()
    
    var place: Place?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(title: String, place: Place) {
        titleLabel.text = title
        self.place = place
    }
    
    func setupViews() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(seeAllButton)
        contentView.addSubview(collectionView)
        makeConst()
    }
    
    func makeConst() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.leading.equalToSuperview()
        }
        
        seeAllButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(29)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(21)
            make.width.equalTo(47)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(2)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}

extension HomeTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = CGSize(width: 279.6, height: 178)
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }
}

extension HomeTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cvCell", for: indexPath) as? HomeCollectionViewCell else { return UICollectionViewCell() }
        //guard let place = self.place else { return UICollectionViewCell() }
        //cell.configure(place: place)
        return cell
    }
}
