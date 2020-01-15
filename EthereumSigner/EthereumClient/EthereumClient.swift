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
    
    func importAccount(privateKey : String, password : String,_ responseHandler:@escaping ResponseHandler<Wallet>,_ errorHandler:@escaping ErrorHandler)
   
    func fetchAccountBalance(address : String,_ responseHandler:@escaping ResponseHandler<Account>,_ errorHandler:@escaping ErrorHandler)
    
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
    func fetchAccountBalance(address : String,_ responseHandler: @escaping ResponseHandler<Account>, _ errorHandler: @escaping ErrorHandler) {
        let address = EthereumAddress(address)
        if let walletAddress = address {
            let balanceResult = try! web3RinkeBy.eth.getBalance(address: walletAddress)
            let balance = Web3.Utils.formatToEthereumUnits(balanceResult, toUnits: .eth, decimals: 3)!
            let account = Account(address: walletAddress.address, balance: balance)
            responseHandler(account)
        }
        else {
           errorHandler(NSError())
        }
        
    }
    
    
    // Import account with private key
    func importAccount(privateKey: String, password : String, _ responseHandler: @escaping ResponseHandler<Wallet>, _ errorHandler: @escaping ErrorHandler) {
          
        let formattedKey = privateKey.trimmingCharacters(in: .whitespacesAndNewlines)
       
        if let dataKey = Data.fromHex(formattedKey) {
                      if let keystore = try! EthereumKeystoreV3(privateKey: dataKey, password: password) {
                          let name = "new wallet"
                          let keyData = try! JSONEncoder().encode(keystore.keystoreParams)
                          let address = keystore.addresses!.first!.address
                          let wallet = Wallet(address: address, data: keyData, name: name, isHD: false)

                          
                          // Save wallet address to fetch account balance
                         DataManager.shared.saveWalletAddress(address: address)
                        
                          let data = keyData
                          let keystoreManager: KeystoreManager
                          if wallet.isHD {
                              let keystore = BIP32Keystore(data)!
                              keystoreManager = KeystoreManager([keystore])
                          } else {
                              let keystore = EthereumKeystoreV3(data)!
                              keystoreManager = KeystoreManager([keystore])
                          }
                          web3RinkeBy.addKeystoreManager(keystoreManager)
                          responseHandler(wallet)
                      }
                      else {
                          errorHandler(NSError())
            }
        }
        else {
        errorHandler(NSError())
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
            responseHandler(privateKey)
        } catch let error {
            print(error.localizedDescription)
            errorHandler(error)
        }
    }
    
    
    // Verify Signature
    func verifySignatureWithPublicKey(message: String, _ responseHandler: @escaping ResponseHandler<Bool>, _ errorHandler: @escaping ErrorHandler) {
        
        getEthereumPrivateKey(keyString: DataManager.shared.getPrivateKey(), { result in
            
            // sign message with user private key
            // save signature which need to be verified
            // retrieve public key
            
            if let signedMessage = try? result.sign(message: message.makeBytes()) {
                let v = EthereumQuantity(integerLiteral: UInt64(signedMessage.v))
                let r = EthereumQuantity(signedMessage.r)
                let s = EthereumQuantity(signedMessage.s)
                
                if let publicKey = try? EthereumPublicKey(message: message.makeBytes(), v: v, r: r, s: s) {
                    DataManager.shared.save(obj: Signature(address: publicKey.address.hex(eip55: false), message: message, key: publicKey.hex()), forKey: "VerifySignature")
                    responseHandler(true)
                // match this address with address fetched from QR code
                }
            }
            
            
            
        }) { error in
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

