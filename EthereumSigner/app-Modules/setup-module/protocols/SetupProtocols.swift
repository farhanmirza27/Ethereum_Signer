//
//  SetupProtocols.swift
//  EthereumSigner
//
//  Created by Farhan Mirza on 07/01/2020.
//  Copyright © 2020 Farhan Mirza. All rights reserved.
//

import UIKit

protocol ViewToPresenterProtocol: class{
    
    var view: PresenterToViewProtocol? {get set}
    var interactor: PresenterToInteractorProtocol? {get set}
    var router: PresenterToRouterProtocol? {get set}
    func showAccountController(navigationController: UINavigationController)
}

protocol PresenterToViewProtocol: class{
    //func showAccountScreen()
}

protocol PresenterToRouterProtocol: class {
    static func createModule()-> SetupViewController
    func pushToAccountScreen(navigationConroller:UINavigationController)
    func logout(navigationConroller:UINavigationController)
}

protocol PresenterToInteractorProtocol: class {
    var presenter:InteractorToPresenterProtocol? {get set}
    func saveUserWallet(wallet : Wallet)
}

protocol InteractorToPresenterProtocol: class {
    func userWalletSaved()
}

