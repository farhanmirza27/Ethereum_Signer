//
//  SigningRouter.swift
//  EthereumSigner
//
//  Created by Farhan Mirza on 07/01/2020.
//  Copyright © 2020 Farhan Mirza. All rights reserved.
//

import UIKit

class SigningRouter : PresenterToRouterSigningProtocol {
    static func createSigningModule() -> SigningViewController {
        
        let view =  SigningViewController()
               let presenter: ViewToPresenterSigningProtocol & InteractorToPresenterSigningProtocol = SigningPresenter()
               let interactor: PresenterToInteractorSigningProtocol = SigningInteractor()
               let router: PresenterToRouterSigningProtocol = SigningRouter()
               
               view.signingPresenter = presenter
               presenter.view = view
               presenter.router = router
               presenter.interactor = interactor
               interactor.presenter = presenter
               return view
    }
    
    
    func pushToSignatureScreen(navigationConroller: UINavigationController) {
     let signatureModule = SignatureRouter.createSignatureModule()
            navigationConroller.pushViewController(signatureModule,animated: true)
    }
    
    
}
