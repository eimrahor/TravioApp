//
//  MyAddedPlacesVC.swift
//  TravioApp
//
//  Created by Kurumsal on 5.09.2023.
//

import UIKit
import SnapKit
import TinyConstraints

enum PlacesSortType{
    case AtoZ
    case ZtoA
}

class SeeAllVC: MainViewController {
    
    let seeAllVM = SeeAllVM()
    var listedPlacesType: ListedPlacesTypes?
    
    // MARK: - Properties
    
    private lazy var lblPageTitle: UICustomLabel = {
        let lbl = UICustomLabel(labelType: .pageNameHeader(text: "None"))
        return lbl
    }()
    
    private lazy var btnBack: UICustomButtonBack = {
        let bt = UICustomButtonBack()
        bt.addTarget(self, action: #selector(goPopView), for: .touchUpInside)
        return bt
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
        bt.addTarget(self, action: #selector(sortAtoZ), for: .touchUpInside)
        return bt
    }()
    
    private lazy var buttonSortZtoA: UIButton = {
        let bt = UIButton()
        bt.setImage(UIImage(named: "btn_ZtoA"), for: .normal)
        bt.isHidden = true
        bt.addTarget(self, action: #selector(sortZtoA), for: .touchUpInside)
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
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureVC()
        setupLayout()
        seeAllVM.getPlaces(placesType: listedPlacesType!)
        seeAllVM.reloadData = { self.cvPlaces.reloadData() }
    }
    
    func configureVC(){
        switch listedPlacesType {
        case .popularPlaces:
            lblPageTitle.text = "Popular Places"
        case .newPlaces:
            lblPageTitle.text = "New Places"
        case .myAddedPlaces:
            lblPageTitle.text = "My Added Places"
        case .none:
            return
        }
    }
    
    // MARK: - Selectors
    
    @objc func goPopView(){
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func sortAtoZ(){
        changeSortButton()
        seeAllVM.sortPlaces(by: .AtoZ)
    }
    
    @objc func sortZtoA(){
        changeSortButton()
        seeAllVM.sortPlaces(by: .ZtoA)
    }
    
    func changeSortButton(){
        if buttonSortAtoZ.isHidden {
            buttonSortAtoZ.isHidden = false
            buttonSortZtoA.isHidden = true
        }
        else {
            buttonSortAtoZ.isHidden = true
            buttonSortZtoA.isHidden = false
        }
    }
    
    // MARK: - Helpers
    
    override func setupLayout() {
        super.setupLayout()
        self.navigationController?.isNavigationBarHidden = true
        addSubviews()
        
        svNavigationBar.topToSuperview(offset: 19,usingSafeArea: true)
        svNavigationBar.edgesToSuperview(excluding: [.top,.bottom],insets: .left(20) + .right(20))
        
        buttonSortAtoZ.top(to: background,offset: 24)
        buttonSortAtoZ.trailingToSuperview(offset: 24)
        buttonSortAtoZ.width(21.87)
        buttonSortAtoZ.height(21.88)
        
        buttonSortZtoA.top(to: background,offset: 24)
        buttonSortZtoA.trailingToSuperview(offset: 24)
        buttonSortZtoA.width(21.87)
        buttonSortZtoA.height(21.88)
   
        cvPlaces.topToBottom(of: buttonSortAtoZ,offset: 24.12)
        cvPlaces.edgesToSuperview(excluding: [.top],insets: .left(0) + .right(0) + .bottom(0),usingSafeArea: true)
    }
    
    override func addSubviews() {
        super.addSubviews()
        view.addSubviews(svNavigationBar,buttonSortAtoZ,buttonSortZtoA,cvPlaces)
    }
}

// MARK: - CollectionView Specs

extension SeeAllVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.size.width - 48, height: 89)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? SeeAllCell else{return}
        guard let holdingPlace = cell.currentPlace else{return}
        goToDetailPage(placeID: holdingPlace.id)
    }
    
    func goToDetailPage(placeID:String){
        let targetVC = DetailVisitsVC()
        targetVC.placeId = placeID
        self.navigationController?.pushViewController(targetVC, animated: true)
    }
}

extension SeeAllVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let placesCount = seeAllVM.placesCount else {return 0}
        return placesCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SeeAllCell", for: indexPath) as? SeeAllCell,
              let places = seeAllVM.placesToBeList else { return UICollectionViewCell() }
        
        cell.configureCell(place: places[indexPath.row])
        return cell
    }
}
