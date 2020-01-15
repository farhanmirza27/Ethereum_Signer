//
//  ScannerInteractor.swift
//  EthereumSigner
//
//  Created by Farhan Mirza on 10/01/2020.
//  Copyright © 2020 Farhan Mirza. All rights reserved.
//

import Foundation


class ScannerInteractor : PresenterToInteractorScannerProtocol {
    var presenter: InteractorToPresenterScannerProtocol?
    
    func verifySignatureWithQRCode(address: String) {
        // handle success and fail
        
        // Fetch Signature of message need to be verified from user-defaults
        
        let signatureRequiredVerfication = DataManager.shared.find(type: Signature.self, forKey: "VerifySignature")
        if let etherumAddress = signatureRequiredVerfication?.getAddress() {
            if etherumAddress == address { // Address from QR code
                presenter?.signatureVerifySuccess()
            }
            else {
                presenter?.signatureVerifyFailed()
            }
        }
        else {
                presenter?.signatureVerifyFailed()
        }
        
    }
    
    
}
