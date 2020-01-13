//
//  AccountProtocols.swift
//  EthereumSigner
//
//  Created by Farhan Mirza on 07/01/2020.
//  Copyright © 2020 Farhan Mirza. All rights reserved.
//

import UIKit

protocol ViewToPresenterAccountProtocol: class{
    
    var view: PresenterToViewAccountProtocol? {get set}
    var interactor: PresenterToInteractorAccountProtocol? {get set}
    var router: PresenterToRouterAccountProtocol? {get set}
    
    func fetchAccountBalance()
    func showSigningController(navigationController: UINavigationController)
    func showVerificationController(navigationController: UINavigationController)
    func performLogout(navigationController: UINavigationController)
}

protocol PresenterToViewAccountProtocol: class{
    func displayBalance(walletAddress : String, balance : String)
    func showError()
    
}

protocol PresenterToRouterAccountProtocol: class {
    static func createAccountModule()-> AccountViewController
    func pushToSiginingScreen(navigationConroller:UINavigationController)
    func pushToVerificationScreen(navigationConroller:UINavigationController)
    func logout(navigationConroller:UINavigationController)
 
}

protocol PresenterToInteractorAccountProtocol: class {
    var presenter:InteractorToPresenterAccountProtocol? {get set}
    func fetchAccountBalance()
}

protocol InteractorToPresenterAccountProtocol: class {
    func fetchAccountBalanceSuccess(walletAddress : String, balance : String)
    func fetchAccountBalanceFailed(error : String)
}

