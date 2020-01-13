//
//  SignaturePresenter.swift
//  EthereumSigner
//
//  Created by Farhan Mirza on 09/01/2020.
//  Copyright © 2020 Farhan Mirza. All rights reserved.
//

import UIKit


class SignaturePresenter :  ViewToPresenterSignatureProtocol {
    var view: PresenterToViewSignatureProtocol?
    
    var interactor: PresenterToInteractorSignatureProtocol?
    
    var router: PresenterToRouterSignatureProtocol?
    
    func getSignature() {
    interactor?.getSignature()
    }

}

extension SignaturePresenter : InteractorToPresenterSignatureProtocol {
    func getSignatureSuccess(message: String, QRCodeImage: UIImage) {
        view?.showQRCode(message: message, QRCodeImage: QRCodeImage)
    }
    
    func getSignatureFail() {
    // show error on screen
        view?.showError()
    }
    
    
}
