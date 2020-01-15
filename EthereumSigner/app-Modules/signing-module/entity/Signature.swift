//
//  Signature.swift
//  EthereumSigner
//
//  Created by Farhan Mirza on 12/01/2020.
//  Copyright © 2020 Farhan Mirza. All rights reserved.
//

import Web3

protocol  SignatureRequest : Codable  {
    func  getMessage() -> String
    func  getAddress() -> String
    func  getPublicKey() -> String
}

struct Signature :  SignatureRequest {
  
    
    var address : String
    var message : String
    var key     : String?
    
    func getMessage() -> String {
        return message
    }
    
    func getAddress() -> String {
        return address
    }
    
    func getPublicKey() -> String {
        return key ?? ""
      }
      
      
    
    
}


