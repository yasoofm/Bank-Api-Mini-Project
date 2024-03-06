//
//  ViewController.swift
//  mini-project-iOS-bank-api-starter
//
//  Created by Nawaf Almutairi on 05/03/2024.
//

import UIKit
import SnapKit

class WelcomeViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white

        // Create Sign In Button
        let signInButton = UIButton()
        signInButton.setTitle("Sign In", for: .normal)
        signInButton.setTitleColor(.white, for: .normal)
        signInButton.backgroundColor = .systemGray3
        signInButton.addTarget(self, action: #selector(signInButtonTapped), for: .touchUpInside)
        view.addSubview(signInButton)

        // Create Login Button
        let loginButton = UIButton()
        loginButton.setTitle("Login", for: .normal)
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.backgroundColor = .systemGray3
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        view.addSubview(loginButton)

        // Apply SnapKit Constraints
        signInButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-50)
            make.centerX.equalToSuperview()
            make.width.equalTo(200)
            make.height.equalTo(50)
        }

        loginButton.snp.makeConstraints { make in
            make.bottom.equalTo(signInButton.snp.top).offset(-20)
            make.centerX.equalToSuperview()
            make.width.equalTo(200)
            make.height.equalTo(50)
        }
    }

    @objc func signInButtonTapped() {
        // Handle Sign In Button Tap
        print("signup pressed")
    }

    @objc func loginButtonTapped() {
        // Handle Login Button Tap
        print("login pressed")
    }
}
