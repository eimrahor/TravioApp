//
//  StandardViewController.swift
//  TravioApp
//
//  Created by Elif Poyraz on 2.09.2023.
//

import UIKit
import TinyConstraints

class MainViewController: UIViewController {

    var background = BackgroundView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = CustomColor.TravioGreen.color
        setupLayout()
    }
    
    func setupLayout(){
        
        addSubviews()
        background.bottomToSuperview()
        background.height(to: self.view,multiplier: 0.82)
        background.width(to: self.view)
        background.centerXToSuperview()
    }
    
    func addSubviews(){
        self.view.addSubview(background)
    }

}
