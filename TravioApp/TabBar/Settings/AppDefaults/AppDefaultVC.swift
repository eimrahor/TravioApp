//
//  AppDefaultVC.swift
//  TravioApp
//
//  Created by Elif Poyraz on 9.09.2023.
//

import UIKit
import TinyConstraints

class AppDefaultVC: MainViewController {

    let appDefaultVM = AppDefaultVM()
    
    // MARK: - Properties
    
    private lazy var lblPageTitle: UICustomLabel = {
        let lbl = UICustomLabel(labelType: .pageNameHeader(text: "App Default"))
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
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Helpers
    
    override func setupLayout() {
        super.setupLayout()
        self.navigationController?.isNavigationBarHidden = true
        
        addSubviews()
        
        svNavigationBar.topToSuperview(offset: 19,usingSafeArea: true)
        svNavigationBar.edgesToSuperview(excluding: [.top,.bottom],insets: .left(20) + .right(20))
        
    }
    
    override func addSubviews() {
        super.addSubviews()
        self.view.addSubview(svNavigationBar)
    }
    
    @objc func goPopView(){
        self.navigationController?.popViewController(animated: true)
    }
}
