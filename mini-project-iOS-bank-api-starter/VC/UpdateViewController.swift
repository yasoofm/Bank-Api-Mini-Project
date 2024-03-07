//
//  UpdateViewController.swift
//  mini-project-iOS-bank-api-starter
//
//  Created by yousef mandani on 07/03/2024.
//

import UIKit
import Eureka

class UpdateViewController: FormViewController {
    
    var token: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.backgroundColor = #colorLiteral(red: 0.1019607843, green: 0.1019607843, blue: 0.1019607843, alpha: 1)
        navigationItem.title = "Update Profile"
        navigationController?.navigationBar.tintColor = .black
        navigationItem.rightBarButtonItem?.tintColor = #colorLiteral(red: 0.1019607843, green: 0.1019607843, blue: 0.1019607843, alpha: 1)
        setupNavigation()
        // Do any additional setup after loading the view.
        form +++ Section()
        <<< TextRow{ row in
            row.title = "Username"
            row.placeholder = "Enter new username"
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
            row.title = "Image"
            row.placeholder = "Enter new image"
            row.placeholderColor = .gray
            row.tag = "\(Tag.image)"
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
            row.placeholder = "Enter new password"
            row.placeholderColor = .gray
            row.tag = "\(Tag.password)"
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
    private func setupNavigation() {
        navigationItem.title = "Update"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "arrowshape.right.fill"), style: .plain, target: self, action: #selector(updateProfile))
    }
    
    @objc func updateProfile(){
        let errors = form.validate()
        guard errors.isEmpty else{
            presentAlertWithTitle(title: "🚨", message: "\(errors.count) fields are missing")
            return
        }
        
        let usernameRow: TextRow? = form.rowBy(tag: "\(Tag.username)")
        let imageRow: TextRow? = form.rowBy(tag: "\(Tag.image)")
        let passwordRow: TextRow? = form.rowBy(tag: "\(Tag.password)")
        
        let username = usernameRow?.value ?? ""
        let image = imageRow?.value ?? ""
        let password = passwordRow?.value ?? ""
        
        let newProfile = UpdateProfileRequest(username: username, image: image, password: password)
        
        NetworkManager.shared.updateProfile(token: self.token ?? "", updateProfileRequest: newProfile) { result in
            switch result{
            case .success:
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "refresh"), object: nil)
                self.navigationController?.popViewController(animated: true)
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
