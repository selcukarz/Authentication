//
//  ResetPasswordScreenVC.swift
//  Authentication
//
//  Created by Selçuk Arıöz on 25.07.2024.
//

import UIKit
import FirebaseAuth

class ResetPasswordScreenVC: UIViewController {
    
    let emailTextField = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI(){
        view.backgroundColor = .systemBackground
        
        let headLabel = UILabel()
        headLabel.text = "Reset Password"
        headLabel.font = .systemFont(ofSize: 28, weight: .bold)
        headLabel.textAlignment = .center
        headLabel.textColor = .black
        view.addSubview(headLabel)
        headLabel.snp.makeConstraints{make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.width.equalTo(250)
            make.height.equalTo(50)
        }

        emailTextField.placeholder = "Enter Your Email For Reset Password"
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
            make.top.equalTo(view.safeAreaLayoutGuide).inset(150)
            make.width.equalTo(view.frame.size.width-40)
            make.height.equalTo(40)
        }
        
        let resetPasswordButton = UIButton()
        resetPasswordButton.setTitle("Reset", for: .normal)
        resetPasswordButton.backgroundColor = .systemGray
        resetPasswordButton.layer.cornerRadius = 12
        resetPasswordButton.addTarget(self, action: #selector(resetPasswordButtonTapped), for: .touchUpInside)
        view.addSubview(resetPasswordButton)
        resetPasswordButton.snp.makeConstraints{make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide).inset(220)
            make.width.equalTo(view.frame.size.width-40)
            make.height.equalTo(60)
        }

    }
    
    @objc func resetPasswordButtonTapped(){
        guard let email = emailTextField.text , !email.isEmpty else {
            print("reset ")
            return
        }
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            guard error == nil else {
                print(error!.localizedDescription)
                return
            }
            print("şifre geldi")
            self.resetPasswordAction()
        }
    }
    
    func resetPasswordAction(){
        let resetPasswordAciton = UIAlertController(title: "Reset Password", message: "Check Your Email", preferredStyle: .alert)
        let resetPasswordOkButton = UIAlertAction(title: "OK", style: .default) { action in
            self.navigationController?.popViewController(animated: true)
        }
        resetPasswordAciton.addAction(resetPasswordOkButton)
        self.present(resetPasswordAciton, animated: true)

    }
}
