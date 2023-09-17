//
//  ViewController.swift
//  ui-kit-demo
//
//  Created by Phạm Công on 09/09/2023.
//

import UIKit

class ViewController: BaseViewController {
    lazy var stackView: UIStackView = {
        let st = UIStackView()
        st.translatesAutoresizingMaskIntoConstraints = false
        st.addArrangedSubview(imageView)
        return st
    }()
    
    lazy var imageView: UIImageView = {
        let imgView = UIImageView(frame: .init(origin: .zero, size: CGSize(width: 200, height: 200)))
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.image = UIImage(systemName: "apple.logo")
        imgView.contentMode = .scaleAspectFit
        imgView.tintColor = .red
        return imgView
    }()
    
    lazy var cameraView: CameraView = {
       let cv = CameraView()
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = .black.withAlphaComponent(0.9)
        return cv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .green
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        cameraView.setUpCamera()
    }
    
    override func configureView() {
        configCameraView()
        MRActivityIndicator.shared.show(title: "Đang lấy thông tin khách hàng", timeOut: 3, colorBlur: .green.withAlphaComponent(0.2))
        
    }
    
    override func configureData() {
        
    }
    
    func configStackView(){
        view.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    func configCameraView(){
        view.addSubview(cameraView)
        
        NSLayoutConstraint.activate([
            cameraView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            cameraView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            cameraView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            cameraView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
        ])
        
        let cover = CoverCameraView(frame: cameraView.frame)
        cover.backgroundColor = .yellow
//        cameraView.addCoverView(view: cover)
    }
    
}

class BaseViewController: UIViewController, ViewControllerProtocol {
    override func viewDidLoad() {
        configureView()
        configureData()
    }
    
    func configureView() {
        
    }
    
    func configureData() {
        
    }
}

protocol ViewControllerProtocol {
    func configureView()
    func configureData()
}


import SwiftUI

fileprivate struct ContentView: View {
    var body: some View{
        VStack{
            Text("Lưu thông tin không thành công!")
        }
    }
}

struct Preview: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct ViewControllerPreview: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> some UIViewController {
        return ViewController()
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
}

import AVFoundation

class CameraView: UIView {
    var captureSession: AVCaptureSession!
    var stillImageOutput: AVCapturePhotoOutput!
    var videoPreviewLayer: AVCaptureVideoPreviewLayer!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
//        setUpCamera()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createOverlay() -> UIView {
        let frame  = self.frame
        let overlayView = UIView(frame: self.frame)
        overlayView.backgroundColor = UIColor.black.withAlphaComponent(0.9)

        let path = createPath(frame: frame)
        let shape = createShape(path: path)
        
        
        overlayView.layer.addSublayer(shape)
        
        path.addRect(CGRect(origin: .zero, size: overlayView.frame.size))

        let maskLayer = createMaskLayer(path: path)

        overlayView.layer.mask = maskLayer
        overlayView.clipsToBounds = true
        
        return overlayView
    }
    
    func createShape(path: CGMutablePath) -> CAShapeLayer{
        let shape = CAShapeLayer()
        shape.path = path
        shape.lineWidth = 5.0
        shape.strokeColor = UIColor.white.cgColor
        shape.fillColor = UIColor.clear.cgColor
        return shape
    }
    
    func createMaskLayer(path: CGMutablePath)-> CAShapeLayer {
        let maskLayer = CAShapeLayer()
        maskLayer.backgroundColor = UIColor.black.cgColor
        maskLayer.path = path
        maskLayer.fillRule = CAShapeLayerFillRule.evenOdd
        return maskLayer
    }
    
    func createPath(frame: CGRect)-> CGMutablePath{
        let path = CGMutablePath()

        path.addRoundedRect(in: CGRect(x: 50, y: 100, width: frame.width-100, height: frame.height - 300), cornerWidth: 20, cornerHeight: 20)


        path.closeSubpath()
        return path
    }
    func setUpCamera(){
        captureSession = AVCaptureSession()
        captureSession.sessionPreset = .hd4K3840x2160
        
        guard let backCamera = AVCaptureDevice.default(for: .video) else { return }
        
        guard let input = try? AVCaptureDeviceInput(device: backCamera) else { return }
        stillImageOutput = AVCapturePhotoOutput()
        
        if captureSession.canAddInput(input) && captureSession.canAddOutput(stillImageOutput){
            captureSession.addInput(input)
            captureSession.addOutput(stillImageOutput)
        }
        
        setupLivePreview()
    }
    
    private func setupLivePreview(){
        videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        videoPreviewLayer.videoGravity = .resizeAspect
        videoPreviewLayer.connection?.videoOrientation = .portrait
        self.layer.addSublayer(videoPreviewLayer)
        
        DispatchQueue.global().async {
            self.captureSession.startRunning()
        }
        self.videoPreviewLayer.frame = self.bounds
        
        self.layer.insertSublayer(videoPreviewLayer!, at: 1)
        let overlay = createOverlay()
        self.addSubview(overlay)
        
    }
    
    func addCoverView(view: UIView){
        self.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: self.topAnchor),
            view.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            view.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        ])
    }
}

class CoverCameraView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
    }
    
    func createOverlay() -> UIView {
        
        let overlayView = UIView(frame: self.frame)
        overlayView.backgroundColor = UIColor.black.withAlphaComponent(0.4)



        let path = CGMutablePath()

        path.addRoundedRect(in: CGRect(x: 15, y: overlayView.center.y-100, width: overlayView.frame.width-30, height: 200), cornerWidth: 5, cornerHeight: 5)

        
        path.closeSubpath()
        
        let shape = CAShapeLayer()
        shape.path = path
        shape.lineWidth = 3.0
        shape.strokeColor = UIColor.blue.cgColor
        shape.fillColor = UIColor.blue.cgColor
        
        overlayView.layer.addSublayer(shape)
        
        path.addRect(CGRect(origin: .zero, size: overlayView.frame.size))

        let maskLayer = CAShapeLayer()
        maskLayer.backgroundColor = UIColor.black.cgColor
        maskLayer.path = path
        maskLayer.fillRule = CAShapeLayerFillRule.evenOdd

        overlayView.layer.mask = maskLayer
        overlayView.clipsToBounds = true
        
        return overlayView
    }
    
    override func draw(_ rect: CGRect) {
//        let mask = CAShapeLayer()
//        mask.path = UIBezierPath(ovalIn: CGRectInset(self.frame, 50, 50)).cgPath
//        self.layer.mask = mask
        
//        let path1 = UIBezierPath(rect: CGRect(x: 150, y: 150, width: 100, height: 100))
//
//        // Tạo path2 (ban đầu giống path1)
//        let path2 = UIBezierPath(rect: CGRect(x: 250, y: 250, width: 200, height: 200))
//
//        // Thực hiện phép giao để lấy phần còn lại
//        path2.append(UIBezierPath(rect: CGRect(x: 0, y: 0, width: 200, height: 200)))
////        path2.usesEvenOddFillRule = true
//        path2.addClip()
//        let mask = CAShapeLayer()
//        path1.usesEvenOddFillRule = true
//        mask.path = path1.cgPath
//        mask.fillRule = .evenOdd
////        self.layer.mask = mask
        
        let overlay = createOverlay()
        self.addSubview(overlay)
        self.sendSubviewToBack(overlay)
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
