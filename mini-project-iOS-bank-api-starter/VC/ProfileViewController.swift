//
//  ProfileViewController.swift
//  mini-project-iOS-bank-api-starter
//
//  Created by yousef mandani on 06/03/2024.
//

import UIKit

class ProfileViewController: UIViewController {
    
    var token: String?
    private let usernameLabel = UILabel()
    private let emailLabel = UILabel()
    private let balanceLabel = UILabel()
    private let depositButton = UIButton()
    private let withdrawButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        
        fetchUserDetails(token: token ?? "")
        addSubViews()
        setupUI()
        setupLayout()
        
        NotificationCenter.default.addObserver(self, selector: #selector(callFetch), name: NSNotification.Name(rawValue: "deposit"), object: nil)
    }
    
    func addSubViews(){
        view.addSubview(usernameLabel)
        view.addSubview(emailLabel)
        view.addSubview(balanceLabel)
        view.addSubview(depositButton)
        view.addSubview(withdrawButton)
    }
    func setupUI(){
        depositButton.setTitle("Deposit", for: .normal)
        depositButton.backgroundColor = .systemBlue
        depositButton.addTarget(self, action: #selector(navToDeposit), for: .touchUpInside)
        
        withdrawButton.setTitle("Withdraw", for: .normal)
        withdrawButton.backgroundColor = .systemBlue
        withdrawButton.addTarget(self, action: #selector(navToWithdraw), for: .touchUpInside)
    }
    func setupLayout(){
        usernameLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-10)
        }
        emailLabel.snp.makeConstraints { make in
            make.top.equalTo(usernameLabel.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
        }
        balanceLabel.snp.makeConstraints { make in
            make.top.equalTo(emailLabel.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
        }
        depositButton.snp.makeConstraints { make in
            make.top.equalTo(balanceLabel.snp.bottom).offset(30)
            make.centerX.equalToSuperview().offset(-100)
            make.height.equalTo(45)
            make.width.equalTo(100)
        }
        withdrawButton.snp.makeConstraints { make in
            make.top.equalTo(balanceLabel.snp.bottom).offset(30)
            make.centerX.equalToSuperview().offset(100)
            make.height.equalTo(45)
            make.width.equalTo(100)
        }
    }
    
    @objc func callFetch(){
        fetchUserDetails(token: self.token ?? "")
    }
    
    @objc func navToDeposit(){
        let depositVC = DepositViewController()
        depositVC.userToken = token
        navigationController?.pushViewController(depositVC, animated: true)
    }
    
    @objc func navToWithdraw(){
        
        navigationController?.pushViewController(ProfileViewController(), animated: true)
    }
    
    func fetchUserDetails(token: String){
        NetworkManager.shared.fetchUserDetails(token: self.token ?? "") { result in
            switch result{
            case .success(let userDetails):
                let user = userDetails
                self.usernameLabel.text = user.username
                self.emailLabel.text = user.email
                self.balanceLabel.text = "\(user.balance)"
            case .failure(let error):
                print(error)
            }
        }
    }
}
