//
//  SignInViewController.swift
//  mini-project-iOS-bank-api-starter
//
//  Created by yousef mandani on 06/03/2024.
//

import UIKit
import SnapKit
import Alamofire
import Eureka

class SignInViewController: FormViewController {

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupForm()
        setupNavigation()
    }

    // MARK: - Setup

    private func setupForm() {
        form +++ Section("Sign In")
            <<< TextRow() { row in
                row.title = "Username"
                row.placeholder = "Enter your username"
                row.tag = "username"
//            }.onChange { [weak self] row in
//               
            }

            <<< PasswordRow() { row in
                row.title = "Password"
                row.placeholder = "Enter your password"
                row.tag = "password"
//            }.onChange { [weak self] row in
//             
            }
       
    }

    private func setupNavigation() {
        navigationItem.title = "Sign In"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Sign In", style: .plain, target: self, action: #selector(signinButtonTapped))
    }

    // MARK: - Actions

    @objc private func signinButtonTapped() {
        guard let usernameRow = form.rowBy(tag: "username") as? TextRow,
              let passwordRow = form.rowBy(tag: "password") as? PasswordRow,
              let username = usernameRow.value,
              let password = passwordRow.value else {
            // Handle invalid input
            return
        }
        
        
        
        let user = User(username: username, email: "", password: password)
                
                NetworkManager.shared.signin(user: user) { result in
                    switch result {
                    case .success(let tokenResponse):
                        
                        print("Sign in successful. Token: \(tokenResponse.token)")
                        DispatchQueue.main.async {
                           
                                            
                            let vC = ProfileViewController()
                            vC.token = tokenResponse.token
                            self.navigationController?.pushViewController(vC, animated: true)

                        }
                    case .failure(let error):
                        
                        print("Sign in failed with error: \(error.localizedDescription)")
                        DispatchQueue.main.async {
                        }
                    }
                }
            }}
