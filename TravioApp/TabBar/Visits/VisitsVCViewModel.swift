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
    var visitsArr = [Visit]()
    
    init(){
        //guard let headers = self.headers else { return }
        //callListTravels(headers: headers)
    }
    
    func callListTravels() {
        
        APIService.call.objectRequestJSON(request: Router.listVisits) { (result:Result<ListUserVisitsResponse,Error>) in
            
            switch result {
            case .success(let data):
                self.visitsArr = data.data.visits
                self.keyChainReadClosure?()
            case .failure(let err):
                print(err)
            }
            
        }
    }
    
    func getCellViewModel( at indexPath: IndexPath ) -> Visit {
        return visitsArr[indexPath.row]
    }
    
    
}
