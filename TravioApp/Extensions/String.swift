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
}
