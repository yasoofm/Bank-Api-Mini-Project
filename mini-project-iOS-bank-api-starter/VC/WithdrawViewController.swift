//
//  WithdrawViewController.swift
//  mini-project-iOS-bank-api-starter
//
//  Created by yousef mandani on 06/03/2024.
//
import UIKit
import Alamofire
import Eureka

class WithdrawViewController: FormViewController {

    var userToken: String? //assume you have it

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.backgroundColor = #colorLiteral(red: 0.1019607843, green: 0.1019607843, blue: 0.1019607843, alpha: 1)
        navigationItem.title = "Withdraw"
        setupForm()
        setupNavigation()
    }

    private func setupForm() {
        form +++ Section()
        <<< DecimalRow() { row in
            row.tag = "amount"
            row.title = "Amount"
            row.placeholder = "Enter withdraw amount"
            row.placeholderColor = .gray
            row.validationOptions = .validatesOnChange
            row.add(rule: RuleRequired())
            row.cellUpdate { cell, row in
                cell.backgroundColor = #colorLiteral(red: 0.8352941275, green: 0.8352941275, blue: 0.8352941275, alpha: 1)
                if !row.isValid{
                    cell.titleLabel?.textColor = .red
                }
            }
        }
    }

    private func setupNavigation() {
        navigationItem.title = "Withdraw"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "arrowshape.right.fill"), style: .plain, target: self, action: #selector(withdraw))
    }

    @objc func withdraw(){
        let errors = form.validate()
        guard errors.isEmpty else {
            print(errors)
            presentAlertWithTitle(title: "Error", message: "Please type a valid number")
            return
}

        let amountRow: DecimalRow? = form.rowBy(tag: "amount")
        let amount = AmountChange(amount: amountRow?.value ?? 0)

        NetworkManager.shared.withdraw(token: self.userToken ?? "", amountChange: amount) { result in
            switch result{
            case .success():
                print(self.userToken ?? "no token")
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "refresh"), object: nil)
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
    }
}
