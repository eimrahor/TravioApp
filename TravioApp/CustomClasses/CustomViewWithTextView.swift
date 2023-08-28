//
//  CustomViewWithTextView.swift
//  TravioApp
//
//  Created by Elif Poyraz on 29.08.2023.
//

import UIKit
import TinyConstraints

class CustomViewWithTextView: UIView {

    var placeHolderText:String? {
        didSet{
            txtView.text = placeHolderText
        }
    }
    
    lazy var lbl: UICustomLabel = {
        let l = UICustomLabel()
        l.text = "Email"
        l.textAlignment = .left
        l.textColor = CustomColor.TravioBlack.color
        l.font = CustomFont.PoppinsSemiBold(14).font
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
    
    override func layoutSubviews() {
        self.roundCorners([.bottomLeft,.topRight,.topLeft], radius: 16)
//        let width = self.frame.size.width - 48
//        self.shadowAndRoundCorners(width: width)
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
extension CustomViewWithTextView:UITextViewDelegate {
    
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
