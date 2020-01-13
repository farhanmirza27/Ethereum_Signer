//
//  EthereumClient.swift
//  EthereumSigner
//
//  Created by Farhan Mirza on 06/01/2020.
//  Copyright © 2020 Farhan Mirza. All rights reserved.
//

import UIKit
import Web3
import web3swift


typealias ResponseHandler<T> = (T) -> Void

typealias ErrorHandler = (Error) -> Void


protocol EthereumClientProtocol {
    func fetchAccountBalance(address : String,_ responseHandler:@escaping ResponseHandler<Wallet>,_ errorHandler:@escaping ErrorHandler)
    func signMessageWithPrivateKey(message : String, privateKey : String, _ responseHandler:@escaping ResponseHandler<Bool>,_ errorHandler:@escaping ErrorHandler)
    func getEthereumPrivateKey(keyString : String,_ responseHandler:@escaping ResponseHandler<EthereumPrivateKey>,_ errorHandler:@escaping ErrorHandler)
    func verifySignatureWithPublicKey(message : String,_ responseHandler:@escaping ResponseHandler<Bool>,_ errorHandler:@escaping ErrorHandler)
    
}



// Ethereum client
// Handle all request for ethereum

class EthereumClient : EthereumClientProtocol {
    
    static let shared = EthereumClient()
    
    let web3RinkeBy =  Web3.InfuraRinkebyWeb3()

    
    // Fetch account balance from RinkeBy
    func fetchAccountBalance(address : String,_ responseHandler: @escaping ResponseHandler<Wallet>, _ errorHandler: @escaping ErrorHandler) {
        let address = EthereumAddress(address)
        if let walletAddress = address {
            let balanceResult = try! web3RinkeBy.eth.getBalance(address: walletAddress)
            let balance = Web3.Utils.formatToEthereumUnits(balanceResult, toUnits: .eth, decimals: 3)!
            let wallet = Wallet(address: walletAddress.address, balance: balance)
            responseHandler(wallet)
        }
        else {
            // handle error
        }
        
    }
    
    
    // Sign message with user provided private key
    func signMessageWithPrivateKey(message: String, privateKey: String, _ responseHandler: @escaping ResponseHandler<Bool>, _ errorHandler: @escaping ErrorHandler) {
        // User user private key
        // Convert message to bytes
        
        getEthereumPrivateKey(keyString: privateKey, { result  in
            
            let privateKey = result
            do {
                let _ = try privateKey.sign(message: message.makeBytes())
                // save signature
                DataManager.shared.save(obj: Signature(address: privateKey.address.hex(eip55: false), message: message), forKey: "Signature")
                responseHandler(true)
            } catch let error {
                print(error.localizedDescription)
                errorHandler(error)
            }
            
        }) { error in
            print(error)
            errorHandler(error)
        }
        
    }
    
    
    // Get Etherum Public Key from user provided private key string
    func getEthereumPrivateKey(keyString: String, _ responseHandler: @escaping ResponseHandler<EthereumPrivateKey>, _ errorHandler: @escaping ErrorHandler) {
        do {
            let privateKey = try EthereumPrivateKey(hexPrivateKey: keyString)
            // save User Wallet info
            DataManager.shared.saveWalletAddress(address: privateKey.address.hex(eip55: false))
            DataManager.shared.save(obj: userWallet(privateKey: privateKey.hex(), publicKey: privateKey.publicKey.hex(), address: privateKey.publicKey.hex()), forKey: "UserWallet")
            responseHandler(privateKey)
        } catch let error {
            print(error.localizedDescription)
            errorHandler(error)
        }
    }
    
    
    // Verify Signature
    func verifySignatureWithPublicKey(message: String, _ responseHandler: @escaping ResponseHandler<Bool>, _ errorHandler: @escaping ErrorHandler) {
        
        // sign message with user private key
        // save signature which need to be verified
        signMessageWithPrivateKey(message: message, privateKey: DataManager.shared.getPrivateKey(), { result in
        // save signature for message need to be verified
        
        }) { (error) in
            errorHandler(error)
        }
    }
    
    // Generate QR Code
    func generateQRCode(from string : String) -> UIImage? {
        let data = string.data(using: String.Encoding.ascii)
        if let filter = CIFilter(name: "CIQRCodeGenerator") {
            filter.setValue(data, forKey: "inputMessage")
            let transform = CGAffineTransform(scaleX: 3, y: 3)
            
            if let output = filter.outputImage?.transformed(by: transform) {
                return UIImage(ciImage: output)
            }
        }
        return nil
    }
    
    
}

