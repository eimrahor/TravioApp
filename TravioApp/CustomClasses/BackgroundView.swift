//
//  BackgroundView.swift
//  ContactsApp
//
//  Created by Kurumsal on 18.08.2023.
//

import UIKit

class BackgroundView: UIView {

    init() {
        super.init(frame: .zero)
        self.layer.cornerRadius = 80
        self.backgroundColor = CustomColor.TravioWhite.color
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
