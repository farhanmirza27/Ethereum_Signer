//
//  VerificationProtocols.swift
//  EthereumSigner
//
//  Created by Farhan Mirza on 09/01/2020.
//  Copyright © 2020 Farhan Mirza. All rights reserved.
//

import UIKit


protocol ViewToPresenterVerificationProtocol: class{
    
    var view: PresenterToViewVerificationProtocol? {get set}
    var interactor: PresenterToInteractorVerificationProtocol? {get set}
    var router: PresenterToRouterVerificationProtocol? {get set}
    
    func verifyMessageSignature(message : String)
    func showScannerController(navigationController: UINavigationController)
}

protocol PresenterToViewVerificationProtocol: class{
    func showScannerScreen()
    func showError()
}

protocol PresenterToRouterVerificationProtocol: class {
    static func createVerificationModule()-> VerificationViewController
    func pushToScannerScreen(navigationConroller:UINavigationController)
}

protocol PresenterToInteractorVerificationProtocol: class {
    var presenter:InteractorToPresenterVerificationProtocol? {get set}
    func verifySignature(message : String)
}

protocol InteractorToPresenterVerificationProtocol: class {
    func signatureVerifySuccess()
    func signatureVerifyFailed()
}

