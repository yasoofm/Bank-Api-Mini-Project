//
//  NetworkManager.swift
//  mini-project-iOS-bank-api-starter
//
//  Created by Nawaf Almutairi on 05/03/2024.
//

import Foundation
import Alamofire
class NetworkManager {
    private let baseUrl = "https://coded-bank-api.eapi.joincoded.com/"
    
    static let shared = NetworkManager()
    
    func signup(user: User, completion: @escaping (Result<TokenResponse, Error>) -> Void) {
        let url = baseUrl + "signup"
        AF.request(url, method: .post, parameters: user, encoder: JSONParameterEncoder.default).responseDecodable(of: TokenResponse.self) { response in
            switch response.result {
            case .success(let value):
                completion(.success(value))
            case .failure(let afError):
                completion(.failure(afError as Error))
            }
        }
    }
            
    func deposit(token: String, amountChange: AmountChange, completion: @escaping (Result<Void, Error>) -> Void) {
        let url = baseUrl + "deposit"
        let headers: HTTPHeaders = [.authorization(bearerToken: token)]
        AF.request(url, method: .put, parameters: amountChange, encoder: JSONParameterEncoder.default, headers: headers).response { response in
            if let error = response.error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    }

    
    //MARK: OTHER Networking Functions
    func signin(user: User, completion: @escaping (Result<TokenResponse, Error>) -> Void) {
        let url = baseUrl + "signin"
        AF.request(url, method: .post, parameters: user, encoder: JSONParameterEncoder.default).responseDecodable(of: TokenResponse.self) { response in
            switch response.result {
            case .success(let value):
                completion(.success(value))
            case .failure(let afError):
                completion(.failure(afError as Error))
            }
        }
    }
    
    func fetchUserDetails(token: String, completion: @escaping (Result<UserDetails, Error>) -> Void){
        
        let headers: HTTPHeaders = [.authorization(bearerToken: token)]
        
        AF.request(baseUrl + "account",headers: headers).responseDecodable(of: UserDetails.self){ response in
            switch response.result{
            case .success(let userDetails):
                completion(.success(userDetails))
            case .failure(let afError):
                completion(.failure(afError as Error))
                print(afError.localizedDescription)
            }
        }
    }
    
    func fetchTransactions(token: String, completion: @escaping (Result<[Transaction], Error>) -> Void){
        
        let headers: HTTPHeaders = [.authorization(bearerToken: token)]
        
        AF.request(baseUrl + "transactions", headers: headers).responseDecodable(of: [Transaction].self){ response in
            switch response.result{
            case .success(let transactions):
                completion(.success(transactions))
            case .failure(let afError):
                completion(.failure(afError as Error))
                print(afError.localizedDescription)
            }
        }
    }
    
    func transfer(token: String, username: String, amountChange: AmountChange, completion: @escaping (Result<Void, Error>) -> Void){
        
        let headers: HTTPHeaders = [.authorization(bearerToken: token)]
        
        AF.request(baseUrl + "transfer/" + username, method: .post, parameters: amountChange, encoder: JSONParameterEncoder.default, headers: headers).response { response in
            switch response.result{
            case .success:
                completion(.success(()))
            case .failure(let afError):
                completion(.failure(afError as Error))
            }
        }
    }
    
    func withdraw(token: String, amountChange: AmountChange, completion: @escaping (Result<Void, Error>) -> Void) {
        let url = baseUrl + "withdraw"
        let headers: HTTPHeaders = [.authorization(bearerToken: token)]
        AF.request(url, method: .put, parameters: amountChange, encoder: JSONParameterEncoder.default, headers: headers).response { response in
            if let error = response.error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    }
    
    func updateProfile(token: String, updateProfileRequest: UpdateProfileRequest, completion: @escaping (Result<Void, Error>) -> Void){
        let headers: HTTPHeaders = [.authorization(bearerToken: token)]
        AF.request(baseUrl + "update", method: .put, parameters: updateProfileRequest, encoder: JSONParameterEncoder.default, headers: headers).response{ response in
            if let error = response.error{
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    }
}
