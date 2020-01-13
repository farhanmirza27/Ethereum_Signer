//
//  SignatureProtocol.swift
//  EthereumSigner
//
//  Created by Farhan Mirza on 12/01/2020.
//  Copyright © 2020 Farhan Mirza. All rights reserved.
//

import UIKit

protocol ViewToPresenterSignatureProtocol: class{
     
     var view: PresenterToViewSignatureProtocol? {get set}
     var interactor: PresenterToInteractorSignatureProtocol? {get set}
     var router: PresenterToRouterSignatureProtocol? {get set}
     func getSignature()
 }

 protocol PresenterToViewSignatureProtocol: class{
    func showQRCode(message : String, QRCodeImage : UIImage)
     func showError()
 }


protocol PresenterToRouterSignatureProtocol: class {
    static func createSignatureModule()-> SignatureViewController
}

protocol PresenterToInteractorSignatureProtocol: class {
    var presenter:InteractorToPresenterSignatureProtocol? {get set}
    func getSignature()
}

protocol InteractorToPresenterSignatureProtocol: class {
    func  getSignatureSuccess(message : String , QRCodeImage : UIImage)
       func  getSignatureFail()
}


