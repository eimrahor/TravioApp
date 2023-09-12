//
//  UICustomButtonBack.swift
//  TravioApp
//
//  Created by imrahor on 10.09.2023.
//

import UIKit
import Foundation
import TinyConstraints

class UICustomButtonBack: UIButton {
    
    init() {
        super.init(frame: .zero)
        self.height(21.39)
        self.width(24)
        let iv = UIImageView()
        iv.image = UIImage(named: "backArrow")
        iv.height(21.39)
        iv.width(24)
        self.addSubviews(iv)
        iv.center(in: self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
