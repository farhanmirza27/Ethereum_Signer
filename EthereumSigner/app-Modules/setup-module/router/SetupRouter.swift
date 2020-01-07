//
//  SetupRouter.swift
//  EthereumSigner
//
//  Created by Farhan Mirza on 07/01/2020.
//  Copyright © 2020 Farhan Mirza. All rights reserved.
//

import UIKit


class SetupRouter:PresenterToRouterProtocol{
   
    static func createModule() -> SetupViewController {
        
        let view =  SetupViewController()
        let presenter: ViewToPresenterProtocol & InteractorToPresenterProtocol = SetupPresenter()
        let interactor: PresenterToInteractorProtocol = SetupInteractor()
        let router:PresenterToRouterProtocol = SetupRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        return view
        
    }
    
    func pushToAccountScreen(navigationConroller: UINavigationController) {
        let accountModule = AccountRouter.createAccountModule()
        navigationConroller.pushViewController(accountModule,animated: true)
    }
    
    func logout(navigationConroller: UINavigationController) {
        navigationConroller.popViewController(animated: true)
       }
        
}
