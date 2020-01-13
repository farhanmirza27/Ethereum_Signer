//
//  Wallet.swift
//  EthereumSigner
//
//  Created by Farhan Mirza on 07/01/2020.
//  Copyright © 2020 Farhan Mirza. All rights reserved.
//


import UIKit

struct Wallet : Codable {
    let address: String
    let balance : String
    
    init (address : String, balance : String) {
        self.address = address
        self.balance = balance
    }
}



protocol UserWalletRequest : Codable {
    func getPrivateKey() -> String
    func getPublicKey()  -> String
    func getAddress()    -> String
}


struct userWallet : UserWalletRequest {
        
    var privateKey : String
    var publicKey  : String
    var address    : String
    
    func getPrivateKey() -> String {
        return privateKey
    }
    
    func getPublicKey() -> String {
        return publicKey
    }
    
    func getAddress() -> String {
        return address
    }
    
    
}
