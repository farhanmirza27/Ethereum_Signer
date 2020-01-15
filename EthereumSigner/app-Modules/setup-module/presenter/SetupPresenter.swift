//
//  SetupPresenter.swift
//  EthereumSigner
//
//  Created by Farhan Mirza on 07/01/2020.
//  Copyright © 2020 Farhan Mirza. All rights reserved.
//


import Foundation
import UIKit

class SetupPresenter: ViewToPresenterProtocol {
    
    var view: PresenterToViewProtocol?
    
    var interactor: PresenterToInteractorProtocol?
    
    var router: PresenterToRouterProtocol?
    
    func showAccountController(navigationController: UINavigationController) {
        router?.pushToAccountScreen(navigationConroller: navigationController)
    }
    
    func didClickDone(privateKey : String) {
        interactor?.importAccount(privateKey: privateKey)
    }
    
}

extension SetupPresenter: InteractorToPresenterProtocol{
    func importAccountSuccess() {
        // user private key saved. Move user to account screen
          view?.showAccountScreen()
    }
    
    func importAccountFail() {
        view?.showError()
    }
    
}
