//
//  CustomViewWithTextView.swift
//  TravioApp
//
//  Created by Elif Poyraz on 29.08.2023.
//

import UIKit
import TinyConstraints

class CustomComponentTextView: UIView {

    var placeHolderText:String? {
        didSet{
            txtView.text = placeHolderText
        }
    }
    
    lazy var lbl: UICustomLabel = {
        let l = UICustomLabel(labelType: .customTextViewHeader())
        l.height(21)
        return l
    }()
    
    lazy var txtView:UITextView =
    {
        let tv = UITextView()
        tv.textColor = CustomColor.TravioLightGray.color
        tv.font = CustomFont.PoppinsRegular(12).font
        tv.isScrollEnabled = true
        tv.delegate = self
        tv.text = placeHolderText
        tv.textContainer.maximumNumberOfLines = 100
        tv.textContainer.lineBreakMode = .byWordWrapping
        return tv
    }()
    
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
    
    override func layoutSubviews() {
        //self.shadowAndRoundCorners(width: self.frame.width, height: self.frame.height)
        self.roundCornersWithShadow([.bottomLeft,.topLeft,.topRight], radius: 18)
    }
    
    func addSubviews() {
        
        self.addSubview(lbl)
        self.addSubview(txtView)
        
        setLayout()
    }
    func setLayout(){
        
        lbl.topToSuperview(offset:8)
        lbl.edgesToSuperview(excluding: [.bottom,.top,.right],insets: .left(12))
        
        txtView.topToBottom(of: lbl,offset: 8)
        txtView.edgesToSuperview(excluding: .top,insets: .left(5) + .right(5) + .bottom(5))
    }
}
extension CustomComponentTextView:UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == CustomColor.TravioLightGray.color {
        textView.text = ""
        textView.textColor = .black
        }
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = placeHolderText
            textView.textColor = CustomColor.TravioLightGray.color
        }
    }
}
