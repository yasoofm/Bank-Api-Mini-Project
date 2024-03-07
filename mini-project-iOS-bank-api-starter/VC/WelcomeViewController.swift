//
//  ViewController.swift
//  mini-project-iOS-bank-api-starter
//
//  Created by Nawaf Almutairi on 05/03/2024.
//

import UIKit
import SnapKit

class WelcomeViewController: UIViewController {
    
    let imageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = #colorLiteral(red: 0.1019607843, green: 0.1019607843, blue: 0.1019607843, alpha: 1)
        
        setupNavBar()
        
        view.addSubview(imageView)
        imageView.image = UIImage(named: "logo")
        imageView.contentMode = .scaleAspectFit
        imageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(400)
        }

        // Create Sign Up Button
        let signUpButton = UIButton()
        signUpButton.setTitle("Sign Up", for: .normal)
        signUpButton.backgroundColor = #colorLiteral(red: 0.537254902, green: 0.537254902, blue: 0.537254902, alpha: 1)
        signUpButton.layer.cornerRadius = 5
        signUpButton.layer.shadowColor = UIColor.black.cgColor
        signUpButton.layer.shadowOpacity = 0.5
        signUpButton.layer.shadowOffset = CGSize(width: 0, height: 2)
        signUpButton.layer.shadowRadius = 4
        signUpButton.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
        view.addSubview(signUpButton)

        // Create Login Button
        let loginButton = UIButton()
        loginButton.setTitle("Login", for: .normal)
        loginButton.backgroundColor = #colorLiteral(red: 0.537254902, green: 0.537254902, blue: 0.537254902, alpha: 1)
        loginButton.layer.cornerRadius = 5
        loginButton.layer.shadowColor = UIColor.black.cgColor
        loginButton.layer.shadowOpacity = 0.5
        loginButton.layer.shadowOffset = CGSize(width: 0, height: 2)
        loginButton.layer.shadowRadius = 4
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        view.addSubview(loginButton)

        // Apply SnapKit Constraints
        signUpButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-50)
            make.centerX.equalToSuperview()
            make.width.equalTo(200)
            make.height.equalTo(50)
        }

        loginButton.snp.makeConstraints { make in
            make.bottom.equalTo(signUpButton.snp.top).offset(-20)
            make.centerX.equalToSuperview()
            make.width.equalTo(200)
            make.height.equalTo(50)
        }
    }

    @objc func signUpButtonTapped() {
        // Handle Sign In Button Tap
        navigationController?.pushViewController(SignUpViewController(), animated: true)
    }

    @objc func loginButtonTapped() {
        // Handle Login Button Tap
        navigationController?.pushViewController(SignInViewController(), animated: true)
    }
    
    func setupNavBar(){
        let appearance = UINavigationBarAppearance()
        appearance.configureWithDefaultBackground()
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
}
