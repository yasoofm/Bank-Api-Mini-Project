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
            }.onChange { [weak self] row in
                // Handle username change if needed
            }
            
            <<< PasswordRow() { row in
                row.title = "Password"
                row.placeholder = "Enter your password"
            }.onChange { [weak self] row in
                // Handle password change if needed
            }
    }
    
    private func setupNavigation() {
        navigationItem.title = "Sign In"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Sign In", style: .plain, target: self, action: #selector(signinButtonTapped))
    }
    
    // MARK: - Actions
    
    @objc private func signinButtonTapped() {
        guard let usernameRow = form.rowBy(tag: "Username") as? TextRow,
              let passwordRow = form.rowBy(tag: "Password") as? PasswordRow,
              let username = usernameRow.value,
              let password = passwordRow.value else {
            // Handle invalid input
            return
        }
        
        let parameters: [String: Any] = [
            "username": username,
            "password": password
        ]
        
        AF.request("https://coded-bank-api.eapi.joincoded.com/signin", method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    print("Signin successful: \(value)")
                    // Navigate to next screen upon successful signin
                    // Example: self.navigationController?.pushViewController(NextViewController(), animated: true)
                case .failure(let error):
                    print("Signin failed: \(error.localizedDescription)")
                    // Handle error
                }
        }
    }
}
