//
//  String.swift
//  TravioApp
//
//  Created by imrahor on 3.09.2023.
//

import Foundation


extension String {
    func returnSpecialStringText() -> String {
        let array = self.components(separatedBy: ", ")
        return array[array.count - 1]
    }
    func changeDateFormat() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
        let theDate = dateFormatter.date(from: self)!
        let newDateFormater = DateFormatter()
        newDateFormater.dateFormat = "dd MMMM yyyy"
        return newDateFormater.string(from: theDate)
    }
}
