//
//  AccountInteractor.swift
//  EthereumSigner
//
//  Created by Farhan Mirza on 07/01/2020.
//  Copyright © 2020 Farhan Mirza. All rights reserved.
//

import Foundation



class AccountInteractor: PresenterToInteractorAccountProtocol{
  
    var presenter: InteractorToPresenterAccountProtocol?
    
    func fetchAccountBalance() {
    // use Ethereum Client to fetch info
        presenter?.fetchAccountBalanceSuccess()
       }
    
}
