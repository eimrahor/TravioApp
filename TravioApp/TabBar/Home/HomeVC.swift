//
//  HomeVC.swift
//  ContinueAPI
//
//  Created by imrahor on 19.08.2023.
//

import UIKit
import SnapKit

class HomeVC: UIViewController {

    private lazy var secondView: UIView = {
       let v = UIView()
        v.backgroundColor = #colorLiteral(red: 0.9782040715, green: 0.9782040715, blue: 0.9782039523, alpha: 1)
        return v
    }()
    
    private lazy var logoImage: UIImageView = {
       let img = UIImageView()
        img.image = UIImage(named: "travio-logo")
        return img
    }()
    
    private lazy var titleLabel: UILabel = {
       let lbl = UILabel()
        lbl.text = "travio"
        lbl.textColor = .white
        lbl.font = UIFont(name: "Poppins-SemiBold", size: 36)
        return lbl
    }()
    
    private lazy var tableView: UITableView = {
       let tv = UITableView()
        tv.backgroundColor = #colorLiteral(red: 0.9782040715, green: 0.9782040715, blue: 0.9782039523, alpha: 1)
        tv.delegate = self
        tv.dataSource = self
        tv.showsVerticalScrollIndicator = false
        tv.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: (tabBarController?.tabBar.frame.height)! * 2, right: 0)
        tv.register(HomeTableViewCell.self, forCellReuseIdentifier: "HomeCell")
        
        return tv
    }()
    
    let viewModel = HomeViewModel()
    let dGroup = DispatchGroup()
    var pPlaces = [Place]()
    var nPlaces = [Place]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareDataWithDispatch()
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        prepareDataWithDispatch()
    }
    
    override func viewDidLayoutSubviews() {
        secondView.roundCorners([.topLeft], radius: 80)
        tableView.roundCorners([.topLeft], radius: 16)
    }
    func prepareDataWithDispatch() {
        dGroup.enter()
        
        viewModel.callPopularPlaces { places in
            self.pPlaces = places
            self.dGroup.leave()
        }
       
        dGroup.enter()
        
        viewModel.callNewPlaces { places in
            self.nPlaces = places
            self.dGroup.leave()
        }
            
        dGroup.notify(queue: .main) {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
    }
    
    func setupViews() {
        view.addSubview(secondView)
        view.addSubview(logoImage)
        view.addSubview(titleLabel)
        view.addSubview(tableView)
        makeConst()
    }
    
    func makeConst() {
        secondView.snp.makeConstraints { make in
            make.height.equalTo(view.snp.height).multipliedBy(0.82)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        logoImage.snp.makeConstraints { make in
            make.height.equalTo(62)
            make.width.equalTo(66)
            make.bottom.equalTo(secondView.snp.top).offset(-35)
            make.leading.equalToSuperview().offset(16)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(logoImage.snp.trailing).offset(3.11)
            make.centerY.equalTo(logoImage.snp.centerY)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(secondView.snp.top).offset(35)
            make.trailing.equalToSuperview()
            make.leading.equalToSuperview().offset(24)
            make.bottom.equalToSuperview().offset(2 * (tabBarController?.tabBar.frame.height)!)
        }
    }
    
}

extension HomeVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 230
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}

extension HomeVC: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "HomeCell", for: indexPath) as? HomeTableViewCell else { return UITableViewCell() }
        
        switch indexPath.section {
        case 0:
            cell.configure(title: "Popular Places",places: self.pPlaces)
        default:
            cell.configure(title: "New Places",places: self.nPlaces)
        }
        return cell
    }
}
