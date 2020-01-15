//
//  SignatureViewController.swift
//  EthereumSigner
//
//  Created by Farhan Mirza on 06/01/2020.
//  Copyright © 2020 Farhan Mirza. All rights reserved.
//

import UIKit

class SignatureViewController: BaseViewController {
    
    var signaturePresenter : ViewToPresenterSignatureProtocol?
    
    let messagelabel = UIComponents.shared.label(text: "Message: Example", alignment: .left, color: .black, fontName: FontName.Regular, fontSize: 16)
    
    let signatureQRCode  =  UIComponents.shared.imageView(imageName: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        signaturePresenter?.getSignature()
        setupViews()
    }
    
    func setupViews() {
        navigationItem.title = "Signature"
        
        saveAreaView.addSubViews(views: messagelabel, signatureQRCode)
        saveAreaView.addHConstraint(leftInset: 30, rightInset: 30, view: messagelabel)
        
        saveAreaView.addConstraintsWithFormat("H:[v0(200)]", views: signatureQRCode)
        signatureQRCode.centerHorizontally(toView: saveAreaView)
        saveAreaView.addConstraintsWithFormat("V:|-40-[v0]-20-[v1(200)]", views: messagelabel,signatureQRCode)
    }
    
}

extension SignatureViewController : PresenterToViewSignatureProtocol {
    func showQRCode(message : String , QRCodeImage : UIImage) {
        // show returned data
        messagelabel.text = "Message: " +  message
        signatureQRCode.image = QRCodeImage
    }
    
    func showError() {
        // show error
        self.alert(message : "Unable to show signature. Please try again later")
        
    }
    
    
}
