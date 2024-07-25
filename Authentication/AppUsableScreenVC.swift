//
//  AppUsableScreenVC.swift
//  Authentication
//
//  Created by Selçuk Arıöz on 25.07.2024.
//

import UIKit
import SnapKit
import FirebaseAuth

class AppUsableScreenVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI(){
        view.backgroundColor = .systemBackground
        
        let headLabel = UILabel()
        headLabel.text = "Login Successful"
        headLabel.textAlignment = .center
        headLabel.font = .systemFont(ofSize: 26, weight: .bold)
        view.addSubview(headLabel)
        headLabel.snp.makeConstraints{make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide).inset(40)
        }
        
        let logOutButton = UIButton()
        logOutButton.setTitle("Log Out", for: .normal)
        logOutButton.backgroundColor = .systemRed
        logOutButton.layer.cornerRadius = 12
        logOutButton.addTarget(self, action: #selector(logOutButtonTapped), for: .touchUpInside)
        view.addSubview(logOutButton)
        logOutButton.snp.makeConstraints{make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(70)
            make.width.equalTo(view.frame.size.width-120)
            make.height.equalTo(60)
        }
    }
    
    @objc func logOutButtonTapped(){
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            navigationController?.popToRootViewController(animated: true)
        } catch let signOutError as NSError {
          print("Error signing out: %@", signOutError)
        }
    }
}
