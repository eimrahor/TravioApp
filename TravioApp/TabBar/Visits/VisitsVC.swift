//
//  VisitsVC.swift
//  ContinueAPI
//
//  Created by imrahor on 19.08.2023.
//

import UIKit
import SnapKit

class VisitsVC: UIViewController {

    // MARK: - Properties
    
    private lazy var titleVisits: UILabel = {
       let lbl = UILabel()
        lbl.text = "My Visits"
        lbl.font = UIFont(name: "Poppins-SemiBold", size: 36)
        lbl.textColor = .white
        return lbl
    }()
    
    private lazy var secondView: UIView = {
       let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.9782040715, green: 0.9782040715, blue: 0.9782039523, alpha: 1)
        return view
    }()
    
    private lazy var tableView: UITableView = {
       let tv = UITableView()
        tv.backgroundColor = #colorLiteral(red: 0.9782040715, green: 0.9782040715, blue: 0.9782039523, alpha: 1)
        tv.delegate = self
        tv.dataSource = self
        tv.showsVerticalScrollIndicator = false
        tv.register(VisitsVCTableViewCell.self, forCellReuseIdentifier: "VisitsCell")
        return tv
    }()
    
    let viewModel = VisitsVCViewModel()
    var status: Bool? {
        didSet {
            reloadData()
        }
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        initVM()
    }
    
    override func viewDidLayoutSubviews() {
        secondView.roundCorners([.topLeft], radius: 80)
    }
    
    func initVM() {
        self.viewModel.triggerDelegate = self
        self.viewModel.callListTravels() { [weak self] in
            self!.reloadData()
        }
    }
    
    func reloadData() {
        DispatchQueue.main.async() {
            self.tableView.reloadData()
        }
    }
    
    // MARK: - Helpers
    
    func setupViews() {
        navigationController?.navigationBar.isHidden = true
        
        view.addSubview(titleVisits)
        view.addSubview(secondView)
        view.addSubview(tableView)
        makeConst()
    }
    
    func makeConst() {
        
        titleVisits.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(24)
            make.leading.equalToSuperview().offset(24)
        }
        
        secondView.snp.makeConstraints { make in
            make.height.equalTo(view.snp.height).multipliedBy(0.82)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }

        tableView.snp.makeConstraints { make in
            make.top.equalTo(secondView.snp.top).offset(29)
            make.bottom.equalToSuperview()
            make.centerX.equalTo(view.snp.centerX)
            make.width.equalTo(354)
        }
    }
}

// MARK: - TableView Specs

extension VisitsVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 235
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailVisitsVC()
        vc.placeId = viewModel.visitsArr[indexPath.row].place_id 
        navigationController?.pushViewController(vc, animated: false)
    }
}

extension VisitsVC: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.visitsArr.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "VisitsCell", for: indexPath) as? VisitsVCTableViewCell else { return UITableViewCell() }
        let object = viewModel.visitsArr[indexPath.row]
        cell.spinner.startAnimating()
        guard let status = status else { return cell }
        cell.configure(object: object, status: status)
        return cell
    }
}

// MARK: Indicator

extension VisitsVC: TriggerIndicatorProtocol {
    func sendStatusIsLoading(status: Bool) {
        self.status = status
    }
}
