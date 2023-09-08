//
//  SeeAllVM.swift
//  TravioApp
//
//  Created by Elif Poyraz on 6.09.2023.
//

import Foundation

class SeeAllVM{
    
    var reloadData: (()->Void)?
    var placesCount:Int?
    
    var placesToBeList:[Place]? {
        didSet {
            guard let reloadData = reloadData , let placesToBeList = placesToBeList else {return}
            reloadData()
            placesCount = placesToBeList.count
        }
    }
    
    func getPlaces(placesType:ListedPlacesTypes) {
        
        switch placesType {
            
        case .popularPlaces:
            APIService.call.objectRequestJSON(request: Router.getAllPopularPlaces){ (result:Result<PopularPlaces,Error>) in
                
                switch result {
                case .success(let places):
                    self.placesToBeList = places.data.places
                case .failure(let error):
                    print(error)
                }
            }
        case .newPlaces:
            APIService.call.objectRequestJSON(request: Router.getAllLastPlaces){ (result:Result<PopularPlaces,Error>) in
                
                switch result {
                case .success(let places):
                    self.placesToBeList = places.data.places
                case .failure(let error):
                    print(error)
                }
            }
        case .myAddedPlaces:
            APIService.call.objectRequestJSON(request: Router.listVisits){ (result:Result<ListUserVisitsResponse,Error>) in
                
                switch result {
                case .success(let visits):
                    var visitsToBeList = [Place]()
                    for visit in visits.data.visits { 
                        visitsToBeList.append(visit.place)
                    }
                    self.placesToBeList = visitsToBeList
                    
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
    func sortPlaces(by sortType: PlacesSortType){
        
        guard var placesToBeList = placesToBeList else {return}
        
        switch sortType {
        case .AtoZ:
            placesToBeList.sort(by: { $0.title <  $1.title})
            self.placesToBeList = placesToBeList
        case .ZtoA:
            placesToBeList.sort(by: { $0.title >  $1.title})
            self.placesToBeList = placesToBeList
        }
    }
    
}
