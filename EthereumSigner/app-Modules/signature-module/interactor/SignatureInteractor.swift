//
//  SignatureInteractor.swift
//  EthereumSigner
//
//  Created by Farhan Mirza on 12/01/2020.
//  Copyright © 2020 Farhan Mirza. All rights reserved.
//

import Foundation

class  SignatureInteractor : PresenterToInteractorSignatureProtocol {
    var presenter: InteractorToPresenterSignatureProtocol?
    
    func getSignature() {
        let saveSignature =  DataManager.shared.find(type: Signature.self, forKey: "Signature")
        
        if let walletAddress = saveSignature?.getAddress() {
            if let QRCodeImage = EthereumClient.shared.generateQRCode(from: walletAddress), let message = saveSignature?.getMessage() {
             self.presenter?.getSignatureSuccess(message: message, QRCodeImage: QRCodeImage)
            }
        }
        else {
            presenter?.getSignatureFail()
        }
        
    }
    
    
}
