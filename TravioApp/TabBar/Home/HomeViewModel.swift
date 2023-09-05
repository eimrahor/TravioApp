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
    
    let params = [
        "limit": "3"
    ]
    
    func callPopularPlaces(complete: @escaping ()->()) {
        APIService.call.objectRequestJSON(request: Router.getPopularPlaces(params: params)) { (result:Result<PopularPlaces,Error>) in
            switch result {
            case .success(let data):
                self.pPlaces = data
                complete()
            case .failure(let err):
                print(err)
            }
        }
    }
    
    func callNewPlaces(complete: @escaping ()->()) {
        APIService.call.objectRequestJSON(request: Router.getLastPlaces(params: params)) { (result:Result<PopularPlaces,Error>) in
            switch result {
            case .success(let data):
                self.nPlaces = data
                complete()
            case .failure(let err):
                print(err)
            }
        }
    }
}
