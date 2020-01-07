//
//  AccountViewController.swift
//  EthereumSigner
//
//  Created by Farhan Mirza on 05/01/2020.
//  Copyright © 2020 Farhan Mirza. All rights reserved.
//

import UIKit

class AccountViewController: BaseViewController {
    
    let infoContainer = UIComponents.shared.container(bgColor: .clear, cornerRadius: 0, addShadow: true)
    let addressLabel =  UIComponents.shared.label(alignment : .right)
    let balanceLabel =  UIComponents.shared.label(alignment : .right)
    
    let signButton = UIComponents.shared.button(text: "Sign")
    let verifyButton = UIComponents.shared.button(text: "Verify")
    
    var accountPresenter: ViewToPresenterAccountProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        accountPresenter!.fetchAccountBalance()
        
        self.navigationItem.title = "Account"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(logout))
        
        infoContainer.addSubViews(views: addressLabel, balanceLabel)
        infoContainer.addHConstraint(leftInset: 30, rightInset: 30, view: addressLabel)
        infoContainer.addHConstraint(leftInset: 30, rightInset: 30, view: balanceLabel)
        infoContainer.addConstraintsWithFormat("V:|[v0]-16-[v1]|", views: addressLabel,balanceLabel)
        
        // Do any additional setup after loading the view.
        saveAreaView.addSubViews(views: infoContainer,signButton,verifyButton)
        saveAreaView.addHConstraint(leftInset: 16, rightInset: 16, view: infoContainer)
        saveAreaView.addHConstraint(leftInset: 40, rightInset: 40, view: signButton)
        saveAreaView.addHConstraint(leftInset: 40, rightInset: 40, view: verifyButton)
        saveAreaView.addConstraintsWithFormat("V:|-30-[v0]", views: infoContainer)
        saveAreaView.addConstraintsWithFormat("V:[v0(45)]-8-[v1(45)]-50-|", views: signButton,verifyButton)
        
        // Add Targets
        signButton.addTarget(self, action: #selector(navigateToSign), for: .touchUpInside)
        verifyButton.addTarget(self, action: #selector(navigateToVerify), for: .touchUpInside)
        
        addressLabel.text = EthereumClient.shared.getWalletAddress()
        balanceLabel.text = EthereumClient.shared.getBalance(address: EthereumClient.shared.getWalletAddress())
        
    }
    
    
    @objc func navigateToSign() {
        accountPresenter?.showSigningController(navigationController: self.navigationController!)
    }
    
    @objc func navigateToVerify() {
        accountPresenter?.showVerificationController(navigationController: self.navigationController!)
    }
    
    @objc func logout() {
        accountPresenter?.performLogout(navigationController: navigationController!)
    }
}


extension AccountViewController : PresenterToViewAccountProtocol {
    func fetchBalance() {
    /// fetch balance
    }
}

