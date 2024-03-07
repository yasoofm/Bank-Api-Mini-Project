//
//  ProfileViewController.swift
//  mini-project-iOS-bank-api-starter
//
//  Created by yousef mandani on 06/03/2024.
//

import UIKit
import Kingfisher

class ProfileViewController: UIViewController {
    
    var token: String?
    private let usernameLabel = UILabel()
    private let emailLabel = UILabel()
    private let balanceLabel = UILabel()
    private let depositButton = UIButton()
    private let withdrawButton = UIButton()
    private let transferButton = UIButton()
    private let ImageView = UIImageView()
    private let usernameCard = UIView()
    private let emailCard = UIView()
    private let balanceCard = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = #colorLiteral(red: 0.1019607843, green: 0.1019607843, blue: 0.1019607843, alpha: 1)
        
        navigationItem.hidesBackButton = true
        fetchUserDetails(token: token ?? "")
        addSubViews()
        setupUI()
        setupLayout()
        setupNavBar()
        
        NotificationCenter.default.addObserver(self, selector: #selector(callFetch), name: NSNotification.Name(rawValue: "refresh"), object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "refresh"), object: nil)
    }
    
    func addSubViews(){
        view.addSubview(ImageView)
        view.addSubview(depositButton)
        view.addSubview(withdrawButton)
        view.addSubview(transferButton)
        view.addSubview(usernameCard)
        view.addSubview(emailCard)
        view.addSubview(balanceCard)
        emailCard.addSubview(emailLabel)
        balanceCard.addSubview(balanceLabel)
        usernameCard.addSubview(usernameLabel)
    }
    func setupUI(){
        depositButton.setTitle("Deposit", for: .normal)
        depositButton.backgroundColor = #colorLiteral(red: 0.537254902, green: 0.537254902, blue: 0.537254902, alpha: 1)
        depositButton.addTarget(self, action: #selector(navToDeposit), for: .touchUpInside)
        depositButton.layer.cornerRadius = 5
        depositButton.layer.shadowColor = UIColor.black.cgColor
        depositButton.layer.shadowOpacity = 0.5
        depositButton.layer.shadowOffset = CGSize(width: 0, height: 2)
        depositButton.layer.shadowRadius = 4
        
        withdrawButton.setTitle("Withdraw", for: .normal)
        withdrawButton.backgroundColor = #colorLiteral(red: 0.537254902, green: 0.537254902, blue: 0.537254902, alpha: 1)
        withdrawButton.addTarget(self, action: #selector(navToWithdraw), for: .touchUpInside)
        withdrawButton.layer.cornerRadius = 5
        withdrawButton.layer.shadowColor = UIColor.black.cgColor
        withdrawButton.layer.shadowOpacity = 0.5
        withdrawButton.layer.shadowOffset = CGSize(width: 0, height: 2)
        withdrawButton.layer.shadowRadius = 4
        
        transferButton.setTitle("Transfer", for: .normal)
        transferButton.addTarget(self, action: #selector(navToTransfer), for: .touchUpInside)
        transferButton.backgroundColor = #colorLiteral(red: 0.537254902, green: 0.537254902, blue: 0.537254902, alpha: 1)
        transferButton.layer.cornerRadius = 5
        transferButton.layer.shadowColor = UIColor.black.cgColor
        transferButton.layer.shadowOpacity = 0.5
        transferButton.layer.shadowOffset = CGSize(width: 0, height: 2)
        transferButton.layer.shadowRadius = 4
        
        ImageView.contentMode = .scaleToFill
        
        usernameCard.backgroundColor = #colorLiteral(red: 0.8352941275, green: 0.8352941275, blue: 0.8352941275, alpha: 1)
        usernameCard.layer.cornerRadius = 10
        usernameCard.layer.shadowColor = UIColor.black.cgColor
        usernameCard.layer.shadowOpacity = 0.5
        usernameCard.layer.shadowOffset = CGSize(width: 0, height: 2)
        usernameCard.layer.shadowRadius = 4
        
        emailCard.backgroundColor = #colorLiteral(red: 0.8352941275, green: 0.8352941275, blue: 0.8352941275, alpha: 1)
        emailCard.layer.cornerRadius = 10
        emailCard.layer.shadowColor = UIColor.black.cgColor
        emailCard.layer.shadowOpacity = 0.5
        emailCard.layer.shadowOffset = CGSize(width: 0, height: 2)
        emailCard.layer.shadowRadius = 4
        
        balanceCard.backgroundColor = #colorLiteral(red: 0.8352941275, green: 0.8352941275, blue: 0.8352941275, alpha: 1)
        balanceCard.layer.cornerRadius = 10
        balanceCard.layer.shadowColor = UIColor.black.cgColor
        balanceCard.layer.shadowOpacity = 0.5
        balanceCard.layer.shadowOffset = CGSize(width: 0, height: 2)
        balanceCard.layer.shadowRadius = 4
    }
    func setupLayout(){
        ImageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(250)
        }
        usernameLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        usernameCard.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(10)
            make.height.equalTo(50)
            make.width.equalToSuperview().multipliedBy(0.95)
        }
        emailCard.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(usernameCard.snp.bottom).offset(5)
            make.height.equalTo(50)
            make.width.equalToSuperview().multipliedBy(0.95)
        }
        emailLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        balanceCard.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(emailCard.snp.bottom).offset(5)
            make.height.equalTo(50)
            make.width.equalToSuperview().multipliedBy(0.95)
        }
        balanceLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        depositButton.snp.makeConstraints { make in
            make.bottom.equalTo(transferButton.snp.top).offset(-30)
            make.centerX.equalToSuperview().offset(-90)
            make.height.equalTo(45)
            make.width.equalToSuperview().multipliedBy(0.45)
        }
        withdrawButton.snp.makeConstraints { make in
            make.bottom.equalTo(transferButton.snp.top).offset(-30)
            make.centerX.equalToSuperview().offset(90)
            make.height.equalTo(45)
            make.width.equalToSuperview().multipliedBy(0.45)
        }

        transferButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-20)
            make.centerX.equalToSuperview()
            make.height.equalTo(45)
            make.width.equalTo(withdrawButton).multipliedBy(2.01)
        }

    }
    
    @objc func navToUpdateProfile(){
        let updateVC = UpdateViewController()
        updateVC.token = self.token
        navigationController?.pushViewController(updateVC, animated: true)
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
        let withdrawVC = WithdrawViewController()
        withdrawVC.userToken = token
        navigationController?.pushViewController(withdrawVC, animated: true)
    }
    
    @objc func transactionDetailButtonTapped(){
        let transactionsVC = TransactionsViewController( )
        transactionsVC.token = token
        navigationController?.pushViewController(transactionsVC, animated: true)
    }
    
    @objc func navToTransfer(){
        let transferVC = TransferViewController()
        transferVC.token = token
        navigationController?.pushViewController(transferVC, animated: true)
    }
    
    func fetchUserDetails(token: String){
        NetworkManager.shared.fetchUserDetails(token: self.token ?? "") { result in
            switch result{
            case .success(let userDetails):
                let user = userDetails
                self.usernameLabel.text = "Username: \(user.username)"
                self.emailLabel.text = "Email: \(user.email)"
                self.balanceLabel.text = "Balance: \(user.balance)"
                self.ImageView.kf.setImage(with: URL(string: user.image ?? "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png"))
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func setupNavBar(){
        let appearance = UINavigationBarAppearance()
        appearance.configureWithDefaultBackground()
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "person.fill"), style: .plain, target: self, action: #selector(navToUpdateProfile))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "arrow.left.arrow.right"), style: .plain, target: self, action: #selector(transactionDetailButtonTapped))
        
        navigationItem.rightBarButtonItem?.tintColor = #colorLiteral(red: 0.1019607843, green: 0.1019607843, blue: 0.1019607843, alpha: 1)
        navigationItem.leftBarButtonItem?.tintColor = #colorLiteral(red: 0.1019607843, green: 0.1019607843, blue: 0.1019607843, alpha: 1)
    }
}
