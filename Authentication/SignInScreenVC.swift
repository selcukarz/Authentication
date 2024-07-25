//
//  SignInScreenVC.swift
//  Authentication
//
//  Created by Selçuk Arıöz on 24.07.2024.
//

import UIKit
import FirebaseAuth

class SignInScreenVC: UIViewController {

    let emailTextField = UITextField()
    let passwordTextField = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupUI()
    }
    
    func setupUI(){
        let headLabel = UILabel()
        headLabel.text = "Sign In"
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
            make.left.right.equalToSuperview().inset(20)
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

        let logInButton = UIButton()
        logInButton.setTitle("Log In", for: .normal)
        logInButton.backgroundColor = .systemGreen
        logInButton.layer.cornerRadius = 12
        logInButton.addTarget(self, action: #selector(logInButtonTapped), for: .touchUpInside)
        view.addSubview(logInButton)
        logInButton.snp.makeConstraints{make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide).inset(220)
            make.width.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(60)
        }
        
        let backToSignUpLabel = UILabel()
        backToSignUpLabel.text = "Sign up with new account"
        backToSignUpLabel.font = .systemFont(ofSize: 12, weight: .medium)
        backToSignUpLabel.textAlignment = .left
        backToSignUpLabel.textColor = .systemBlue
        backToSignUpLabel.isUserInteractionEnabled = true
        view.addSubview(backToSignUpLabel)
        let signUpTapGesture = UITapGestureRecognizer(target: self, action: #selector(toSignUpScreenTextButtonTapped))
        backToSignUpLabel.addGestureRecognizer(signUpTapGesture)
        backToSignUpLabel.snp.makeConstraints{make in
            make.top.equalTo(logInButton.snp.bottom).offset(10)
            make.leading.equalTo(logInButton.snp.leading)
            make.height.equalTo(25)
        }
        
        let forgotPasswordLabel = UILabel()
        forgotPasswordLabel.text = "Forgot password"
        forgotPasswordLabel.font = .systemFont(ofSize: 12, weight: .medium)
        forgotPasswordLabel.textAlignment = .right
        forgotPasswordLabel.textColor = .systemBlue
        forgotPasswordLabel.isUserInteractionEnabled = true
        view.addSubview(forgotPasswordLabel)
        let resetPasswordTapGesture = UITapGestureRecognizer(target: self, action: #selector(forgotPasswordTextButtonTapped))
        forgotPasswordLabel.addGestureRecognizer(resetPasswordTapGesture)
        forgotPasswordLabel.snp.makeConstraints{make in
            make.top.equalTo(logInButton.snp.bottom).offset(10)
            make.trailing.equalTo(logInButton.snp.trailing)
            make.height.equalTo(25)
        }
    }
    @objc func logInButtonTapped(){
        signIn()
    }
    @objc func toSignUpScreenTextButtonTapped(){
        navigationController?.popViewController(animated: true)
    }
    @objc func forgotPasswordTextButtonTapped(){
        navigationController?.pushViewController(ResetPasswordScreenVC(), animated: true)
    }
}
// MARK: - SignIn Methods
extension SignInScreenVC {
    func verifyUser(){
        if let user = Auth.auth().currentUser {
            if user.isEmailVerified {
                AppUsableScreenVC().navigationItem.hidesBackButton = true
                self.navigationController?.pushViewController(AppUsableScreenVC(), animated: true)
            } else {
                let isEmailVerifiedFalse = UIAlertController(title: "ERROR", message: "Email couldn't verified", preferredStyle: .alert)
                let isEmailVerifiedFalseOkButton = UIAlertAction(title: "OK", style: .default) { action in
                    self.passwordTextField.text = nil
                }
                isEmailVerifiedFalse.addAction(isEmailVerifiedFalseOkButton)
                self.present(isEmailVerifiedFalse, animated: true)

            }
        }
    }
    func signIn(){
        guard let email = emailTextField.text , !email.isEmpty,
              let password = passwordTextField.text, !password.isEmpty else {
            return
        }
        Auth.auth().signIn(withEmail: email  , password: password) { [weak self] authResult, error in
          guard let strongSelf = self else { return }
            guard error == nil else {
                print(error!.localizedDescription)
                let signInFalse = UIAlertController(title: "ERROR", message: "Login Failed", preferredStyle: .alert)
                let signInFalseOkButton = UIAlertAction(title: "OK", style: .default) { action in
                    strongSelf.passwordTextField.text = nil
                    strongSelf.emailTextField.text = nil
                }
                signInFalse.addAction(signInFalseOkButton)
                strongSelf.present(signInFalse, animated: true)
                return
            }
            strongSelf.verifyUser()
        }
    }
}
