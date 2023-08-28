//
//  MapKit.swift
//  ContinueAPI
//
//  Created by Kurumsal on 25.08.2023.
//

import Foundation
import MapKit

class MapPin: NSObject, MKAnnotation {
   let title: String?
   let locationName: String
   let coordinate: CLLocationCoordinate2D
init(title: String, locationName: String, coordinate: CLLocationCoordinate2D) {
      self.title = title
      self.locationName = locationName
      self.coordinate = coordinate
   }
}
