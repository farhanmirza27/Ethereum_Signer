//
//  SignatureRouter.swift
//  EthereumSigner
//
//  Created by Farhan Mirza on 12/01/2020.
//  Copyright © 2020 Farhan Mirza. All rights reserved.
//

import Foundation

class SignatureRouter : PresenterToRouterSignatureProtocol {
    static func createSignatureModule() -> SignatureViewController {
        
        let view =  SignatureViewController()
               let presenter: ViewToPresenterSignatureProtocol & InteractorToPresenterSignatureProtocol = SignaturePresenter()
               let interactor: PresenterToInteractorSignatureProtocol = SignatureInteractor()
               let router: PresenterToRouterSignatureProtocol = SignatureRouter()
               
               view.signaturePresenter = presenter
               presenter.view = view
               presenter.router = router
               presenter.interactor = interactor
               interactor.presenter = presenter
               return view
    }
    
    
}
