//
//  MapVC.swift
//  ContinueAPI
//
//  Created by imrahor on 19.08.2023.
//

import UIKit
import MapKit
import SnapKit

class MapVC: UIViewController, UIGestureRecognizerDelegate {

    private lazy var mapView: MKMapView = {
        let mp = MKMapView()
        return mp
    }()
    
    private lazy var longPressRecognizer: UILongPressGestureRecognizer = {
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress))
        longPressGesture.minimumPressDuration = 1
        longPressGesture.delegate = self
       
        return longPressGesture
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 15
        layout.minimumInteritemSpacing = 15
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.showsVerticalScrollIndicator = false
        cv.showsHorizontalScrollIndicator = false
        cv.delegate = self
        cv.dataSource = self
        cv.register(MapCollectionCell.self, forCellWithReuseIdentifier: "MapCell")
        cv.backgroundColor = .clear
        return cv
    }()
    
    let vc = DetailVisitsVC()
    let addNewPlaceVC = AddNewPlaceVC()
    let viewModel = MapVCViewModel()
    var status: Bool?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addNewPlaceVC.reloadClosureWhenAddNewData = { () in
            self.initVM()
        }
        setupViews()
        initVM()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        initVM()
    }
    
    @objc func handleLongPress(gestureRecognizer: UILongPressGestureRecognizer) {
        if gestureRecognizer.state == .ended {
            return
        }
        else if gestureRecognizer.state == .began {
            
            let touchPoint = gestureRecognizer.location(in: self.mapView)
            
            let touchMapCoordinate =  self.mapView.convert(touchPoint, toCoordinateFrom: mapView)
            
            let geoCoder = CLGeocoder()
            let location = CLLocation(latitude: touchMapCoordinate.latitude, longitude: touchMapCoordinate.longitude)
            
            geoCoder.reverseGeocodeLocation(location) { placemarks, error in
                if let error = error {
                    print("Reverse geocoding error: \(error.localizedDescription)")
                    return
                }
                guard let placeMark = placemarks?.first else {return}
                guard let state = placeMark.administrativeArea, let country = placeMark.country  else {return}
                let countryCity = "\(country), \(state)"
                let place = PlaceToMap(place: countryCity, latitude: touchMapCoordinate.latitude, longitude: touchMapCoordinate.longitude)
                self.addNewPlaceVC.addNewPlaceVM.initVM(place: place)
                
                self.present(self.addNewPlaceVC, animated: true, completion: nil)
               
            }
            
        }
        
    }
    
    func initVM() {
        viewModel.delegate = self
        viewModel.triggerDelegate = self
        viewModel.takeAllPlacesFromService()
        
        mapView.delegate = self
        viewModel.getAllCLLocationsLocation = { _ in
            self.viewModel.addPins(places: self.viewModel.placesLocation, mapView: self.mapView)
        }
        self.mapView.addGestureRecognizer(longPressRecognizer)
        
    }
    
    func setupViews() {
        navigationController?.isNavigationBarHidden = true
        view.addSubview(mapView)
        view.addSubview(collectionView)
        makeConst()
    }
    
    func makeConst() {
        mapView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
        
        collectionView.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset( ((tabBarController?.tabBar.frame.size.height)! * -1) - 18)
            make.leading.equalToSuperview().offset(18)
            make.trailing.equalToSuperview().offset(-18)
            make.height.equalTo(178)
        }
    }
}

extension MapVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = CGSize(width: collectionView.frame.width - 45, height: collectionView.frame.height)
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.mapView.setCenter(self.viewModel.placesLocation[indexPath.row].coordinate, animated: true)
        self.mapView.cameraZoomRange = MKMapView.CameraZoomRange(maxCenterCoordinateDistance: CLLocationDistance(5000))
    
        DispatchQueue.main.async {
            self.vc.configure(placeID: self.viewModel.getPlaceID(at: indexPath.row))
            self.navigationController?.pushViewController(self.vc, animated: true)
        }
    }
}

extension MapVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.getCountOfPlaces()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MapCell", for: indexPath) as? MapCollectionCell else { return UICollectionViewCell() }
        let model = viewModel.getPlace(index: indexPath.row)
        guard let model = model else { return UICollectionViewCell() }
        guard let status = status else { return UICollectionViewCell() }
        cell.configure(place: model, status: status)
        return cell
    }
}

extension MapVC: CollectionViewReloadData {
    func reloadData() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
}

extension MapVC: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "travel")
        annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "travel")
        guard let annotationView = annotationView else { return MKAnnotationView()}
        annotationView.image = UIImage(named: "locationImage")
        annotationView.frame.size = CGSize(width: 29.93, height: 40)
        
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        
        let allLocationsAnnotation = viewModel.locationsOrderingMKPointAnnotation
        
        if let annotation = view.annotation {
            
            if let selectedPinIndex = allLocationsAnnotation.firstIndex(where: { $0.coordinate.latitude == annotation.coordinate.latitude && $0.coordinate.longitude == annotation.coordinate.longitude }) {
                
                let indexPath = IndexPath(item: (selectedPinIndex), section: 0)
                    
                collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            }
        }
    }
}

extension MapVC: TriggerIndicatorProtocol {
    func sendStatusIsLoading(status: Bool) {
        self.status = status
    }
}
