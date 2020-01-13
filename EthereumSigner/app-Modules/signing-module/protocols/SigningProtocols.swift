//
//  SigningProtocols.swift
//  EthereumSigner
//
//  Created by Farhan Mirza on 07/01/2020.
//  Copyright © 2020 Farhan Mirza. All rights reserved.
//

import UIKit



// Signing Screen Protocol

protocol ViewToPresenterSigningProtocol: class{
    
    var view: PresenterToViewSigningProtocol? {get set}
    var interactor: PresenterToInteractorSigningProtocol? {get set}
    var router: PresenterToRouterSigningProtocol? {get set}
    func signMessage(message : String)
    func showSignatureController(navigationController: UINavigationController)
}

protocol PresenterToViewSigningProtocol: class{
    func showQRCode()
    func showError()
}

protocol PresenterToRouterSigningProtocol: class {
    static func createSigningModule()-> SigningViewController
    func pushToSignatureScreen(navigationConroller:UINavigationController)
}

protocol PresenterToInteractorSigningProtocol: class {
    var presenter:InteractorToPresenterSigningProtocol? {get set}
    func signMessageWithPrivateKey(message : String)
}

protocol InteractorToPresenterSigningProtocol: class {
    func signMessageSuccess()
    func signMessageFailed()
}



