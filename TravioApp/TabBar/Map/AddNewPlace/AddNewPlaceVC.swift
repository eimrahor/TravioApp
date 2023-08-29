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
   let btnAddPlace = UICustomButton(title: "Add New Place")
 
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(addNewPlaceVM.cityName)
        print(addNewPlaceVM.countryName)
        print(addNewPlaceVM.latitude)
        print(addNewPlaceVM.longitude)
    
        setupLayout()
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
        
        guard let country = addNewPlaceVM.countryName, let city = addNewPlaceVM.cityName else {return}

        let countryCityText = "\(country), \(city)"
        countryView.txtField.text = countryCityText
        countryView.txtField.textColor = CustomColor.TravioBlack.color
    }
    
    func reloadData(){
        DispatchQueue.main.async {
            self.collectionViewGallery.reloadData()
        }
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
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UploadCell", for: indexPath) as? GalleryToUploadCell else { return UICollectionViewCell() }
        return cell
    }
}

extension AddNewPlaceVC: UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.originalImage] as! UIImage
        
       let cell = collectionViewGallery.cellForItem(at: selectedCellIndex!) as! GalleryToUploadCell
        cell.configureImage(image: image )
        
        reloadData()
        self.dismiss(animated: true)
    }
    
}


//import UIKit
//import Alamofire
//
//class ImageUploadViewController: UIViewController {
//
//    @IBAction func uploadButtonTapped(_ sender: UIButton) {
//        let image = UIImage(named: "your_image_name")
//        let parameters: [String: String] = ["key1": "value1", "key2": "value2"]
//        uploadImage(image: image, parameters: parameters)
//    }
//
//    func uploadImage(image: UIImage?, parameters: [String: String]) {
//        guard let image = image else {
//            return
//        }
//
//        let url = "your_upload_url"
//        let imageData = image.jpegData(compressionQuality: 0.6)
//
//        Alamofire.upload(multipartFormData: { multipartFormData in
//            for (key, value) in parameters {
//                multipartFormData.append(value.data(using: .utf8)!, withName: key)
//            }
//
//            if let imageData = imageData {
//                multipartFormData.append(imageData, withName: "image", fileName: "image.jpg", mimeType: "image/jpeg")
//            }
//        }, to: url, method: .post, headers: nil) { result in
//            switch result {
//            case .success(let upload, _, _):
//                upload.responseJSON { response in
//                    // Handle the response
//                    // ...
//                }
//            case .failure(let encodingError):
//                print(encodingError)
//            }
//        }
//    }
//}

