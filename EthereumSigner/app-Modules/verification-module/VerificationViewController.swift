//
//  VerificationViewController.swift
//  EthereumSigner
//
//  Created by Farhan Mirza on 06/01/2020.
//  Copyright © 2020 Farhan Mirza. All rights reserved.
//

import UIKit

class VerificationViewController: BaseViewController {

      let messageTF = UIComponents.shared.textField(placeHolder: "Your Message")
     let verifyButton = UIComponents.shared.button(text: "Verify Message")
     
     
     override func viewDidLoad() {
         super.viewDidLoad()
         navigationItem.title = "Verification"
         
         saveAreaView.addSubViews(views: messageTF,verifyButton)
         saveAreaView.addHConstraint(leftInset: 30, rightInset: 30, view: messageTF)
         saveAreaView.addHConstraint(leftInset: 30, rightInset: 30, view: verifyButton)
         saveAreaView.addConstraintsWithFormat("V:|-40-[v0(50)]-30-[v1(45)]", views: messageTF, verifyButton)
         
         // Target
         verifyButton.addTarget(self, action: #selector(signMessage), for: .touchUpInside)
     }
     
    @objc func signMessage() {
     self.navigationController?.pushViewController(ScannerViewController(), animated: true)
     }
}
