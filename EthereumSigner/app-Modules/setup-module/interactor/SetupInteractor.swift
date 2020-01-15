//
//  SetupInteractor.swift
//  EthereumSigner
//
//  Created by Farhan Mirza on 07/01/2020.
//  Copyright © 2020 Farhan Mirza. All rights reserved.
//

import Foundation

class SetupInteractor: PresenterToInteractorProtocol{
 
    var presenter: InteractorToPresenterProtocol?
    
       func importAccount(privateKey: String) {
        // In future password should be user provodid
        EthereumClient.shared.importAccount(privateKey: privateKey, password: "", {  result in
            self.presenter?.importAccountSuccess()
        }) {  error in
            // handle error
            self.presenter?.importAccountFail()
        }
     }
     
}


