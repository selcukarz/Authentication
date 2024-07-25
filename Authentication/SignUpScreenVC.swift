//
//  ViewController.swift
//  Authentication
//
//  Created by Selçuk Arıöz on 24.07.2024.
//
import FirebaseAuth
import UIKit
import SnapKit


class SignUpScreenVC: UIViewController {
    
    let emailTextField = UITextField()
    let passwordTextField = UITextField()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
    }
    func setupUI(){
        
        let headLabel = UILabel()
        headLabel.text = "Sign Up"
        headLabel.font = .systemFont(ofSize: 28, weight: .bold)
        headLabel.textAlignment = .center
        headLabel.textColor = .black
        view.addSubview(headLabel)
        headLabel.snp.makeConstraints{make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.width.equalTo(140)
            make.height.equalTo(50)
        }
        
        emailTextField.placeholder = "Enter Your e-Mail"
        emailTextField.layer.cornerRadius = 12
        emailTextField.layer.borderWidth = 2
        emailTextField.autocapitalizationType = .none
        emailTextField.autocorrectionType = .no
        emailTextField.leftViewMode = .always
        emailTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        emailTextField.backgroundColor = .secondarySystemBackground
        emailTextField.layer.borderColor = UIColor.lightGray.cgColor
        view.addSubview(emailTextField)
        emailTextField.snp.makeConstraints{make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide).inset(100)
            make.width.equalTo(view.frame.size.width-40)
            make.height.equalTo(40)
        }
        
        passwordTextField.isSecureTextEntry = true
        passwordTextField.placeholder = "Enter Your Password"
        passwordTextField.layer.cornerRadius = 12
        passwordTextField.layer.borderWidth = 2
        passwordTextField.leftViewMode = .always
        passwordTextField.autocapitalizationType = .none
        passwordTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        passwordTextField.backgroundColor = .secondarySystemBackground
        passwordTextField.layer.borderColor = UIColor.lightGray.cgColor
        view.addSubview(passwordTextField)
        passwordTextField.snp.makeConstraints{make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide).inset(160)
            make.width.equalTo(view.frame.size.width-40)
            make.height.equalTo(40)
        }

        let registerButton = UIButton()
        registerButton.setTitle("Register", for: .normal)
        registerButton.backgroundColor = .systemYellow
        registerButton.layer.cornerRadius = 12
        registerButton.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
        view.addSubview(registerButton)
        registerButton.snp.makeConstraints{make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide).inset(220)
            make.width.equalTo(view.frame.size.width-40)
            make.height.equalTo(60)
        }
        
        let signInLabel = UILabel()
        signInLabel.text = "Have you registered before?"
        signInLabel.font = .systemFont(ofSize: 12, weight: .medium)
        signInLabel.textAlignment = .center
        signInLabel.textColor = .systemBlue
        signInLabel.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(toLoginScreenTextButtonTapped))
        signInLabel.addGestureRecognizer(tapGesture)
        view.addSubview(signInLabel)
        signInLabel.snp.makeConstraints{make in
            make.centerX.equalToSuperview()
            make.top.equalTo(registerButton.snp.bottom).offset(10)
            make.width.equalTo(200)
            make.height.equalTo(30)
        }
    }
    
    @objc func registerButtonTapped(){
        guard let email = emailTextField.text , !email.isEmpty,
              let password = passwordTextField.text, !password.isEmpty else {
            print("Invalid Email Type or Something Else")
            return
        }
        createUserWithEmailAndPassword(Email: email, Password: password)
        navigationController?.pushViewController(VerifyScreenVC(), animated: true)
    }
    @objc func toLoginScreenTextButtonTapped(){
        navigationController?.pushViewController(SignInScreenVC(), animated: true)
    }
    
}

extension SignUpScreenVC {
    func createUserWithEmailAndPassword(Email:String , Password: String){
        Auth.auth().createUser(withEmail: Email, password: Password) { authResult, error in
            guard error == nil else {
                print(error!.localizedDescription)
                return
            }
        }
    }
    
}
