//
//  ViewController.swift
//  CuteLogin
//
//  Created by Dragonborn on 13.12.2020.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var formContainerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLoginButton()
        setupFormContainer()
    }

    func setupLoginButton() {
        loginButton.layer.cornerRadius = loginButton.frame.width / 2
    }
    
    func setupFormContainer() {
        formContainerView.layer.cornerRadius = 16.0
    }
}

