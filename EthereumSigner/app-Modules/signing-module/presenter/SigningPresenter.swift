//
//  SigningPresenter.swift
//  EthereumSigner
//
//  Created by Farhan Mirza on 07/01/2020.
//  Copyright © 2020 Farhan Mirza. All rights reserved.
//

import UIKit

class SigningPresenter : ViewToPresenterSigningProtocol {
   
    
    var view: PresenterToViewSigningProtocol?
    
    var interactor: PresenterToInteractorSigningProtocol?
    
    var router: PresenterToRouterSigningProtocol?
    
    func showSignatureController(navigationController: UINavigationController) {
        router?.pushToSignatureScreen(navigationConroller: navigationController)
    }
    
    func signMessage(message: String) {
        interactor?.signMessageWithPrivateKey(message : message)
       }
    
    
}

extension SigningPresenter :  InteractorToPresenterSigningProtocol {
    func signMessageSuccess() {
        view?.showQRCode()
    }
    
    func signMessageFailed() {
        view?.showError()
    }
    
    
}
