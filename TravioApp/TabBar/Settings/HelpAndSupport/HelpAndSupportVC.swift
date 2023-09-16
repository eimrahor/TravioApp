//
//  HelpAndSupportVC.swift
//  TravioApp
//
//  Created by Elif Poyraz on 9.09.2023.
//

import UIKit
import SnapKit
import TinyConstraints

class HelpAndSupportVC: MainViewController {
    
    private lazy var lblPageTitle: UICustomLabel = {
        let lbl = UICustomLabel(labelType: .pageNameHeader(text: "Help&Support"))
        lbl.textAlignment = .left
        return lbl
    }()
    
    private lazy var btnBack: UICustomButtonBack = {
        let bt = UICustomButtonBack()
        bt.addTarget(self, action: #selector(goPopView), for: .touchUpInside)
        return bt
    }()
    private lazy var svNavigationBar: UIStackView = {
        let sv = UIStackView()
        sv.addArrangedSubview(btnBack)
        sv.addArrangedSubview(lblPageTitle)
        sv.alignment = .center
        sv.distribution = .fillProportionally
        sv.spacing = 30
        sv.axis = .horizontal
        return sv
    }()
    
    private lazy var titleLabel: UICustomLabel = {
        let lbl = UICustomLabel(labelType: .customGreenHeaderOfCollectionView(text: "FAQ"))
        return lbl
    }()
    
    private lazy var cvHelpAndSupport: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 12
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.delegate = self
        cv.dataSource = self
        cv.showsVerticalScrollIndicator = false
        cv.backgroundColor = .clear
        cv.register(HelpAndSupportCollectionViewCell.self, forCellWithReuseIdentifier: "HelpCell")
        return cv
    }()
    
    let helpAndSupportVM = HelpAndSupportVM()
    var titleArray: [String]?
    let viewModel = HelpAndSupportVM()
    var heightForRow: CGFloat = 73
    var value: IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initVM()
    }
    
    func initVM() {
        helpAndSupportVM.closure = { titleArr in
            self.titleArray = titleArr
        }
        helpAndSupportVM.takeArray()
    }
    
    override func setupLayout() {
        super.setupLayout()
        self.navigationController?.isNavigationBarHidden = true
        
        addSubviews()
        
        svNavigationBar.topToSuperview(offset: 19,usingSafeArea: true)
        svNavigationBar.edgesToSuperview(excluding: [.top,.bottom],insets: .left(20) + .right(20))
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(background.snp.top).offset(44)
            make.leading.equalTo(24)
        }
        
        cvHelpAndSupport.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview()
        }
    }
    
    override func addSubviews() {
        super.addSubviews()
        self.view.addSubview(svNavigationBar)
        self.view.addSubview(titleLabel)
        self.view.addSubview(cvHelpAndSupport)
    }
    
    @objc func goPopView(){
        self.navigationController?.popViewController(animated: true)
    }
}

extension HelpAndSupportVC: UICollectionViewDelegateFlowLayout {
    
}

extension HelpAndSupportVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch value {
        case indexPath:
            heightForRow = 73
            value = nil
        default:
            heightForRow = 140
            value = indexPath
        }
        cvHelpAndSupport.cellForItem(at: indexPath)
        cvHelpAndSupport.reloadData()
        cvHelpAndSupport.reloadItems(at: [indexPath])
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if value == indexPath {
            return CGSize(width: view.frame.width - 48, height: heightForRow)
        } else {
            return CGSize(width: view.frame.width - 48, height: 70)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HelpCell", for: indexPath) as? HelpAndSupportCollectionViewCell else { return UICollectionViewCell() }
        
        if value == indexPath {
            cell.desclbl.isHidden = false
        } else {
            cell.desclbl.isHidden = true
        }
        
        guard let titleArray = titleArray else { return UICollectionViewCell() }
        cell.configure(title: titleArray[indexPath.row])
        
        return cell
    }
}
