//
//  SigningViewController.swift
//  EthereumSigner
//
//  Created by Farhan Mirza on 05/01/2020.
//  Copyright © 2020 Farhan Mirza. All rights reserved.
//

import UIKit



class SigningViewController : BaseViewController {
    
    let messageTF = UIComponents.shared.textField(placeHolder: "Your Message")
    let signButton = UIComponents.shared.button(text: "Sign Message")
    
    var signingPresenter : ViewToPresenterSigningProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Signing"
        
        saveAreaView.addSubViews(views: messageTF,signButton)
        saveAreaView.addHConstraint(leftInset: 30, rightInset: 30, view: messageTF)
        saveAreaView.addHConstraint(leftInset: 40, rightInset: 40, view: signButton)
        saveAreaView.addConstraintsWithFormat("V:|-40-[v0(50)]-30-[v1(45)]", views: messageTF, signButton)
        
        // Target
        signButton.addTarget(self, action: #selector(signMessage), for: .touchUpInside)
    }
    
    @objc func signMessage() {
        if let messageText = messageTF.text {
            if !messageText.isEmpty {
                signingPresenter?.signMessage(message: messageText)
                
            }
        }
        
    }
    
}

extension SigningViewController : PresenterToViewSigningProtocol {
    func showQRCode() {
        signingPresenter?.showSignatureController(navigationController: self.navigationController!)
    }
    
    func showError() {
        self.alert(message: "Unable to sign message please try again later.")
    }
    
    
}


//            let signedMessage = EthereumClient.shared.signMessage(message: messageText.sha3(.sha256), address: EthereumClient.shared.getWalletAddress())
//
//           let image =  EthereumClient.shared.generateQRCodeFromData(from:  signedMessage)
//
//           let controller = SignatureViewController()
//           controller.signatureQRCode.image = image
//           controller.messagelabel.text = "Message: " + messageTF.text!
//
//           self.navigationController?.pushViewController(controller, animated: true)
