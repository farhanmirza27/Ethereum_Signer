//
//  VerificationPresenter.swift
//  EthereumSigner
//
//  Created by Farhan Mirza on 09/01/2020.
//  Copyright © 2020 Farhan Mirza. All rights reserved.
//

import UIKit



class VerificationPresenter: ViewToPresenterVerificationProtocol {
  
    var view: PresenterToViewVerificationProtocol?
    
    var interactor: PresenterToInteractorVerificationProtocol?
    
    var router: PresenterToRouterVerificationProtocol?
    
    
    func verifyMessageSignature(message: String) {
        // call interactor
        interactor?.verifySignature(message : message)
      }
      
    func showScannerController(navigationController: UINavigationController) {
        router?.pushToScannerScreen(navigationConroller: navigationController)
    }

}

extension VerificationPresenter: InteractorToPresenterVerificationProtocol{
    func signatureVerifySuccess() {
        view?.showScannerScreen()
    }
    
    func signatureVerifyFailed() {
         view?.showScannerScreen()
    }
    

}
