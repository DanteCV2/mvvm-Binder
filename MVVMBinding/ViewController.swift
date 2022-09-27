//
//  ViewController.swift
//  MVVMBinding
//
//  Created by Dante Vega on 23/09/22.
//

import UIKit

class ViewController: UIViewController {
    
    private var loginVM = LoginViewModel()
    
    lazy var userNameTesxtField: UITextField = {
        let userNameTesxtField = BindingTextField()
        userNameTesxtField.placeholder = "Enter Username"
        userNameTesxtField.backgroundColor = .lightGray
        userNameTesxtField.borderStyle = .roundedRect
        userNameTesxtField.bind { [weak self] text in
            self?.loginVM.username.value = text
        }
        return userNameTesxtField
    }()
    
    lazy var passwordTextField: UITextField = {
        let passwordTextField = BindingTextField()
        passwordTextField.isSecureTextEntry = true
        passwordTextField.placeholder = "Enter password"
        passwordTextField.backgroundColor = .lightGray
        passwordTextField.borderStyle = .roundedRect
        passwordTextField.bind { [weak self] text in
            self?.loginVM.password.value = text
        }
        return passwordTextField
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginVM.username.bind { [weak self] text in
            self?.userNameTesxtField.text = text
        }
        loginVM.password.bind { [weak self] text in
            self?.passwordTextField.text = text
        }
        setupUI()
    }
    
    private func setupUI() {
        
        let loginButton = UIButton()
        loginButton.setTitle("login", for: .normal)
        loginButton.backgroundColor = .gray
        loginButton.addTarget(self, action: #selector(login), for: .touchUpInside)
        
        let loginButton2 = UIButton()
        loginButton2.setTitle("login", for: .normal)
        loginButton2.backgroundColor = .gray
        loginButton2.addTarget(self, action: #selector(fetchLogin), for: .touchUpInside)
        
        let stackView = UIStackView(arrangedSubviews: [userNameTesxtField, passwordTextField, loginButton, loginButton2])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.distribution = .fillEqually
        
        self.view.addSubview(stackView)
        
        stackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        stackView.widthAnchor.constraint(equalToConstant: 200).isActive = true
    }
    
    @objc private func login() {
        print(loginVM.username)
        print(loginVM.password)
    }
    
    @objc private func fetchLogin() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
            self?.loginVM.username.value = "VMVBinding"
            self?.loginVM.password.value = "123"
        }
    }
}
