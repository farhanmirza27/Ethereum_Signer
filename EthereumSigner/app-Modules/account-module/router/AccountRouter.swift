//
//  AccountRouter.swift
//  EthereumSigner
//
//  Created by Farhan Mirza on 07/01/2020.
//  Copyright © 2020 Farhan Mirza. All rights reserved.
//

import UIKit


class AccountRouter: PresenterToRouterAccountProtocol{
  
    static func createAccountModule() -> AccountViewController {
        
        let view =  AccountViewController()
        let presenter: ViewToPresenterAccountProtocol & InteractorToPresenterAccountProtocol = AccountPresenter()
        let interactor: PresenterToInteractorAccountProtocol = AccountInteractor()
        let router:PresenterToRouterAccountProtocol = AccountRouter()
        
        view.accountPresenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        return view
    }
    
    func pushToSiginingScreen(navigationConroller: UINavigationController) {
        let signingModule = SigningRouter.createSigningModule()
            navigationConroller.pushViewController(signingModule,animated: true)
    }
    
    func pushToVerificationScreen(navigationConroller: UINavigationController) {
         let verificationModule = VerficationRouter.createVerificationModule()
         navigationConroller.pushViewController(verificationModule,animated: true)
    }
    
    func logout(navigationConroller: UINavigationController) {
        navigationConroller.popViewController(animated: true)
      }
      
    
}
