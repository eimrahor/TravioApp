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
    var reloadClosure: (()->())?
    var getAllCLLocationsLocation: (([CLLocation])->())?
    
    func takeAllPlacesFromService() {
        APIService.call.objectRequestJSON(request: Router.getAllPlaces) { (result: Result<GetAllPlaces,Error>) in
            switch result {
            case .success(let result):
                self.places = result
                self.delegate?.reloadData()
            case .failure(let err):
                print(err)
                print(err)
            }
        }
    }
    
    func getAllGallerybyPlaceID(id: String, complete: @escaping (GetGalleryImages)->()) {
        APIService.call.objectRequestJSON(request: Router.getAllGalleryImagesWithID(id: id)) { (result:Result<GetGalleryImages,Error>) in
            switch result {
            case .success(let data):
                complete(data)
            case .failure(let err):
                print(err)
            }
        }
    }
    
    func getCountOfPlaces() -> Int {
        guard let places = places else { return 0 }
        return (places.data.count)
    }
    
    func getPlace(index : Int) -> Place? {
        return places?.data.places[index]
    }
    
    func getAllCLLocations() {
        var placesLocation = [CLLocation]()
        places?.data.places.forEach { place in
            placesLocation.append(CLLocation(latitude: place.latitude, longitude: place.longitude))
        }
        getAllCLLocationsLocation?(placesLocation)
    }
}
