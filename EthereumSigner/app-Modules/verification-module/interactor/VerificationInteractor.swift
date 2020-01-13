//
//  VerificationInteractor.swift
//  EthereumSigner
//
//  Created by Farhan Mirza on 09/01/2020.
//  Copyright © 2020 Farhan Mirza. All rights reserved.
//

import Foundation


class VerficationInteractor : PresenterToInteractorVerificationProtocol {
    var presenter: InteractorToPresenterVerificationProtocol?
    
    func verifySignature(message : String) {
        
        // verify Signature
        EthereumClient.shared.verifySignatureWithPublicKey(message: message, { result in
            if result {
            self.presenter?.signatureVerifySuccess()
            }
            else {
            self.presenter?.signatureVerifyFailed()
            }
     
        }) { error in
            self.presenter?.signatureVerifyFailed()
        }
        

    }
    
    
}
