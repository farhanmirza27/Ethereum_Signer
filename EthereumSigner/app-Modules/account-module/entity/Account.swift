//
//  Account.swift
//  EthereumSigner
//
//  Created by Farhan Mirza on 07/01/2020.
//  Copyright © 2020 Farhan Mirza. All rights reserved.
//


import UIKit

protocol  AccountRequest : Codable  {
    func  getBalance() -> String
    func  getAddress() -> String
}



struct Account  : AccountRequest{
    let address: String
    var balance : String
    
    func getBalance() -> String {
        return balance 
    }
    
    func getAddress() -> String {
        return address
    }
}


