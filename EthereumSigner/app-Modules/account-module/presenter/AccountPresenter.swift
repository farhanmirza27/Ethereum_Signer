//
//  AccountPresenter.swift
//  EthereumSigner
//
//  Created by Farhan Mirza on 07/01/2020.
//  Copyright © 2020 Farhan Mirza. All rights reserved.
//

import UIKit

class AccountPresenter: ViewToPresenterAccountProtocol {
 
    var view: PresenterToViewAccountProtocol?
    
    var interactor: PresenterToInteractorAccountProtocol?
    
    var router: PresenterToRouterAccountProtocol?
    
    
    func fetchAccountBalance() {
        interactor?.fetchAccountBalance()
    }

    func showSigningController(navigationController: UINavigationController) {
        router?.pushToSiginingScreen(navigationConroller: navigationController)
    }
      
    func showVerificationController(navigationController: UINavigationController) {
        router?.pushToVerificationScreen(navigationConroller: navigationController)
    }
   
     func performLogout(navigationController: UINavigationController) {
        router?.logout(navigationConroller: navigationController)
      }
      
}

extension AccountPresenter: InteractorToPresenterAccountProtocol{
    func fetchAccountBalanceSuccess() {
        view?.fetchBalance()
    //
    }
    
    func fetchAccountBalanceFailed() {
    ///
    }
    
}