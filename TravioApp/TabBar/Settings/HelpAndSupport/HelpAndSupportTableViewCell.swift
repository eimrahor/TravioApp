//
//  HelpAndSupportTableViewCell.swift
//  TravioApp
//
//  Created by imrahor on 10.09.2023.
//

import UIKit
import SnapKit
import TinyConstraints

class HelpAndSupportTableViewCell: UITableViewCell {

    private lazy var lbl: UICustomLabel = {
        let l = UICustomLabel(labelType: .customTextFieldHeader(text: "Deneme"))
        l.height(21)

        return l
    }()
    
    private lazy var desclbl: UICustomLabel = {
        let l = UICustomLabel(labelType: .customTextViewDescription(text: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book."))
        l.numberOfLines = 0
        l.lineBreakMode = .byWordWrapping
        l.height(75)
        return l
    }()
    
    lazy var downButton: UIButton = {
       let bt = UIButton()
        bt.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        bt.imageView?.contentMode = .scaleAspectFill
        bt.imageView?.tintColor = CustomColor.TravioGreen.color
        bt.addTarget(self, action: #selector(expandButtonTapped), for: .touchUpInside)
        return bt
    }()
    
    private lazy var view: UIView = {
       let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    var delegate: CellChange?
    
    var isExpanded = false {
            didSet {
                let height = lbl.frame.size.height + 28 + desclbl.frame.size.height + 32
                if isExpanded {
                    desclbl.isHidden = false
                    view.snp.makeConstraints { make in
                        make.height.equalTo(height)
                    }
                    delegate?.changeCell(value: 140 + 12, tvRowHeight: height + 12)
                    layoutIfNeeded()
                } else {
                    // Hücrenin büyüklüğünü güncellemek için layoutIfNeeded() çağrısını yapın
                    UIView.animate(withDuration: 0.3) { [self] in
                        desclbl.isHidden = true
                        view.snp.makeConstraints { make in
                            make.height.equalTo(height)
                        }
                        
                        let tvHeight = height + 12
                        delegate?.changeCell(value: height, tvRowHeight: height + 12)
                        layoutIfNeeded()
                    }
                    
                    
                }
            }
        }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .clear
        desclbl.isHidden = true
        setupViews()
    }
    
    override func layoutSubviews() {
        view.roundCornersWithShadow([.topLeft,.topRight,.bottomLeft], radius: 16)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func expandButtonTapped() {
            self.isExpanded.toggle()
        }
    
    func setupViews() {
        view.addSubview(lbl)
        view.addSubview(desclbl)
        view.addSubview(downButton)
        contentView.addSubview(view)
        makeConst()
    }
    
    func makeConst() {
        lbl.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.equalToSuperview().offset(12)
            make.trailing.equalToSuperview().offset(-46)
        }
        
        desclbl.snp.makeConstraints { make in
            make.top.equalTo(lbl.snp.bottom).offset(12)
            make.leading.equalToSuperview().offset(12)
            make.trailing.equalToSuperview().offset(-15)
            make.bottom.equalTo(-16)
        }
        
        downButton.snp.makeConstraints { make in
            make.width.equalTo(10.41)
            make.height.equalTo(15.63)
            make.top.equalToSuperview().offset(19)
            make.trailing.equalToSuperview().offset(-30.59)
        }
        
        view.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().offset(4)
            make.trailing.equalToSuperview().offset(-4)
            make.height.equalTo(140)
        }
        
    }
}
