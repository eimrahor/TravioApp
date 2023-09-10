//
//  HelpAndSupportVC.swift
//  TravioApp
//
//  Created by Elif Poyraz on 9.09.2023.
//

import UIKit
import SnapKit
import TinyConstraints

protocol CellChange {
    func changeCell(value: CGFloat, tvRowHeight: CGFloat)
    func reloadTableView()
}

class HelpAndSupportVC: MainViewController, CellChange {
    func changeCell(value: CGFloat, tvRowHeight: CGFloat) {
        dynamicRowHeight = value
        self.tvRowHeight = tvRowHeight
    }
    
    func reloadTableView() {
        tvHelpAndSupport.reloadData()      
    }
    

    let helpAndSupportVM = HelpAndSupportVM()
    
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
    
    private lazy var tvHelpAndSupport: UITableView = {
        let tv = UITableView(frame: .zero, style: .grouped)
        tv.delegate = self
        tv.dataSource = self
        tv.backgroundColor = .clear
        tv.showsVerticalScrollIndicator = false
        tv.estimatedRowHeight = 100
        tv.rowHeight = UITableView.automaticDimension
        tv.register(HelpAndSupportTableViewCell.self, forCellReuseIdentifier: "HelpCell")
        return tv
    }()
    
    var tvRowHeight: CGFloat?
    var dynamicRowHeight: CGFloat?
    var titleArray: [String]?
    let viewModel = HelpAndSupportVM()
    let viewCell = HelpAndSupportTableViewCell()
    var value: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        tvHelpAndSupport.rowHeight = UITableView.automaticDimension
        tvHelpAndSupport.estimatedRowHeight = 152
    }
    
    override func setupLayout(backGroundMultiplier: CGFloat = 0.82) {
        super.setupLayout(backGroundMultiplier: backGroundMultiplier)
        self.navigationController?.isNavigationBarHidden = true
        
        addSubviews()
        
        svNavigationBar.topToSuperview(offset: 19,usingSafeArea: true)
        svNavigationBar.edgesToSuperview(excluding: [.top,.bottom],insets: .left(20) + .right(20))
        
        tvHelpAndSupport.snp.makeConstraints { make in
            make.top.equalTo(background.snp.top).offset(44)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview()
        }
    }
    
    override func addSubviews() {
        super.addSubviews()
        self.view.addSubview(svNavigationBar)
        self.view.addSubview(tvHelpAndSupport)
    }
    
    @objc func goPopView(){
        self.navigationController?.popViewController(animated: true)
    }
}

extension HelpAndSupportVC: SendDataDelegate {
    func sendDatatoVC(titleArr: [String]) {
        self.titleArray = titleArr
    }
}

extension HelpAndSupportVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == value {
            guard let dynamicRowHeight = dynamicRowHeight else { return 82 }
                return dynamicRowHeight
            } else {
                guard let tvRowHeight = tvRowHeight else { return 73 }
                return tvRowHeight
            }
        
        guard let dynamicRowHeight = dynamicRowHeight else { return 82 }
        return dynamicRowHeight
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 36
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "FAQ"
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int){
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = UIColor.black
        header.textLabel?.font = CustomFont.PoppinsSemiBold(24).font
        header.textLabel?.textColor = CustomColor.TravioGreen.color
    }
}

extension HelpAndSupportVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        value = indexPath.row
        tvHelpAndSupport.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "HelpCell", for: indexPath) as? HelpAndSupportTableViewCell else { return UITableViewCell()}
        cell.delegate = self 
        cell.isExpanded = false
        cell.downButton.tag = indexPath.row
        return cell
    }
}
