//
//  AddNewPlaceVC.swift
//  TravioApp
//
//  Created by Kurumsal on 28.08.2023.
//

import UIKit
import TinyConstraints

class AddNewPlaceVC: UIViewController, UINavigationControllerDelegate {

    var reloadClosureWhenAddNewData: (()->())?
    let addNewPlaceVM = AddNewPlaceVM()
    var selectedCellIndex:IndexPath?
    var imagesToUpload:[UIImage] = []
    
    private lazy var placeNameView: CustomComponentTextField = {
       let tv = CustomComponentTextField()
        tv.lbl.text = "Place Name"
        tv.lbl.textColor = #colorLiteral(red: 0.3058650196, green: 0.30586496, blue: 0.3058649898, alpha: 1)
        tv.placeHolderConfig(placeHolderText: "Please write a place name")
        tv.txtField.addTarget(self, action: #selector(buttonCheckActivate), for: UIControl.Event.editingChanged)
        return tv
    }()
    
    private lazy var visitDescriptionView: CustomComponentTextView = {
       let tv = CustomComponentTextView()
        tv.lbl.text = "Visit Description"
        tv.lbl.textColor = #colorLiteral(red: 0.3058650196, green: 0.30586496, blue: 0.3058649898, alpha: 1)
        tv.placeHolderText = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged."
        return tv
    }()
    
    private lazy var countryView: CustomComponentTextField = {
       let tv = CustomComponentTextField()
        tv.lbl.text = "Country, City"
        tv.lbl.textColor = #colorLiteral(red: 0.3058650196, green: 0.30586496, blue: 0.3058649898, alpha: 1)
        tv.placeHolderConfig(placeHolderText: "France,Paris")
        tv.txtField.addTarget(self, action: #selector(buttonCheckActivate), for: UIControl.Event.editingChanged)
        return tv
    }()
    
    private lazy var collectionViewGallery:UICollectionView = {
       
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.showsVerticalScrollIndicator = false
        cv.showsHorizontalScrollIndicator = false
        cv.delegate = self
        cv.dataSource = self
        cv.register(GalleryToUploadCell.self, forCellWithReuseIdentifier: "UploadCell")
        cv.backgroundColor = .clear
        return cv
        
    }()
    
    private lazy var imagePicker: UIImagePickerController = {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        return picker
    }()
    
    private lazy var btnAddPlace: UICustomButton = {
        let btn = UICustomButton(title: "Add New Place")
        btn.addTarget(self, action: #selector(addNewPlace), for: .touchUpInside)
        btn.isEnabled = false
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
        addNewPlaceVM.requesVMToUpdatePlace = { [weak self] () in
            guard let placeName = self!.placeNameView.txtField.text
                ,let desc = self!.visitDescriptionView.txtView.text, let countryCity = self!.countryView.txtField.text else {return}
            self!.addNewPlaceVM.updateVMPlaceData(placeName: placeName, placeDescription: desc, placeCountryCity: countryCity)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        placeNameView.txtField.text = ""
        visitDescriptionView.txtView.text = ""
        fillLocationDatas()
        imagesToUpload = []
        collectionViewGallery.reloadData()
        
    }
    
    @objc func addNewPlace()
    {
        addNewPlaceVM.sendImagesToServer(selectedImages: imagesToUpload) { result in
            switch result {
            case .failure(let error):
                self.showAlert(title: "Error: While upload images to server", err: error.localizedDescription)
            case .success(_):
                self.addNewPlaceToServerResult()
            }
        }
    }
    
    func addNewPlaceToServerResult() {
        addNewPlaceVM.addNewPlaceToServer() { result in
            switch result {
            case .failure(let err):
                self.showAlert(title: "Error: While add new place to server", err: err.localizedDescription)
            case .success(_):
                self.addGalleryImagesServerResult()
                
            }
        }
    }
    
    func addGalleryImagesServerResult() {
        addNewPlaceVM.addGalleryImagesNewAddedPlace() { result in
            switch result {
            case .failure(let err):
                self.showAlert(title: "Error: While add images to gallery", err: err.localizedDescription)
            case .success(_):
                self.reloadClosureWhenAddNewData?()
                self.dismiss(animated: true)
            }
        }
    }
    
    func showAlert(title: String, err: String) {
        let alert = UIAlertController(title: title, message: err, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "Try again", style: .default)
        let alertActionCancel = UIAlertAction(title: "Cancel", style: .cancel) { _ in
            self.dismiss(animated: true)}
        alert.addAction(alertAction)
        alert.addAction(alertActionCancel)
        alert.present(self, animated: true)
    }
    
    func setupLayout(){
        
        self.view.backgroundColor = CustomColor.TravioWhite.color
        addSubviews()
        
        placeNameView.topToSuperview(offset:40,usingSafeArea: true)
        placeNameView.height(74)
        placeNameView.edgesToSuperview(excluding: [.bottom,.top],insets: .left(24) + .right(24))
        
        visitDescriptionView.topToBottom(of: placeNameView,offset: 16)
        visitDescriptionView.edgesToSuperview(excluding: [.bottom,.top],insets: .left(24) + .right(24))
        visitDescriptionView.height(215)
        
        countryView.topToBottom(of: visitDescriptionView,offset: 16)
        countryView.edgesToSuperview(excluding: [.bottom,.top],insets: .left(24) + .right(24))
        countryView.height(74)
        
        collectionViewGallery.topToBottom(of: countryView,offset: 11)
        collectionViewGallery.height(215)
        collectionViewGallery.edgesToSuperview(excluding: [.bottom , .top] , insets: .left(19) + .right(19))
        
        btnAddPlace.topToBottom(of:collectionViewGallery,offset:16)
        btnAddPlace.edgesToSuperview(excluding: [.top,.bottom] , insets: .left(24) + .right(24))
        btnAddPlace.height(54)
    }
    
    func addSubviews(){
        self.view.addSubview(placeNameView)
        self.view.addSubview(visitDescriptionView)
        self.view.addSubview(countryView)
        self.view.addSubview(collectionViewGallery)
        self.view.addSubview(btnAddPlace)
    }
    
    func fillLocationDatas(){
        
        guard let place = addNewPlaceVM.place else {return}
        guard let countryCity = place.place else {return}

        countryView.txtField.text = countryCity
        countryView.txtField.textColor = CustomColor.TravioBlack.color
    }
    
    @objc func buttonCheckActivate() {
        
        guard let name = placeNameView.txtField.text, let countryCity = countryView.txtField.text  else { return }

        if name.isEmpty || countryCity.isEmpty
        { btnAddPlace.isEnabled = false }
        else{ btnAddPlace.isEnabled = true }
    }
}
extension AddNewPlaceVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = CGSize(width: collectionView.frame.height-5, height: collectionView.frame.height-5)
        return size
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedCellIndex = indexPath
        self.present(imagePicker,animated: true)
    }
}
extension AddNewPlaceVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        3
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UploadCell", for: indexPath) as? GalleryToUploadCell else { return UICollectionViewCell() }
        
        if imagesToUpload.count > indexPath.row { cell.configureImage(image: imagesToUpload[indexPath.row])}
        return cell
    }
}

extension AddNewPlaceVC: UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        addImage(info: info)
        self.dismiss(animated: true)
    }
    
    func addImage(info: [UIImagePickerController.InfoKey : Any]){
        let image = info[.originalImage] as! UIImage
        imagesToUpload.append(image)
        collectionViewGallery.reloadData()
    }
    
}

