//
//  MapVC.swift
//  ContinueAPI
//
//  Created by imrahor on 19.08.2023.
//

import UIKit
import MapKit
import SnapKit

class MapVC: UIViewController, UIGestureRecognizerDelegate, CLLocationManagerDelegate {

    private lazy var mapView: MKMapView = {
        let mp = MKMapView()
        let europeCoordinates = CLLocationCoordinate2D(latitude: 39, longitude: 35)
        let zoomLevel: CLLocationDistance = 2_000_000
        let region = MKCoordinateRegion(center: europeCoordinates, latitudinalMeters: zoomLevel, longitudinalMeters: zoomLevel)
        mp.setRegion(region, animated: true)
        return mp
    }()
    
    private lazy var longPressRecognizer: UILongPressGestureRecognizer = {
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress))
        longPressGesture.minimumPressDuration = 1
        longPressGesture.delegate = self
       
        return longPressGesture
    }()
    
    private lazy var locationManager: CLLocationManager = {
        var lm = CLLocationManager()
        lm.delegate = self
        lm.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        lm.requestWhenInUseAuthorization()
        return lm
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
        cv.contentInset = UIEdgeInsets(top: 0, left: 18, bottom: 0, right: 0)
        return cv
    }()
    
    private var clRegion: CLCircularRegion?
    private var location: CLLocationCoordinate2D? {
        didSet {
            guard let location = location else { return }
            clRegion = CLCircularRegion(center: location, radius: 5_000, identifier: "BilgeAdam")
            guard let clRegion = clRegion else { return }
            locationManager.startMonitoring(for: clRegion)
        }
    }
    
    let addNewPlaceVC = AddNewPlaceVC()
    let viewModel = MapVCViewModel()
    var status: Bool? {
        didSet {
            reloadData()
        }
    }
    
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
        
        locationManager.startUpdatingLocation()
        initVM()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.mapView.showsUserLocation = true
        self.mapView.userTrackingMode = .follow
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
                let clLocation = CLLocationCoordinate2D(latitude: touchMapCoordinate.latitude, longitude: touchMapCoordinate.longitude)
                guard let clRegion = self.clRegion else { return }
                if clRegion.contains(clLocation) == true {
                    guard let placeMark = placemarks?.first else {return}
                    guard let state = placeMark.administrativeArea, let country = placeMark.country  else {return}
                    let countryCity = "\(country), \(state)"
                    let place = PlaceToMap(place: countryCity, latitude: touchMapCoordinate.latitude, longitude: touchMapCoordinate.longitude)
                    self.addNewPlaceVC.addNewPlaceVM.initVM(place: place)
                    
                    self.present(self.addNewPlaceVC, animated: true, completion: nil)
                }
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
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(178)
        }
    }
}

extension MapVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = CGSize(width: 309, height: 178)
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let coordinate = self.viewModel.placesLocation[indexPath.row].coordinate
        let zoomLevel: CLLocationDistance = 5_000
        let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: zoomLevel, longitudinalMeters: zoomLevel)
        mapView.setRegion(region, animated: true)
            
        let vc = DetailVisitsVC()
        vc.placeId = self.viewModel.getPlaceID(at: indexPath.row)
        self.navigationController?.pushViewController(vc, animated: true)
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
        cell.spinner.startAnimating()
        guard let status = status else { return cell }
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
        
        guard let location = location else {
            let turkeyClLocation = CLLocationCoordinate2D(latitude: 38.5, longitude: 34.5)
            location = turkeyClLocation
            return MKAnnotationView()
        }
        if annotation.coordinate.latitude != location.latitude && annotation.coordinate.longitude != location.longitude {
            
            var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "travel")
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "travel")
            guard let annotationView = annotationView else { return MKAnnotationView()}
            annotationView.image = UIImage(named: "locationImage")
            annotationView.frame.size = CGSize(width: 29.93, height: 40)
            
            return annotationView
        }
        return nil
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

extension MapVC {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let userLocation = locations.last {
            
            self.location = userLocation.coordinate
            guard let location = location else { return }
            let region = MKCoordinateRegion(center: location, latitudinalMeters: 1_000_000, longitudinalMeters: 1_000_000)
            mapView.setRegion(region, animated: true)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Konum alınamadı. Hata: \(error.localizedDescription)")
    }
}
