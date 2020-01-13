//
//  verificationRouter.swift
//  EthereumSigner
//
//  Created by Farhan Mirza on 09/01/2020.
//  Copyright © 2020 Farhan Mirza. All rights reserved.
//

import UIKit


class VerficationRouter : PresenterToRouterVerificationProtocol {
    
    static func createVerificationModule() -> VerificationViewController {
        let view =  VerificationViewController()
               let presenter: ViewToPresenterVerificationProtocol & InteractorToPresenterVerificationProtocol = VerificationPresenter()
               let interactor: PresenterToInteractorVerificationProtocol = VerficationInteractor()
               let router: PresenterToRouterVerificationProtocol = VerficationRouter()
               
               view.verificationPresenter = presenter
               presenter.view = view
               presenter.router = router
               presenter.interactor = interactor
               interactor.presenter = presenter
               return view
               
    }
    
    func pushToScannerScreen(navigationConroller: UINavigationController) {
        navigationConroller.pushViewController(ScannerViewController(), animated: true)
    }
    
    
}
