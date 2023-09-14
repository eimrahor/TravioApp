//
//  HomeTableViewCell.swift
//  TravioApp
//
//  Created by imrahor on 30.08.2023.
//

import UIKit

class HomeTableViewCell: UITableViewCell {
    
    var delegate:CellDataDelegate?
    
    var visits = [Visit]()
    var places = [Place]()
    var cellPlaceType: ListedPlacesTypes?
    
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
        bt.addTarget(self, action: #selector(seeAll), for: .touchUpInside)
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
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func seeAll(){
        guard let type = cellPlaceType else {return}
        delegate?.sendSeeAllVC(placesType: type)
    }
    
    func reloadCollectionView() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    func configure(placesType:ListedPlacesTypes, places: [Place]? = nil, visits: [Visit]? = nil) {
        
        switch placesType {
        case .newPlaces:
            titleLabel.text = "New Places"
        case .popularPlaces:
            titleLabel.text = "Popular Places"
        case .myAddedPlaces:
            titleLabel.text = "My Added Places"
        }
        
        self.cellPlaceType = placesType
        
        if let places = places {
            self.places = places
        }
        
        if let visits = visits {
            self.places = []
            for visit in visits {
                self.places.append(visit.place)
            }
        }
        
        reloadCollectionView()
    }
    
    func setupViews() {
        
        self.backgroundColor = CustomColor.TravioWhite.color
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
        guard let cell = collectionView.cellForItem(at: indexPath) as? HomeCollectionViewCell else{return}
        cell.holdingPlace
    }
    
    func goToDetailPage(place:Place){
        let detailVC = DetailVisitsVC()
      //  detailVC.
    }
}

extension HomeTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return places.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cvCell", for: indexPath) as? HomeCollectionViewCell else { return UICollectionViewCell() }
        let place = self.places[indexPath.row]
        cell.configure(place: place)
        return cell
    }
}
