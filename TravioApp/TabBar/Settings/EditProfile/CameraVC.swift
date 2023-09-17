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
    private var canTakePhoto = true {
        didSet{
            changeStackButtons()
        }
    }
    
    var CameraTrandferDataDelegate:CameraTransferData?
    
    private lazy var btnBack: UICustomButtonBack = {
        let bt = UICustomButtonBack()
        bt.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        return bt
    }()
    
    private lazy var imgPreview:UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        return iv
    }()

    private lazy var btnFlash: UIButton = {
        let bt = UIButton()
        bt.addTarget(self, action: #selector(flashOnOff), for: .touchUpInside)
        bt.height(30); bt.width(40)
        let iv = UIImageView()
        iv.height(30); iv.width(40)
        iv.image = UIImage(systemName: "bolt.fill")
        iv.contentMode = .scaleAspectFit
        iv.tintColor = CustomColor.White.color
        bt.addSubview(iv)
        iv.center(in: bt)
        return bt
    }()
    
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
    
    private lazy var btnReturnCam: UIButton = {
        let bt = UIButton()
        bt.addTarget(self, action: #selector(changeCamera), for: .touchUpInside)
        bt.height(30); bt.width(40)
        let iv = UIImageView()
        iv.height(30); iv.width(40)
        iv.image = UIImage(systemName: "arrow.triangle.2.circlepath.camera.fill")
        iv.contentMode = .scaleAspectFit
        iv.tintColor = CustomColor.White.color
        bt.addSubview(iv)
        iv.center(in: bt)
        return bt
    }()
    
    private lazy var svCameraButtons: UIStackView = {
        let sv = UIStackView()
        sv.layoutMargins = UIEdgeInsets(top: 5, left: 50, bottom: 5, right: 50)
        sv.isLayoutMarginsRelativeArrangement = true
        sv.backgroundColor = CustomColor.TravioWhiteHalfAlpha.color
        sv.distribution = .fillProportionally
        sv.alignment = .center
        sv.spacing = 40
        sv.axis = .horizontal
        sv.addArrangedSubview(btnFlash)
        sv.addArrangedSubview(btnTakePhoto)
        sv.addArrangedSubview(btnReturnCam)
        return sv
    }()
    
    private lazy var btnDismiss: UIButton = {
        let bt = UIButton()
        bt.setTitle("DISMISS", for: .normal)
        bt.backgroundColor = .clear
        bt.contentHorizontalAlignment = .right
        bt.titleLabel?.font = CustomFont.PoppinsSemiBold(18).font
        bt.addTarget(self, action: #selector(throwAwayPhoto ), for: .touchUpInside)
        return bt
    }()
    
    private lazy var btnChoose: UIButton = {
        let bt = UIButton()
        bt.setTitle("ADD", for: .normal)
        bt.backgroundColor = .clear
        bt.contentHorizontalAlignment = .left
        bt.titleLabel?.font = CustomFont.PoppinsSemiBold(18).font
        bt.addTarget(self, action: #selector(choosePhoto), for: .touchUpInside)
        return bt
    }()
    
    private lazy var svAddDismissButtons: UIStackView = {
        let sv = UIStackView()
        sv.backgroundColor = CustomColor.TravioWhiteHalfAlpha.color
        sv.distribution = .fillProportionally
        sv.alignment = .center
        sv.spacing = 50
        sv.axis = .horizontal
        sv.isHidden = true
        sv.addArrangedSubview(btnDismiss)
        sv.addArrangedSubview(btnChoose)
        return sv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showCamera()
        setupLayout()
    }
    override func viewDidLayoutSubviews() {
        svCameraButtons.roundCornersWithShadow([.bottomLeft,.topLeft,.topRight], radius: 18)
        svAddDismissButtons.roundCornersWithShadow([.bottomLeft,.topLeft,.topRight], radius: 18)
    }
    @objc func goBack(){
        dismiss(animated: true)
    }
    @objc func flashOnOff(){
        
        if let device = AVCaptureDevice.default(for: .video) {
            do {
                try device.lockForConfiguration()
                if device.torchMode == .on {
                    device.torchMode = .off
                }
                else{ device.torchMode = .on}
               
                device.unlockForConfiguration()
            } catch {
                print("Flaşı açarken bir hata oluştu: \(error.localizedDescription)")
            }
        }
    }
    
    @objc func changeCamera(){
        
        if currentCamera == frontCamera { currentCamera = backCamera }
        else { currentCamera = frontCamera }
        setupInputOutput()
    }
    
    @objc func throwAwayPhoto(){
        imgPreview.image = nil
        canTakePhoto = true
    }
    
    @objc func choosePhoto(){
        guard let image = imgPreview.image else {return}
        CameraTrandferDataDelegate?.transferImage(image: image)
        dismiss(animated: true)
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
    
    func changeStackButtons(){
        if svCameraButtons.isHidden {
            svCameraButtons.isHidden = false
            svAddDismissButtons.isHidden = true
        }
        else{
            svCameraButtons.isHidden = true
            svAddDismissButtons.isHidden = false
        }
    }
    
    func setupLayout(){
        
        self.view.backgroundColor = CustomColor.TravioGreen.color
        addSubviews()
        
        btnBack.topToSuperview(offset: 19,usingSafeArea: true)
        btnBack.leadingToSuperview(offset: 20)
        
        imgPreview.edgesToSuperview()
        
        svCameraButtons.bottomToSuperview(offset: -70)
        svCameraButtons.edgesToSuperview(excluding: [.bottom,.top],insets: .left(50) + .right(50))
        svCameraButtons.height(60)
        btnTakePhoto.centerYToSuperview()
        btnTakePhoto.centerXToSuperview()
        btnReturnCam.centerYToSuperview()
        btnFlash.centerYToSuperview()
        
        svAddDismissButtons.bottomToSuperview(offset: -70)
        svAddDismissButtons.edgesToSuperview(excluding: [.bottom,.top],insets: .left(50) + .right(50))
        svAddDismissButtons.height(60)
        btnDismiss.centerYToSuperview()
        btnChoose.centerYToSuperview()
        

    }
    func addSubviews(){
        self.view.addSubviews(btnBack,svCameraButtons,svAddDismissButtons,imgPreview)
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
                
                if let currentInput = captureSession.inputs.first as? AVCaptureDeviceInput {
                    captureSession.removeInput(currentInput)
                }
                let captureDeviceInput = try AVCaptureDeviceInput(device: currentCamera!)
                captureSession.addInput(captureDeviceInput)
                
                if let currentOutput = captureSession.outputs.first as? AVCapturePhotoOutput {
                    captureSession.removeOutput(currentOutput)
                }
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

