//
//  VisitsVCViewModel.swift
//  ContinueAPI
//
//  Created by Kurumsal on 21.08.2023.
//

import Foundation
import Alamofire

class VisitsVCViewModel {
    
    var keyChainReadClosure: (()->Void)?
    var placesArr = [Place]()
    
    init(){
        //guard let headers = self.headers else { return }
        //callListTravels(headers: headers)
    }
    
    func callListTravels() {
        
        APIService.call.objectRequestJSON(request: Router.listPlaces) { (result:Result<ListUserPlacesResponse,Error>) in
            
            switch result {
            case .success(let data):
                self.placesArr = data.data.places
                self.keyChainReadClosure?()
            case .failure(let err):
                print(err)
            }
            
        }
    }
    
    func getCellViewModel( at indexPath: IndexPath ) -> Place {
        return placesArr[indexPath.row]
    }
    
    
}
