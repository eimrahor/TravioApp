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
        self.backgroundColor = CustomColor.TravioWhite.color
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        self.roundCorners( [.topLeft], radius: 80)
    }
    
}
