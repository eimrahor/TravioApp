//
//  UICustomLabel.swift
//  ContactsApp
//
//  Created by Elif Poyraz on 13.08.2023.
//

import UIKit

class UICustomLabel: UILabel {

    init()
    {
        super.init(frame: .zero)
        self.textColor = CustomColor.Black.color
        self.text = "Temp Text"
        self.textAlignment = .center
        self.font = CustomFont.PoppindMedium(24).font
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
