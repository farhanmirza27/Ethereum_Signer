//
//  ScannerViewController.swift
//  EthereumSigner
//
//  Created by Farhan Mirza on 06/01/2020.
//  Copyright © 2020 Farhan Mirza. All rights reserved.
//

import UIKit

import AVFoundation
import UIKit

class ScannerViewController: BaseViewController, AVCaptureMetadataOutputObjectsDelegate {
    var captureSession: AVCaptureSession!
    var previewLayer: AVCaptureVideoPreviewLayer!
    
    var scannerPresenter : ViewToPresenterScannerProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupScanner()
    }
    
    func setupScanner() {
    view.backgroundColor = UIColor.black
          captureSession = AVCaptureSession()
          
          guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else { return }
          let videoInput: AVCaptureDeviceInput
          
          do {
              videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
          } catch {
              return
          }
          
          if (captureSession.canAddInput(videoInput)) {
              captureSession.addInput(videoInput)
          } else {
              failed()
              return
          }
          
          let metadataOutput = AVCaptureMetadataOutput()
          
          if (captureSession.canAddOutput(metadataOutput)) {
              captureSession.addOutput(metadataOutput)
              
              metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
              metadataOutput.metadataObjectTypes = [.qr]
          } else {
              failed()
              return
          }
          
          previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
          previewLayer.frame = view.layer.bounds
          previewLayer.videoGravity = .resizeAspectFill
          view.layer.addSublayer(previewLayer)
          
          captureSession.startRunning()
    }
    
    // In case of scanning failed
    
    func failed() {
        let ac = UIAlertController(title: "Scanning not supported", message: "Your device does not support scanning a code from an item. Please use a device with a camera.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
        captureSession = nil
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if (captureSession?.isRunning == false) {
            captureSession.startRunning()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if (captureSession?.isRunning == true) {
            captureSession.stopRunning()
        }
    }
    
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        captureSession.stopRunning()
        if let metadataObject = metadataObjects.first {
            guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return }
            guard let stringValue = readableObject.stringValue else { return }
           // AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
            found(code: stringValue)
        }
        dismiss(animated: true)
    }
    
    
    func found(code: String) {
     // verify signature
        scannerPresenter?.verifySignatureWithQRCode(address: code)
    }
    
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
}


extension ScannerViewController : PresenterToViewScannerProtocol {
    func showFailureAlert() {
    self.alert(message: "Invalid Signature", title: "Failure")
    }
    
    func showSuccessAlert() {
        self.alert(message: "Valid Signature", title: "Success")
    }

}
