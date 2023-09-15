//
//  HomeVC.swift
//  ContinueAPI
//
//  Created by imrahor on 19.08.2023.
//

import UIKit
import SnapKit

enum ListedPlacesTypes{
    case popularPlaces
    case newPlaces
    case myAddedPlaces
}
protocol CellDataDelegate{
    func sendSeeAllVC(placesType: ListedPlacesTypes)
    func sendDetailVC(placeID:String)
}
class HomeVC: UIViewController, CellDataDelegate{

    private lazy var secondView: UIView = {
       let v = UIView()
        v.backgroundColor = CustomColor.TravioWhite.color
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
        tv.backgroundColor = CustomColor.TravioWhite.color
        tv.delegate = self
        tv.dataSource = self
        tv.showsVerticalScrollIndicator = false
        tv.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: (tabBarController?.tabBar.frame.height)! * 2, right: 0)
        tv.register(HomeTableViewCell.self, forCellReuseIdentifier: "HomeCell")
        
        return tv
    }()
    
    lazy var spinner: UIActivityIndicatorView = {
       let s = UIActivityIndicatorView()
        s.hidesWhenStopped = true
        s.style = .large
        s.color = .black
        return s
    }()
    
    let viewModel = HomeViewModel()
    let dGroup = DispatchGroup()
    var pPlaces = [Place]()
    var nPlaces = [Place]()
    var allVisits = [Visit]()
    
    var status: Bool? {
        didSet {
        reloadTableView()
        }
    }
    var statusCv: Bool?
    
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
        viewModel.triggerDelegate = self
        
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
            
        dGroup.enter()
        
        viewModel.callMyVisits { visits in
            self.allVisits = visits
            self.dGroup.leave()
        }
        
        dGroup.notify(queue: .main) {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
    }
    
    func reloadTableView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func setupViews() {
        view.addSubview(secondView)
        view.addSubview(logoImage)
        view.addSubview(titleLabel)
        view.addSubview(tableView)
        view.addSubview(spinner)
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
        
        spinner.snp.makeConstraints { make in
            make.center.equalToSuperview()
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
        cell.delegate = self
        spinner.startAnimating()
        guard let status = status else { self.status = false; return cell }
        spinner.stopAnimating()
        switch indexPath.section {
        case 0:
            DispatchQueue.main.async {
                cell.dataTransferClosure?(self.statusCv)
            }
            cell.configure(placesType: .popularPlaces,places: self.pPlaces)
        case 1:
            DispatchQueue.main.async {
                cell.dataTransferClosure?(self.statusCv)
            }
            cell.configure(placesType: .newPlaces,places: self.nPlaces)
        default:
            DispatchQueue.main.async {
                cell.dataTransferClosure?(self.statusCv)
            }
            cell.configure(placesType: .myAddedPlaces, visits: self.allVisits)
        }
        
        return cell
    }
}
extension HomeVC {
    func sendSeeAllVC(placesType: ListedPlacesTypes) {
        let targetVC = SeeAllVC()
        targetVC.listedPlacesType = placesType
        self.navigationController?.pushViewController(targetVC, animated: true)
    }
    func sendDetailVC(placeID: String) {
        let targetVC = DetailVisitsVC()
        targetVC.configure(placeID: placeID)
        self.navigationController?.pushViewController(targetVC, animated: true)
    }
    
}

extension HomeVC: TriggerIndicatorProtocol {
    func sendStatusIsLoading(status: Bool) {
        self.statusCv = status
        reloadTableView()
    }
}
