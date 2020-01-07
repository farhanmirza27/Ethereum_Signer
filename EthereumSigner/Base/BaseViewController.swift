//
//  BaseViewController.swift
//  EthereumSigner
//
//  Created by Farhan Mirza on 05/01/2020.
//  Copyright © 2020 Farhan Mirza. All rights reserved.
//


import UIKit

class BaseViewController: UIViewController {
    var saveAreaView:UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.AppColor.defaultWhite
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    

    private func setupView() {
        view.addSubview(saveAreaView)
        navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.largeTitleDisplayMode = .always
        self.view.backgroundColor = .white
        
        if #available(iOS 11, *) {
            let guide = view.safeAreaLayoutGuide
            NSLayoutConstraint.activate([
                saveAreaView.topAnchor.constraint(equalTo: guide.topAnchor),
                saveAreaView.bottomAnchor.constraint(equalTo: guide.bottomAnchor),
                saveAreaView.leftAnchor.constraint(equalTo: guide.leftAnchor),
                saveAreaView.rightAnchor.constraint(equalTo: guide.rightAnchor),
                ])
        } else {
            NSLayoutConstraint.activate([
                saveAreaView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
                saveAreaView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
                saveAreaView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),
                saveAreaView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0)
                ])
        }
    }
    
    @objc func dismissCurrentView(tapGestureRecognizer: UITapGestureRecognizer) {
        self.dismissKeyboard()
        self.dismiss(animated: true, completion: nil)
    }
    
    override func loadView() {
        super.loadView()
        view.backgroundColor = UIColor.AppColor.defaultWhite
        setupView()
    }
    
}
