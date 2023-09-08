//
//  HomeViewModel.swift
//  TravioApp
//
//  Created by imrahor on 30.08.2023.
//

import Foundation

class HomeViewModel {
    
    var pPlaces: PopularPlaces?
    var nPlaces: PopularPlaces?
    var aVisits: ListUserVisitsResponse?
    let params = [
        "limit": "5"
    ]
    
    func callPopularPlaces(complete: @escaping ([Place])->()) {
        DispatchQueue.global(qos: .utility).async {
            APIService.call.objectRequestJSON(request: Router.getPopularPlaces(params: self.params)) { (result:Result<PopularPlaces,Error>) in
                switch result {
                case .success(let data):
                    self.pPlaces = data
                    complete(data.data.places)
                case .failure(let err):
                    print(err)
                }
            }
        }
    }
    
    func callNewPlaces(complete: @escaping ([Place])->()) {
        DispatchQueue.global(qos: .utility).async {
            APIService.call.objectRequestJSON(request: Router.getLastPlaces(params: self.params)) { (result:Result<PopularPlaces,Error>) in
                switch result {
                case .success(let data):
                    self.nPlaces = data
                    complete(data.data.places)
                case .failure(let err):
                    print(err)
                }
            }
        }
    }
    
    func callMyVisits(complete: @escaping ([Visit])->()) {
        DispatchQueue.global(qos: .utility).async {
            APIService.call.objectRequestJSON(request: Router.listVisits) { (result:Result<ListUserVisitsResponse,Error>) in
                switch result {
                case .success(let data):
                    self .aVisits = data
                    complete(data.data.visits)
                case .failure(let err):
                    print(err)
                }
            }
        }
    }
}
