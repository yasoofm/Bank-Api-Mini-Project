//
//  ProfileViewController.swift
//  mini-project-iOS-bank-api-starter
//
//  Created by yousef mandani on 06/03/2024.
//

import UIKit

class ProfileViewController: UIViewController {
    
    var token: String?
    var userDetails: UserDetails?
    private let usernameLabel = UILabel()
    private let emailLabel = UILabel()
    private let balanceLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //fetchUserDetails(token: token ?? "")
        addSubViews()
        setupUI()
        setupLayout()
    }
    
    func setupUI(){
        
    }
    
    func addSubViews(){
        
    }
    
    func setupLayout(){
        
    }
    
//    func fetchUserDetails(token: String){
//        NetworkManager.shared.fetchUserDetails(token: token) { result in
//            switch result{
//            case .success(let userDetails):
//                print(userDetails)
//            }
//        }
//    }
}
