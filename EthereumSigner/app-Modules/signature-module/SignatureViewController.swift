//
//  SignatureViewController.swift
//  EthereumSigner
//
//  Created by Farhan Mirza on 06/01/2020.
//  Copyright © 2020 Farhan Mirza. All rights reserved.
//

import UIKit

class SignatureViewController: BaseViewController {

    let messagelabel = UIComponents.shared.label(text: "Message: Example", alignment: .left, color: .black, fontName: FontName.Regular, fontSize: 16)
    
    let signatureQRCode  =  UIComponents.shared.imageView(imageName: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Signature"

        saveAreaView.addSubViews(views: messagelabel, signatureQRCode)
        saveAreaView.addHConstraint(leftInset: 30, rightInset: 30, view: messagelabel)
       
        saveAreaView.addConstraintsWithFormat("H:[v0(200)]", views: signatureQRCode)
        signatureQRCode.centerHorizontally(toView: saveAreaView)
        
        saveAreaView.addConstraintsWithFormat("V:|-40-[v0]-20-[v1(200)]", views: messagelabel,signatureQRCode)
        
        // Do any additional setup after loading the view.
        
       // generateCode()
    }
    
    func generateCode() {
       // let image =  EthereumClient.shared.generateQRCode(from: "New swift")
       // signatureQRCode.image = image
    }
}
