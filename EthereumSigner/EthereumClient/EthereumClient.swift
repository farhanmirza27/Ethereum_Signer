//
//  EthereumClient.swift
//  EthereumSigner
//
//  Created by Farhan Mirza on 06/01/2020.
//  Copyright © 2020 Farhan Mirza. All rights reserved.
//

import UIKit
import web3swift

class EthereumClient {
    
    static let shared = EthereumClient()
    
    let web3 = Web3.InfuraRinkebyWeb3()
    
 
 
    
    
    func savePrivateKey(key : String) {
    UserDefaults.standard.set(key, forKey: "PrivateKey")
    }
    
    func getPrivateKey() -> String {
    return UserDefaults.standard.string(forKey: "PrivateKey") ?? ""
    }
    

    func saveWallet(wallet : Wallet) {
     UserDefaults.standard.set(wallet, forKey: "Wallet")
    }
    
    func getWallet() -> Wallet {
        return UserDefaults.standard.object(forKey: "Wallet") as! Wallet
    }
    
    func saveWalletAddress(address : String) {
    UserDefaults.standard.set(address, forKey: "WalletAddress")
    }
    
    func getWalletAddress() -> String {
    return UserDefaults.standard.string(forKey: "WalletAddress") ?? ""
    }
    
    func getBalance(address : String) -> String {

    let address = EthereumAddress(address)
        if let etAddress = address {
            let balanceResult = try! web3.eth.getBalance(address: etAddress)
            let balanceString = Web3.Utils.formatToEthereumUnits(balanceResult, toUnits: .eth, decimals: 3)!
            return balanceString
        }
    return ""
    }
    
    
    func signMessage(message : String , address : String) -> Data? {
    // unlock account first
    let result = try? web3.personal.signPersonalMessage(message:  message.data(using: .utf8)! ,from: EthereumAddress(getWalletAddress())!)
    return result
    }
    

    
    func importAccount() {
        let password = "web3swift"
        let key = "c7088f91d69929f85e6ee0778b95dca2d4944110730823fb95783ad1266bc256" // Some private key
        let formattedKey = key.trimmingCharacters(in: .whitespacesAndNewlines)
        let dataKey = Data.fromHex(formattedKey)!
        let keystore = try! EthereumKeystoreV3(privateKey: dataKey, password: password)!
        let name = "New Wallet"
        let keyData = try! JSONEncoder().encode(keystore.keystoreParams)
        let address = keystore.addresses!.first!.address
        let wallet = Wallet(address: address, data: keyData, name: name, isHD: false)
        saveWalletAddress(address: wallet.address)
        
        let data = wallet.data
               let keystoreManager: KeystoreManager
               if wallet.isHD {
                   let keystore = BIP32Keystore(data)!
                   keystoreManager = KeystoreManager([keystore])
               } else {
                   let keystore = EthereumKeystoreV3(data)!
                   keystoreManager = KeystoreManager([keystore])
               }
        web3.addKeystoreManager(keystoreManager)
        
    }
    
    
    func createAccount() {
        let password = "web3swift" // We recommend here and everywhere to use the password set by the user.
        let keystore = try! EthereumKeystoreV3(password: password)!
        let name = "New Wallet"
        let keyData = try! JSONEncoder().encode(keystore.keystoreParams)
        let address = keystore.addresses!.first!.address
        let wallet = Wallet(address: address, data: keyData, name: name, isHD: false)
  
        
        let data = wallet.data
        let keystoreManager: KeystoreManager
        if wallet.isHD {
            let keystore = BIP32Keystore(data)!
            keystoreManager = KeystoreManager([keystore])
        } else {
            let keystore = EthereumKeystoreV3(data)!
            keystoreManager = KeystoreManager([keystore])
        }

        
        let ethereumAddress = EthereumAddress(wallet.address)!
        let pkData = try! keystoreManager.UNSAFE_getPrivateKeyData(password: password, account: ethereumAddress).toHexString()
        print(pkData)
    }
    
    
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
