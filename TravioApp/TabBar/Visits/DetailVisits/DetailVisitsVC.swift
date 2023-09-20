//
//  DetailVisitsVC.swift
//  ContinueAPI
//
//  Created by Kurumsal on 22.08.2023.
//

import UIKit
import SnapKit
import Kingfisher
import MapKit

class DetailVisitsVC: UIViewController {
    
    private lazy var backButton: UIButton = {
       let bt = UIButton()
        bt.setImage(UIImage(named: "placeDetailBackButton"),for: .normal)  //?.withRenderingMode(.alwaysTemplate), for: .normal)
        bt.imageView?.contentMode = .scaleAspectFit
        bt.addTarget(self, action: #selector(backVisitVC), for: .touchUpInside)
        return bt
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.isPagingEnabled = true
        cv.showsVerticalScrollIndicator = false
        cv.showsHorizontalScrollIndicator = false
        cv.contentInsetAdjustmentBehavior = .never
        cv.dataSource = self
        cv.delegate = self
        cv.register(DetailVisitsCell.self, forCellWithReuseIdentifier: "DetailCell")
        return cv
    }()
    
    private lazy var pageController: UIPageControl = {
        let control = UIPageControl()
        control.pageIndicatorTintColor = .gray
        control.currentPageIndicatorTintColor = .black
        control.backgroundColor = #colorLiteral(red: 0.9764705882, green: 0.9782040715, blue: 0.9782039523, alpha: 0.8)
        control.frame.size = CGSize(width: 64, height: 24)
        control.layer.cornerRadius = control.frame.size.height / 2
        return control
    }()
    
    private lazy var gradientRectangle: UIImageView = {
       let img = UIImageView()
        img.image = UIImage(named: "gradientRectangle")
        img.contentMode = .scaleAspectFill
        return img
    }()
    
    private lazy var topView: UIView = {
        let content = UIView()
        return content
    }()
    
    private lazy var titleLabel: UILabel = {
       let lbl = UILabel()
        lbl.font = UIFont(name: "Poppins-SemiBold", size: 30)
        lbl.numberOfLines = 0
        lbl.lineBreakMode = .byWordWrapping
        return lbl
    }()
    
    private lazy var dateLabel: UILabel = {
       let lbl = UILabel()
        lbl.font = UIFont(name: "Poppins-Regular", size: 14)
        return lbl
    }()
    
    private lazy var addedUserLabel: UILabel = {
       let lbl = UILabel()
        lbl.font = UIFont(name: "Poppins-Regular", size: 10)
        lbl.textColor = #colorLiteral(red: 0.6642269492, green: 0.6642268896, blue: 0.6642268896, alpha: 1)
        return lbl
    }()
    
    private lazy var addButton: UIButton = {
       let bt = UIButton()
        bt.setImage(UIImage(named: "AddVisit"), for: .normal)
        bt.addTarget(self, action: #selector(postOrDeleteVisit), for: .touchUpInside)
        return bt
    }()
    
    private lazy var mpKit: MKMapView = {
       let mp = MKMapView()
                
       let leftMargin:CGFloat = 10
       let topMargin:CGFloat = 60
       let mapWidth:CGFloat = view.frame.size.width-20
       let mapHeight:CGFloat = 227
       
       mp.frame = CGRect(x: leftMargin, y: topMargin, width: mapWidth, height: mapHeight)
       
       mp.mapType = MKMapType.standard
       mp.isZoomEnabled = true
       mp.isScrollEnabled = true
    return mp
    }()
    
    private lazy var informationLabel: UILabel = {
       let lbl = UILabel()
        lbl.font = UIFont(name: "Poppins-Regular", size: 12)
        lbl.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
        lbl.numberOfLines = 0
        return lbl
    }()
    
    private lazy var scroll: UIScrollView = {
       let scroll = UIScrollView()
        return scroll
    }()
    
    private lazy var content: UIView = {
        let content = UIView()
        return content
    }()
    
    var viewModel: DetailVisitsViewModel?
    var placeId: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let placeId = placeId else { return }
        viewModel = DetailVisitsViewModel(placeId: placeId)
        mpKit.delegate = self
        
        initVM()
        setupViews()
    }

    override func viewDidLayoutSubviews() {
        let height = informationLabel.frame.origin.y + informationLabel.frame.height
        scroll.contentSize = CGSize(width: self.view.frame.width, height: height)
    }
    
    func configure(placeID: String) {
        viewModel = DetailVisitsViewModel(placeId: placeID)
        
    }
    
    func initVM() {
        guard let viewModel = viewModel else { return }
        
        viewModel.getAPlaceById { place in
            let cllocation = CLLocation(latitude: place.latitude, longitude: place.longitude)
            self.addPinandZoomPlace(place: cllocation)
            self.titleLabel.text = place.title
            
            let formattedDate = place.created_at.changeDateFormat()
            self.dateLabel.text = formattedDate
            
            self.addedUserLabel.text = "added by @\(place.creator)"
            self.informationLabel.text = place.description
            self.viewModel?.checkVisitByPlaceID(complete: { result in
                if result {
                    self.addButton.setImage(UIImage(named: "AddVisitFill"), for: .normal)
                } else {
                    self.addButton.setImage(UIImage(named: "AddVisit"), for: .normal)
                }
            })
        }
        
        viewModel.getAllGalleryImages( complete: { () in
            DispatchQueue.main.async {
                self.pageController.currentPage = 0
                self.pageController.numberOfPages = viewModel.galleryImagesDataCount()
                self.collectionView.reloadData()
            }
        })
    }
    
    func addPinandZoomPlace(place: CLLocation) {
        let pin = MKPointAnnotation()
        pin.title = ""
        pin.coordinate = CLLocationCoordinate2D(latitude: place.coordinate.latitude, longitude: place.coordinate.longitude)
        mpKit.addAnnotation(pin)
        mpKit.setCenter(place.coordinate, animated: true)
        mpKit.cameraZoomRange = MKMapView.CameraZoomRange(maxCenterCoordinateDistance: CLLocationDistance(3000))
    }
    
    @objc func postOrDeleteVisit() {
        guard let viewModel = viewModel else { return }
        viewModel.checkVisitByPlaceID(complete: { result in
            if result {
                viewModel.deleteAVisitByPlaceID()
                self.addButton.setImage(UIImage(named: "AddVisit"), for: .normal)
            } else {
                viewModel.postAVisit()
                self.addButton.setImage(UIImage(named: "AddVisitFill"), for: .normal)
            }
        })
    }
    
    @objc func backVisitVC() {
        navigationController?.popViewController(animated: true)
    }
    
    func setupViews() {
        view.backgroundColor = #colorLiteral(red: 0.9782040715, green: 0.9782040715, blue: 0.9782039523, alpha: 1)
        navigationController?.isNavigationBarHidden = true
        
        topView.addSubview(collectionView)
        topView.addSubview(gradientRectangle)
        topView.addSubview(backButton)
        topView.addSubview(addButton)
        view.addSubview(topView)
        view.addSubview(pageController)
        
        content.addSubview(titleLabel)
        content.addSubview(dateLabel)
        content.addSubview(addedUserLabel)
        content.addSubview(mpKit)
        content.addSubview(informationLabel)
        
        scroll.addSubview(content)
        
        view.addSubview(scroll)
        makeConst()
    }

    func makeConst() {
        topView.snp.makeConstraints { make in
            make.top.trailing.leading.equalToSuperview()
            make.height.equalTo(249)
        }
        
        collectionView.snp.makeConstraints { make in
            make.leading.trailing.top.equalToSuperview()
            make.height.equalTo(249)
        }
        
        gradientRectangle.snp.makeConstraints { make in
            make.bottom.equalTo(collectionView.snp.bottom)
            make.trailing.leading.equalToSuperview()
            make.height.equalTo(110)
        }
        
        backButton.snp.makeConstraints { make in
            make.width.equalTo(40)
            make.height.equalTo(40)
            make.top.equalToSuperview().offset(47)
            make.leading.equalToSuperview().offset(24)
        }
        
        pageController.snp.makeConstraints { make in
            make.centerX.equalTo(collectionView.snp.centerX)
            make.bottom.equalTo(topView.snp.bottom).offset(-20)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(content.snp.top).offset(24)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(2)
            make.leading.equalToSuperview().offset(26)
            make.height.equalTo(30)
        }
        
        addedUserLabel.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom)
            make.leading.equalToSuperview().offset(26)
            make.height.equalTo(15)
        }
        
        addButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(42)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(50)
            make.width.equalTo(50)
        }
        
        mpKit.snp.makeConstraints { make in
            make.top.equalTo(addedUserLabel.snp.bottom).offset(6)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(227)
        }
        
        informationLabel.snp.makeConstraints { make in
            make.top.equalTo(mpKit.snp.bottom).offset(24)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalTo(content.snp.bottom)
        }
        
        content.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalTo(view.snp.width)
        }
        
        guard let tabBar = tabBarController else {return}
        scroll.snp.makeConstraints { make in
            make.top.equalTo(collectionView.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().offset(tabBar.tabBar.frame.height * -1)
            make.width.equalTo(view.snp.width)
        }
    }
}

extension DetailVisitsVC: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = collectionView.frame.size
        return size
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
            let pageIndex = round(scrollView.contentOffset.x / scrollView.frame.width)
        pageController.currentPage = Int(pageIndex)
        }
}

extension DetailVisitsVC: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let viewModel = viewModel else { return 0 }
        return viewModel.galleryImagesDataCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DetailCell", for: indexPath) as? DetailVisitsCell else {
            return UICollectionViewCell()
        }
        print(indexPath)
        
        cell.configure(object: viewModel!.returnGalleryImage(row: indexPath.row))
        return cell
    }
}

extension DetailVisitsVC: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "travel")
        annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "travel")
        
        annotationView?.image = UIImage(named: "locationImage")
        annotationView?.frame = CGRect(x: 0, y: 0, width: 29.93, height: 40)
        
        return annotationView
    }
}
