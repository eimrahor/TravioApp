//
//  AddNewPlaceVM.swift
//  TravioApp
//
//  Created by Kurumsal on 28.08.2023.
//

import Foundation

class AddNewPlaceVM{
    
    var mapVCdelegate: MapVC?
    
    var cityName: String?
    var countryName: String?
    var latitude: Double?
    var longitude: Double?
    
    func initVM(city:String?,country:String?,latitude:Double?,longitude:Double?){
        if let cityUnWrap = city { cityName = city}
        if let countryUnWrap = country { countryName = country}
        if let latitudeUnWrap = latitude { self.latitude = latitudeUnWrap}
        if let longitudeUnWrap = longitude { self.longitude = longitudeUnWrap}
    }
}
