//
//  VerifyScreenVC.swift
//  Authentication
//
//  Created by Selçuk Arıöz on 24.07.2024.
//

import UIKit
import FirebaseAuth

class VerifyScreenVC: UIViewController {
        
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI(){
        view.backgroundColor = .white
        
        let label = UILabel()
        label.text = "Please Check Your Email"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.numberOfLines = 1
        label.sizeToFit()
        view.addSubview(label)
        label.snp.makeConstraints{make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide).inset(70)
//            make.width.equalTo(300)
//            make.height.equalTo(50)
        }
        
        let verifyButton = UIButton()
        verifyButton.setTitle("Verify Email", for: .normal)
        verifyButton.backgroundColor = .systemYellow
        verifyButton.layer.cornerRadius = 12
        verifyButton.addTarget(self, action: #selector(verifyButtonTapped), for: .touchUpInside)
        view.addSubview(verifyButton)
        verifyButton.snp.makeConstraints{make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.equalTo(view.frame.size.width-120)
            make.height.equalTo(60)
        }
    }
    
    @objc func verifyButtonTapped(){
        Auth.auth().currentUser?.sendEmailVerification { error in
            guard error == nil else {
                print(error!.localizedDescription)
                return
            }
        }
        navigationController?.popViewController(animated: true)
    }
}
