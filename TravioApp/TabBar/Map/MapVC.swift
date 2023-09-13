//
//  MapVC.swift
//  ContinueAPI
//
//  Created by imrahor on 19.08.2023.
//

import UIKit
import MapKit
import SnapKit
import SwiftUI

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
    var locationsOrdering = [CLLocation]()
    
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
    
    func addPins(places: [CLLocation]) {
        places.forEach { place in
            let pin = MKPointAnnotation()
            pin.title = ""
            pin.coordinate = CLLocationCoordinate2D(latitude: place.coordinate.latitude, longitude: place.coordinate.longitude)
            mapView.addAnnotation(pin)
        }
    }
    
    func initVM() {
        viewModel.delegate = self
        viewModel.takeAllPlacesFromService()
        
        mapView.delegate = self
        viewModel.getAllCLLocationsLocation = { allPlaces in
            self.locationsOrdering = allPlaces
            self.addPins(places: allPlaces)
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
        self.mapView.setCenter(self.locationsOrdering[indexPath.row].coordinate, animated: true)
        self.mapView.cameraZoomRange = MKMapView.CameraZoomRange(maxCenterCoordinateDistance: CLLocationDistance(5000))
        
        
        guard let places = self.viewModel.places else { return }
        
        DispatchQueue.main.async {
            self.vc.configure(placeID: places.data.places[indexPath.row].id)
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
        cell.configure(place: model)
        return cell
    }
}

extension MapVC: sendAllPlacesToMapVC {
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
        
        annotationView?.image = UIImage(named: "locationImage")
        annotationView?.frame.size = CGSize(width: 29.93, height: 40)
        
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        guard let annotation = view.annotation else { return }
    }
}
