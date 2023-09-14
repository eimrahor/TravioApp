//
//  CameraVC.swift
//  TravioApp
//
//  Created by Elif Poyraz on 13.09.2023.
//

import UIKit
import AVFoundation
import TinyConstraints
protocol CameraTransferData{
    func transferImage(image:UIImage)
}

class CameraVC: UIViewController {
    
    private let captureSession = AVCaptureSession()
    private var currentCamera: AVCaptureDevice?
    private var frontCamera: AVCaptureDevice?
    private var backCamera: AVCaptureDevice?
    private var photoOutput = AVCapturePhotoOutput()
    private var cameraPreviewLayer = AVCaptureVideoPreviewLayer()
    private var canTakePhoto = true
    
    var CameraTrandferDataDelegate:CameraTransferData?
    
    private lazy var btnTakePhoto: UIButton = {
        let bt = UIButton()
        bt.addTarget(self, action: #selector(takeAPhoto), for: .touchUpInside)
        bt.height(60); bt.width(60)
        let iv = UIImageView()
        iv.height(60); iv.width(60)
        iv.image = UIImage(systemName: "circle.fill")
        iv.tintColor = CustomColor.White.color
        bt.addSubview(iv)
        iv.center(in: bt)
        return bt
    }()
    
    private lazy var imgPreview:UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    private lazy var btnCross: UIButton = {
        let bt = UIButton()
        bt.setTitle("DISMISS", for: .normal)
        bt.backgroundColor = .clear
        bt.titleLabel?.font = CustomFont.PoppinsSemiBold(16).font
        bt.addTarget(self, action: #selector(throwAwayPhoto ), for: .touchUpInside)
        return bt
    }()
    
    private lazy var btnChoose: UIButton = {
        let bt = UIButton()
        bt.setTitle("ADD", for: .normal)
        bt.backgroundColor = .clear
        bt.titleLabel?.font = CustomFont.PoppinsSemiBold(16).font
        bt.addTarget(self, action: #selector(choosePhoto), for: .touchUpInside)
        return bt
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showCamera()
        setupLayout()
    }
    @objc func throwAwayPhoto(){
        imgPreview.image = nil
        canTakePhoto = true
    }
    @objc func choosePhoto(){
        guard let image = imgPreview.image else {return}
        CameraTrandferDataDelegate?.transferImage(image: image)
        self.navigationController?.popViewController(animated: true)
    }
    @objc func takeAPhoto(){

        guard canTakePhoto else {return}
        
        let photoSettings = AVCapturePhotoSettings()
        photoSettings.flashMode = .off
        let screenWidth = UIScreen.main.bounds.width
        let screenHeight = UIScreen.main.bounds.height
        let pbpf = photoSettings.availablePreviewPhotoPixelFormatTypes[0]
        
        photoSettings.previewPhotoFormat = [
            kCVPixelBufferPixelFormatTypeKey as String: kCVPixelFormatType_32BGRA,
            kCVPixelBufferWidthKey as String: screenWidth,
            kCVPixelBufferHeightKey as String: screenHeight
        ]
        photoOutput.capturePhoto(with: photoSettings, delegate: self) //
        canTakePhoto = false
    }
    
    func setupLayout(){
        
        self.view.backgroundColor = CustomColor.Black.color
        addSubviews()
        imgPreview.edgesToSuperview()
        btnTakePhoto.bottomToSuperview(offset: -80)

        btnTakePhoto.centerXToSuperview()
        btnCross.trailingToLeading(of: btnTakePhoto,offset: -50)
        btnCross.bottomToSuperview(offset: -90)
        
        btnChoose.leadingToTrailing(of: btnTakePhoto,offset: 50)
        btnChoose.bottomToSuperview(offset: -90)

    }
    func addSubviews(){
        self.view.addSubviews(btnCross,btnTakePhoto,btnChoose,imgPreview)
    }
    
    func showCamera() {
        setupCaptureSession()
        setupDevice()
        setupInputOutput()
        setupPreviewLayer()
        startRunningCaptureSession()
    }
    
    func setupCaptureSession() {
        captureSession.sessionPreset = AVCaptureSession.Preset.photo
    }
    
    func setupDevice() {
        let deviceDiscoverySession = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera], mediaType: .video, position: .unspecified)
        let devices = deviceDiscoverySession.devices
        
        for device in devices {
            if device.position == .front {
                frontCamera = device
            } else if device.position == .back {
                backCamera = device
            }
        }
        currentCamera = frontCamera
    }
    
    func setupInputOutput() {
            do {
                let captureDeviceInput = try AVCaptureDeviceInput(device: currentCamera!)
                captureSession.addInput(captureDeviceInput)
                if captureSession.canAddOutput(photoOutput)
                {
                    captureSession.addOutput(photoOutput)
                    if let photoOutputConnection = photoOutput.connection(with: AVMediaType.video) {
                            photoOutputConnection.isVideoMirrored = true
                    }
                }
               
            } catch {
                print(error)
            }
        }

    func setupPreviewLayer() {
        cameraPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        cameraPreviewLayer.videoGravity = AVLayerVideoGravity.resizeAspect
        cameraPreviewLayer.frame = view.layer.bounds
        view.layer.insertSublayer(cameraPreviewLayer, at: 0)
    }

    func startRunningCaptureSession() {
        DispatchQueue.global().async {
            self.captureSession.startRunning()
        }
        
    }
}
extension CameraVC:AVCapturePhotoCaptureDelegate{
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        if let error = error {
            print("Fotoğraf çekilirken hata oluştu: \(error.localizedDescription)")
            return
        }

        guard let photoData = photo.fileDataRepresentation() else {
            print("Fotoğraf verilerine erişilemiyor.")
            return
        }
        
        if let capturedImage = UIImage(data: photoData) {
            imgPreview.image = capturedImage
        }
        

    }
}

