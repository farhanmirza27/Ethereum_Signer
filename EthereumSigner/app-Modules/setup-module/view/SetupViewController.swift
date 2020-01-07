//
//  ViewController.swift
//  EthereumSigner
//
//  Created by Farhan Mirza on 05/01/2020.
//  Copyright © 2020 Farhan Mirza. All rights reserved.
//

import UIKit

class SetupViewController: BaseViewController {
    
    let privateKeyTF = UIComponents.shared.textField(placeHolder: "Private Key")
    
    var presenter: ViewToPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView() {
        // Do any additional setup after loading the view.
        self.navigationItem.title = "Setup"
        privateKeyTF.delegate = self
        saveAreaView.addSubview(privateKeyTF)
        saveAreaView.addHConstraint(leftInset: 30, rightInset: 30, view: privateKeyTF)
        saveAreaView.addConstraintsWithFormat("V:|-20-[v0(50)]", views: privateKeyTF)
    }
}

extension SetupViewController : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        // Navigate to account controller
        presenter?.showAccountController(navigationController: self.navigationController!)
        return true
    }
}


extension SetupViewController :  PresenterToViewProtocol {
}
