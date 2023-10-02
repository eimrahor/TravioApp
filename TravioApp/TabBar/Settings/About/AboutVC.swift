//
//  AboutVC.swift
//  TravioApp
//
//  Created by Elif Poyraz on 9.09.2023.
//

import UIKit
import TinyConstraints
import SnapKit

class AboutVC: MainViewController {

    let aboutVM = AboutVM()
    
    // MARK: - Properties
    
    private lazy var lblPageTitle: UICustomLabel = {
        let lbl = UICustomLabel(labelType: .pageNameHeader(text: "About Us"))
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
    
    private lazy var wView: UIView = {
        let v = UIView()
        return v
    }()
    
    let webController = WebViewController()
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webController.url = Links.about
        addChild(webController)
        
        let childView = webController.view
        guard let childView = childView else { return }
        childView.frame = CGRect(x: 0, y: 0, width: view.frame.size.width - 8, height: view.frame.size.height - 185 - (tabBarController?.tabBar.frame.size.height)!)
        wView.addSubview(childView)
        webController.didMove(toParent: self)
    }
    
    // MARK: - Helpers
    
    override func setupLayout() {
        super.setupLayout()
        self.navigationController?.isNavigationBarHidden = true
        
        addSubviews()
        
        svNavigationBar.topToSuperview(offset: 19,usingSafeArea: true)
        svNavigationBar.edgesToSuperview(excluding: [.top,.bottom],insets: .left(20) + .right(20))
        
        wView.snp.makeConstraints { make in
            make.top.equalTo(background.snp.top).offset(60)
            make.leading.equalToSuperview().offset(4)
            make.trailing.equalToSuperview().offset(-4)
            make.bottom.equalToSuperview()
        }
    }
    
    override func addSubviews() {
        super.addSubviews()
        self.view.addSubview(svNavigationBar)
        self.view.addSubview(wView)
    }
    
    @objc func goPopView(){
        self.navigationController?.popViewController(animated: true)
    }

}
