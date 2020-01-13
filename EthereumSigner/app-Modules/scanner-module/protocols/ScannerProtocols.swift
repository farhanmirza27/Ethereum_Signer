
//
//  ScannerProtocols.swift
//  EthereumSigner
//
//  Created by Farhan Mirza on 10/01/2020.
//  Copyright © 2020 Farhan Mirza. All rights reserved.
//

import UIKit


protocol ViewToPresenterScannerProtocol: class{
    
    var view: PresenterToViewScannerProtocol? {get set}
    var interactor: PresenterToInteractorScannerProtocol? {get set}
    var router: PresenterToRouterScannerProtocol? {get set}
    
    func verifySignatureWithQRCode(address : String)
}

protocol PresenterToViewScannerProtocol: class{
    func showSuccessAlert()
    func showFailureAlert()
}

protocol PresenterToRouterScannerProtocol: class {
    static func createScannerModule()-> ScannerViewController
}

protocol PresenterToInteractorScannerProtocol: class {
    var presenter:InteractorToPresenterScannerProtocol? {get set}
    func verifySignatureWithQRCode(address : String)
}

protocol InteractorToPresenterScannerProtocol: class {
    func signatureVerifySuccess()
    func signatureVerifyFailed()
}

