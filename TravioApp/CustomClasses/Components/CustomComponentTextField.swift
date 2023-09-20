//
//  TextView.swift
//  ContactsApp
//
//  Created by Kurumsal on 18.08.2023.
//

import UIKit
import TinyConstraints

class CustomComponentTextField: UIView {
    
    lazy var lbl: UICustomLabel = {
        let l = UICustomLabel(labelType: .customTextFieldHeader())
        l.height(21)
        return l
    }()
    
    lazy var txtField:UICustomTextField = {
        let tf = UICustomTextField()
        let ptext = "developer@bilgeadam.com"
        var placeHolder = NSMutableAttributedString()
        placeHolder = NSMutableAttributedString(string: ptext, attributes: [NSAttributedString.Key.font:CustomFont.PoppinsRegular(12).font])
        placeHolder.addAttribute(NSAttributedString.Key.foregroundColor, value:CustomColor.TravioLightGray.color, range:NSRange(location:0,length:ptext.count))
        tf.attributedPlaceholder = placeHolder
        tf.textColor = CustomColor.TravioLightGray.color
        tf.font = CustomFont.PoppinsRegular(12).font
        tf.leftViewMode = .always
        tf.delegate = self
        return tf
    }()
    
    override func layoutSubviews() {
        self.roundCornersWithShadow([.bottomLeft,.topLeft,.topRight], radius: 18)
    }
    
    init() {
        super.init(frame: .zero)
        self.backgroundColor = CustomColor.White.color
        self.width(342)
        self.height(74)
        addSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addSubviews() {
        self.addSubviews(lbl,txtField)
        setLayout()
    }
    
    func setLayout(){
        lbl.topToSuperview(offset:8)
        lbl.edgesToSuperview(excluding: [.bottom,.top],insets: .left(12) + .right(12))
        
        txtField.topToBottom(of: lbl,offset: 8)
        txtField.edges(to: lbl,excluding: [.bottom,.top],insets: .left(0) + .right(0))
    }
    
    //MARK: function for configure the txtfield placeholder
    func placeHolderConfig(placeHolderText: String = "",font : CustomFont = CustomFont.PoppinsRegular(12), color:CustomColor = CustomColor.TravioLightGray){
        
        var placeHolder = NSMutableAttributedString()
        placeHolder = NSMutableAttributedString(string: placeHolderText, attributes: [NSAttributedString.Key.font:font.font])
        placeHolder.addAttribute(NSAttributedString.Key.foregroundColor, value:color.color, range:NSRange(location:0,length:placeHolderText.count))
        txtField.attributedPlaceholder = placeHolder
    }
    
}
extension CustomComponentTextField:UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {
            textField.textColor = .black
    }
    
}
