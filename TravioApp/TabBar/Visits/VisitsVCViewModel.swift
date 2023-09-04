//
//  VisitsVCViewModel.swift
//  ContinueAPI
//
//  Created by Kurumsal on 21.08.2023.
//

import Foundation
import Alamofire

class VisitsVCViewModel {
    
    var visitsArr = [Visit]()
    
    func callListTravels(complete: @escaping ()->Void) {
        
        APIService.call.objectRequestJSON(request: Router.listVisits) { (result:Result<ListUserVisitsResponse,Error>) in
            
            switch result {
            case .success(let data):
                self.visitsArr = data.data.visits
                complete()
            case .failure(let err):
                print(err)
            }
            
        }
    }
    
    func getCellViewModel( at indexPath: IndexPath ) -> Visit {
        return visitsArr[indexPath.row]
    }
    
    
}
