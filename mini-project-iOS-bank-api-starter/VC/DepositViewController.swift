//
//  DepositViewController.swift
//  mini-project-iOS-bank-api-starter
//
//  Created by Aseel on 06/03/2024.
//

import UIKit
import Alamofire
import Eureka

class DepositViewController: FormViewController {
    
    var userToken: String? //assume you have it
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupForm()
        setupNavigation()
    }
    
    private func setupForm() {
        form +++ Section("Deposit")
        <<< DecimalRow() { row in
            row.tag = "amount"
            row.title = "Amount"
            row.placeholder = "Enter deposit amount"
            row.add(rule: RuleRequired())
            row.cellUpdate { cell, row in
                if !row.isValid{
                    cell.titleLabel?.textColor = .red
                }
            }
        }
    }
    
    private func setupNavigation() {
        navigationItem.title = "Deposit"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Deposit", style: .plain, target: self, action: #selector(deposit))
    }
    
    @objc func deposit(){
        let errors = form.validate()
        guard errors.isEmpty else {
            print(errors)
            presentAlertWithTitle(title: "Error", message: "Please type a valid number")
            return
        }
        
        let amountRow: DecimalRow? = form.rowBy(tag: "amount")
        let amount = AmountChange(amount: amountRow?.value ?? 0)
        
        NetworkManager.shared.deposit(token: userToken ?? "", amountChange: amount) { result in
            switch result{
            case .success():
                print("Success")
                self.navigationController?.popViewController(animated: true)
            case .failure(let error):
                print(error)
            }
        }
    }
    private func presentAlertWithTitle(title: String, message: String, completionHandler: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("Ok", comment: ""), style: .default) { _ in
            completionHandler?()
        })
        self.present(alert, animated: true, completion: nil)
        
        
        // deposit(token: String, amountChange: AmountChange, completion: @escaping (Result<Void, Error>) -> Void)
        //        guard let amountRow = form.rowBy(tag: "amount") as? DecimalRow, let amount = amountRow.value else {
        //              return}
        //        
        // adjust the amount to be acceptable to the deposit func
    }
}
