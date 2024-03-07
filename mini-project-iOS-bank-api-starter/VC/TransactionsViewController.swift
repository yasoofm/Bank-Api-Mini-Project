//
//  TransactionsViewController.swift
//  mini-project-iOS-bank-api-starter
//
//  Created by yousef mandani on 07/03/2024.
//

import UIKit
import Alamofire

class TransactionsViewController: UITableViewController {
    
    var token : String?
    var transactions : [Transaction] = []
    
    override func viewDidLoad() {
       super.viewDidLoad()
       fetchTransactions()
       tableView.register(UITableViewCell.self, forCellReuseIdentifier: "transaction cell")
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return transactions.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell = tableView.dequeueReusableCell(withIdentifier: "transaction cell", for: indexPath)
       let transaction = transactions[indexPath.row]
        cell.textLabel?.text = "Sender: \(transaction.senderId), Receiver: \(transaction.receiverId), Amount: \(transaction.amount)"
       return cell
    }


    func fetchTransactions() {
        NetworkManager.shared.fetchTransactions(token: self.token ?? "") { result in
            switch result{
            case .success(let transactions):
                self.transactions = transactions
                self.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }

}
