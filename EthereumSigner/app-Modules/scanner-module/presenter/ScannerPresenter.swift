//
//  ScannerPresenter.swift
//  EthereumSigner
//
//  Created by Farhan Mirza on 10/01/2020.
//  Copyright © 2020 Farhan Mirza. All rights reserved.
//

import Foundation

class ScannerPresenter : ViewToPresenterScannerProtocol {
    var view: PresenterToViewScannerProtocol?
    
    var interactor: PresenterToInteractorScannerProtocol?
    
    var router: PresenterToRouterScannerProtocol?
    
    func verifySignatureWithQRCode(address : String) {
        interactor?.verifySignatureWithQRCode(address: address)
    }
    
}


extension ScannerPresenter : InteractorToPresenterScannerProtocol {
    func signatureVerifySuccess() {
        view?.showSuccessAlert()
    }
    
    func signatureVerifyFailed() {
        view?.showFailureAlert()
    }
    
    
}
