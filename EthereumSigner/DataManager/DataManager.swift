//
//  DataManager.swift
//  EthereumSigner
//
//  Created by Farhan Mirza on 13/01/2020.
//  Copyright © 2020 Farhan Mirza. All rights reserved.
//

import Foundation

class DataManager {
 
   static let shared = DataManager()
  
    
    // Save Data
    func save<T : Encodable>(obj:T,forKey: String){
        let json = obj.json
        UserDefaults.standard.set(json, forKey: forKey)
        UserDefaults.standard.synchronize()
    }

    // Get Info
    func find<T : Decodable>(type: T.Type, forKey: String) -> T? {
        if let json = UserDefaults.standard.string(forKey: forKey){
            return try! JSONDecoder.decoder.decode(type, from: Data(json.utf8))
        }
        return nil
    }

  
    func savePrivateKey(key : String) {
        UserDefaults.standard.set(key, forKey: "PrivateKey")
    }
    
    func getPrivateKey() -> String {
        return UserDefaults.standard.string(forKey: "PrivateKey") ?? ""
    }
    
    func saveWalletAddress(address : String) {
        UserDefaults.standard.set(address, forKey: "walletAddress")
    }
    
    func getsaveWalletAddress() -> String {
        return UserDefaults.standard.string(forKey: "walletAddress") ?? ""
    }
    
    func clearAllSavedData() {
    func resetDefaults() {
        let defaults = UserDefaults.standard
        let dictionary = defaults.dictionaryRepresentation()
        dictionary.keys.forEach { key in
            defaults.removeObject(forKey: key)
        }
    }
    }
}
