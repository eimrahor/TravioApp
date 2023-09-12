//
//  ChangePasswordSettingsCell.swift
//  TravioApp
//
//  Created by Elif Poyraz on 3.09.2023.
//

import UIKit
import TinyConstraints

class ChangePasswordSettingsCell: UITableViewCell {
    
    var textDidChangedClosure:(()->())?
    
    private lazy var view: CustomComponentTextField = {
        let view = CustomComponentTextField()
        view.backgroundColor = CustomColor.White.color
        view.txtField.delegate = self
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLayout()
    {
        self.contentView.backgroundColor = CustomColor.TravioWhite.color
        addSubview()
        view.topToSuperview()
        view.edgesToSuperview(excluding: [.top,.bottom],insets: .left(5) + .right(5))
        view.height(74)
    }
    
    func addSubview(){
        self.contentView.addSubview(view)
    }
    
    func configureCell(cellData:PasswordSettingsData){
        view.lbl.text = cellData.titleText
        view.placeHolderConfig(placeHolderText: cellData.placeHolderText)
    }
    
    func getPasswordText()->String{
        guard let txt = view.txtField.text else {return ""}
        return txt
    }
}
extension ChangePasswordSettingsCell: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        textDidChangedClosure?()
    }
}
