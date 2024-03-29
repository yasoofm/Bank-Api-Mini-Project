//
//  SignupPageViewController.swift
//  mini-project-iOS-bank-api-starter
//
//  Created by yousef mandani on 06/03/2024.
//

import UIKit
import Eureka

class SignUpViewController: FormViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.backgroundColor = #colorLiteral(red: 0.1019607843, green: 0.1019607843, blue: 0.1019607843, alpha: 1)
        navigationItem.title = "Sign Up"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "arrowshape.right.fill"), style: .plain, target: self, action: #selector(signUp))
        navigationController?.navigationBar.tintColor = .black
        navigationItem.rightBarButtonItem?.tintColor = #colorLiteral(red: 0.1019607843, green: 0.1019607843, blue: 0.1019607843, alpha: 1)
        form +++ Section()
        <<< TextRow{ row in
            row.title = "Username"
            row.placeholder = "Enter your username"
            row.placeholderColor = .gray
            row.tag = "\(Tag.username)"
            row.add(rule: RuleRequired())
            row.validationOptions = .validatesOnChange
            row.cellUpdate { cell, row in
                cell.backgroundColor = #colorLiteral(red: 0.8352941275, green: 0.8352941275, blue: 0.8352941275, alpha: 1)
                if !row.isValid{
                    cell.titleLabel?.textColor = .red
                }
            }
        }
        <<< TextRow{ row in
            row.title = "Password"
            row.placeholder = "Enter your password"
            row.tag = "\(Tag.password)"
            row.placeholderColor = .gray
            row.add(rule: RuleRequired())
            row.validationOptions = .validatesOnChange
            row.cellUpdate { cell, row in
                cell.backgroundColor = #colorLiteral(red: 0.8352941275, green: 0.8352941275, blue: 0.8352941275, alpha: 1)
                if !row.isValid{
                    cell.titleLabel?.textColor = .red
                }
            }
        }
        <<< EmailRow{ row in
            row.title = "Email"
            row.placeholder = "Enter your email"
            row.placeholderColor = .gray
            row.tag = "\(Tag.email)"
            row.add(rule: RuleRequired())
            row.validationOptions = .validatesOnChange
            row.cellUpdate { cell, row in
                cell.backgroundColor = #colorLiteral(red: 0.8352941275, green: 0.8352941275, blue: 0.8352941275, alpha: 1)
                if !row.isValid{
                    cell.titleLabel?.textColor = .red
                }
            }
        }
    }
    @objc func signUp(){
        let errors = form.validate()
        guard errors.isEmpty else{
            presentAlertWithTitle(title: "🚨", message: "\(errors.count) fields are missing")
            return
        }
                
        let usernameRow: TextRow? = form.rowBy(tag: "\(Tag.username)")
        let passwordRow: TextRow? = form.rowBy(tag: "\(Tag.password)")
        let emailRow: EmailRow? = form.rowBy(tag: "\(Tag.email)")
        
        let username = usernameRow?.value ?? ""
        let password = passwordRow?.value ?? ""
        let email = emailRow?.value ?? ""
        
        let user = User(username: username, email: email, password: password)
        
        NetworkManager.shared.signup(user: user) { result in
            switch result{
            case .success(let tokenResponse):
                let profileVC = ProfileViewController()
                profileVC.token = tokenResponse.token
                self.navigationController?.pushViewController(profileVC, animated: true)
            case .failure(let error):
                print(error)
            }
        }
    }
    private func presentAlertWithTitle(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true, completion: nil)
    }
}
