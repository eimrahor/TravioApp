//
//  CustomComponentSwitch.swift
//  TravioApp
//
//  Created by Elif Poyraz on 3.09.2023.
//

import UIKit
import TinyConstraints

class CustomComponentSwitch: UIView {

    lazy var lbl: UICustomLabel = {
        let l = UICustomLabel(labelType: .customTextViewHeader())
        return l
    }()
    
    lazy var switchControl:UISwitch = {
        let s = UISwitch()
        s.onTintColor = .green
        return s
    }()
    
    private lazy var  stackView: UIStackView = {
        let sv = UIStackView()
        sv.addArrangedSubview(lbl)
        sv.addArrangedSubview(switchControl)
        sv.distribution = .fillProportionally
        sv.alignment = .center
        sv.axis = .horizontal
        return sv
    }()
    
    override func layoutSubviews() {
        self.roundCornersWithShadow([.bottomLeft,.topLeft,.topRight], radius: 18)
    }
    
    init() {
        super.init(frame: .zero)
        self.backgroundColor = CustomColor.White.color
        self.width(342)
        self.height(215)
        addSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addSubviews() {
        self.addSubview(stackView)
        setLayout()
    }
    
    func setLayout(){
        
        stackView.centerYToSuperview()
        stackView.edgesToSuperview(excluding: [.bottom,.top],insets: .left(16) + .right(16))
        
        lbl.height(21)
        lbl.centerYToSuperview()
        lbl.edgesToSuperview(excluding: [.bottom,.top,.right],insets: .left(0))
        
        switchControl.height(31)
        switchControl.width(70)
        switchControl.centerYToSuperview()
        switchControl.edgesToSuperview(excluding: [.bottom,.top,.left],insets: .right(0))
    }
    
}
