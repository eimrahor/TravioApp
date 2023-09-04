//
//  HomeViewModel.swift
//  TravioApp
//
//  Created by imrahor on 30.08.2023.
//

import Foundation

class HomeViewModel {
    
    var pPlaces: PopularPlaces?
    
    func callPopularPlaces(complete: @escaping ()->()) {
        APIService.call.objectRequestJSON(request: Router.getPopularPlaces) { (result:Result<PopularPlaces,Error>) in
            switch result {
            case .success(let data):
                self.pPlaces = data
                complete()
            case .failure(let err):
                print(err)
            }
        }
    }
    
    func pPlacesCount() -> Int {
        guard let count = pPlaces?.data.places.count else { return 0 }
        return count
    }
    
    func returnpPlace(row: Int) -> Place {
        guard let place = pPlaces?.data.places[row] else { return Place(id: "", creator: "", place: "", title: "", description: "", cover_image_url: "", latitude: 0.0, longitude: 0.0, created_at: "", updated_at: "")}
        return place
    }
}
