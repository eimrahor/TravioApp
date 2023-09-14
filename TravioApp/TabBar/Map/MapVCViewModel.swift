//
//  MapVCViewModel.swift
//  ContinueAPI
//
//  Created by Kurumsal on 24.08.2023.
//

import Foundation
import MapKit

protocol sendAllPlacesToMapVC: AnyObject {
    func reloadData()
}

class MapVCViewModel {
    
    weak var delegate: sendAllPlacesToMapVC?
    var places: GetAllPlaces? {
        didSet {
            getAllCLLocations()
        }
    }
    var placesLocation = [CLLocation]()
    var getAllCLLocationsLocation: ((Bool)->())?
    var locationsOrderingMKPointAnnotation = [MKPointAnnotation]()
    
    func takeAllPlacesFromService() {
        APIService.call.objectRequestJSON(request: Router.getAllPlaces) { (result: Result<GetAllPlaces,Error>) in
            switch result {
            case .success(let result):
                self.places = result
                self.delegate?.reloadData()
            case .failure(let err):
                print(err)
            }
        }
    }
    
    func getPlaceID(at row:Int) -> String {
        guard let places = places else { return "" }
        return places.data.places[row].id
    }
    
    func getPlace(index : Int) -> Place? {
        return places?.data.places[index]
    }
    
    func getCountOfPlaces() -> Int {
        guard let places = places else { return 0 }
        return (places.data.count)
    }
    
    func getAllCLLocations() {
        places?.data.places.forEach { place in
            placesLocation.append(CLLocation(latitude: place.latitude, longitude: place.longitude))
        }
        getAllCLLocationsLocation?(true)
    }
    
    func addPins(places: [CLLocation], mapView: MKMapView) {
        places.forEach { place in
            let pin = MKPointAnnotation()
            pin.title = ""
            pin.coordinate = CLLocationCoordinate2D(latitude: place.coordinate.latitude, longitude: place.coordinate.longitude)
            mapView.addAnnotation(pin)
            
            locationsOrderingMKPointAnnotation.append(pin)
        }
    }
}
