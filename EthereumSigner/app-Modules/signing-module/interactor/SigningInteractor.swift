//
//  SigningInteractor.swift
//  EthereumSigner
//
//  Created by Farhan Mirza on 07/01/2020.
//  Copyright © 2020 Farhan Mirza. All rights reserved.
//


class SigningInteractor: PresenterToInteractorSigningProtocol{
    
    var presenter: InteractorToPresenterSigningProtocol?
    
    func signMessageWithPrivateKey(message: String) {
        EthereumClient.shared.signMessageWithPrivateKey(message: message, privateKey: DataManager.shared.getPrivateKey(), { result in
            if result {
                self.presenter?.signMessageSuccess()
            }
            else {
                self.presenter?.signMessageSuccess()
            }
        }) { error in
            self.presenter?.signMessageFailed()
        }
    }
    
}
