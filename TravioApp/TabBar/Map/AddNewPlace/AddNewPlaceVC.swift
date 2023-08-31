//
//  AddNewPlaceVC.swift
//  TravioApp
//
//  Created by Kurumsal on 28.08.2023.
//

import UIKit
import TinyConstraints

class AddNewPlaceVC: UIViewController, UINavigationControllerDelegate {

    let addNewPlaceVM = AddNewPlaceVM()
    var selectedCellIndex:IndexPath?
    
    private lazy var tvPlaceName: UITextView = {
        let tv = UITextView()
        //tv.shadowAndRoundCorners(width: 342)
        tv.text = "blabla"
        return tv
    }()
    private lazy var placeNameView: CustomViewWithTextField = {
       let tv = CustomViewWithTextField()
        tv.lbl.text = "Place Name"
        tv.lbl.textColor = #colorLiteral(red: 0.3058650196, green: 0.30586496, blue: 0.3058649898, alpha: 1)
      // tv.lbl.font = CustomFont.PoppindMedium(14).font
        tv.placeHolderConfig(placeHolderText: "Please write a place name")
        return tv
    }()
    
    private lazy var visitDescriptionView: CustomViewWithTextView = {
       let tv = CustomViewWithTextView()
        tv.lbl.text = "Visit Description"
        tv.lbl.textColor = #colorLiteral(red: 0.3058650196, green: 0.30586496, blue: 0.3058649898, alpha: 1)
        tv.placeHolderText = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged."
      // tv.lbl.font = CustomFont.PoppindMedium(14).font
        return tv
    }()
    
    private lazy var countryView: CustomViewWithTextField = {
       let tv = CustomViewWithTextField()
        tv.lbl.text = "Country, City"
        tv.lbl.textColor = #colorLiteral(red: 0.3058650196, green: 0.30586496, blue: 0.3058649898, alpha: 1)
      // tv.lbl.font = CustomFont.PoppindMedium(14).font
        tv.placeHolderConfig(placeHolderText: "France,Paris")
        return tv
    }()
    
    private lazy var collectionViewGallery:UICollectionView = {
       
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 15
        layout.minimumInteritemSpacing = 15
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
        
        return btn
    }()
 
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(addNewPlaceVM.place?.place)
        print(addNewPlaceVM.place?.latitude)
        print(addNewPlaceVM.place?.longitude)
        
        setupLayout()
        
        addNewPlaceVM.requesVMToUpdatePlace = { [weak self] () in
            guard let placeName = self!.placeNameView.txtField.text
                ,let desc = self!.visitDescriptionView.txtView.text, let countryCity = self!.countryView.txtField.text else {return}
            self!.addNewPlaceVM.updateVMPlaceData(placeName: placeName, placeDescription: desc, placeCountryCity: countryCity)
        }
    }
    
    @objc func addNewPlace()
    {
        var imagesToSend:[UIImage] = []
        var currentIndexPath:IndexPath?
        var currentCell:GalleryToUploadCell?
        
        for index in 0..<collectionViewGallery.numberOfItems(inSection: 0){
            currentIndexPath = [0,index]
            currentCell = collectionViewGallery.cellForItem(at: currentIndexPath!) as! GalleryToUploadCell
            
            if let cellImage = currentCell?.image.image {
                imagesToSend.append(cellImage)
            }
        }
        addNewPlaceVM.sendImagesToServer(selectedImages: imagesToSend)
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
        
        collectionViewGallery.topToBottom(of: countryView,offset: 16)
        collectionViewGallery.height(215)
        collectionViewGallery.edgesToSuperview(excluding: [.bottom , .top] , insets: .left(24) + .right(24))
        
        btnAddPlace.topToBottom(of:collectionViewGallery,offset:16)
        btnAddPlace.edgesToSuperview(excluding: [.top,.bottom] , insets: .left(24) + .right(24))
        btnAddPlace.height(54)
        
        fillLocationDatas()
    }
    
    func addSubviews(){
        self.view.addSubview(placeNameView)
        self.view.addSubview(visitDescriptionView)
        self.view.addSubview(countryView)
        self.view.addSubview(collectionViewGallery)
        self.view.addSubview(btnAddPlace)
    }
    func fillLocationDatas(){
        
        guard let countryCity = addNewPlaceVM.place?.place else {return}

        countryView.txtField.text = countryCity
        countryView.txtField.textColor = CustomColor.TravioBlack.color
    }
    

}
extension AddNewPlaceVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = CGSize(width: collectionView.frame.height, height: collectionView.frame.height)
        return size
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
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UploadCell", for: indexPath) as? GalleryToUploadCell else {return UICollectionViewCell() }
        
        return cell
    }
}

extension AddNewPlaceVC: UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.originalImage] as! UIImage
        let cell = collectionViewGallery.cellForItem(at: selectedCellIndex!) as! GalleryToUploadCell
        cell.configureImage(image: image )
        self.dismiss(animated: true)
    }
    
}

