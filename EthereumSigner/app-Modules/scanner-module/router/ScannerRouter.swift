//
//  ScannerRouter.swift
//  EthereumSigner
//
//  Created by Farhan Mirza on 10/01/2020.
//  Copyright © 2020 Farhan Mirza. All rights reserved.
//

import Foundation


class ScannerRouter : PresenterToRouterScannerProtocol {
   
    static func createScannerModule() -> ScannerViewController {
    let view =  ScannerViewController()
                 let presenter: ViewToPresenterScannerProtocol & InteractorToPresenterScannerProtocol = ScannerPresenter()
                 let interactor: PresenterToInteractorScannerProtocol = ScannerInteractor()
                 let router: PresenterToRouterScannerProtocol = ScannerRouter()
                 
                 view.scannerPresenter = presenter
                 presenter.view = view
                 presenter.router = router
                 presenter.interactor = interactor
                 interactor.presenter = presenter
                 return view
        
    }
    
}
