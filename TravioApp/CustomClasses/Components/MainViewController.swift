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
//    var backGroundMultiplier:Float = 0.82{
//        didSet{
//            setupLayout()
//        }
//    }
//    private var backGroundMultiplier:Float = 0.82 -ver2
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
    }
    
    func setupLayout(backGroundMultiplier: CGFloat = 0.82){
        
        self.view.backgroundColor = CustomColor.TravioGreen.color
        addSubviews()
        
        background.bottomToSuperview()
        background.height(to: self.view,multiplier: backGroundMultiplier)
        background.width(to: self.view)
        background.centerXToSuperview()
    }
    
    func addSubviews(){
        self.view.addSubview(background)
    }
//  - ver2
//    func changeBackgroundMultiplier(to Value: Float ){
//        backGroundMultiplier = Value
//        setupLayout()
//    }
}
