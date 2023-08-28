//
//  VisitsVC.swift
//  ContinueAPI
//
//  Created by imrahor on 19.08.2023.
//

import UIKit
import SnapKit

class VisitsVC: UIViewController {

    let viewModel = VisitsVCViewModel()
    
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
        tv.register(VisitsVCTableViewCell.self, forCellReuseIdentifier: "VisitsCell")
        return tv
    }()
    
    override func viewDidLayoutSubviews() {
        secondView.roundCorners([.topLeft], radius: 80)
    }
    
    var detailsViewModel: DetailVisitsViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
//        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.viewModel.callListTravels()
        //}
        self.viewModel.keyChainReadClosure = { [unowned self ] in
            print(viewModel.placesArr)
            DispatchQueue.main.async() {
                self.tableView.reloadData()
            }
            
        }

    }
    
    func setupViews() {
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
            make.width.equalTo(view.snp.width)
            make.bottom.equalToSuperview()
        }

        tableView.snp.makeConstraints { make in
            make.top.equalTo(secondView.snp.top).offset(29)
            make.bottom.equalToSuperview()
            make.leading.equalTo(secondView.snp.leading).offset(23)
            make.trailing.equalTo(secondView.snp.trailing).offset(-23)
        }
    }
}

extension VisitsVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 280
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = DetailVisitsVC()
        vc.viewModel = DetailVisitsViewModel(travelId: viewModel.placesArr[indexPath.row].id)
        navigationController?.pushViewController(vc, animated: false)
    }
}

extension VisitsVC: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.placesArr.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "VisitsCell", for: indexPath) as? VisitsVCTableViewCell else { return UITableViewCell() }
        let object = viewModel.placesArr[indexPath.row]
        cell.configure(object: object)
        return cell
    }
}
