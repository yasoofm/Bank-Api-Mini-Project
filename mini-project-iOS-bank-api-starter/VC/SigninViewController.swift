//
//  SigninViewController.swift
//  mini-project-iOS-bank-api-starter
//
//  Created by Aseel on 06/03/2024.
//

import UIKit

class SignInViewController: UIViewController {
    // Outlets for text fields
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Additional setup if needed
    }
    
    // Action method for sign-in button
    @IBAction func signInButtonTapped(_ sender: UIButton) {
        guard let username = usernameTextField.text, !username.isEmpty,
              let password = passwordTextField.text, !password.isEmpty else {
            // Handle case where username or password is empty
            showAlert(message: "Please enter username and password.")
            return
        }
        
        // Create JSON data
        let jsonData: [String: Any] = ["username": username, "password": password]
        
        // Convert JSON data to Data
        guard let requestData = try? JSONSerialization.data(withJSONObject: jsonData) else {
            showAlert(message: "Error creating request data.")
            return
        }
        
        // Create URL request
        guard let url = URL(string: "https://coded-bank-api.eapi.joincoded.com/signin") else {
            showAlert(message: "Invalid URL.")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = requestData
        
        // Perform the request
        URLSession.shared.dataTask(with: request) { data, response, error in
            // Handle response
            if let error = error {
                self.showAlert(message: "Error: \(error.localizedDescription)")
                return
            }
            
            if let data = data {
                // Parse response data if needed
                // Handle success or failure
            }
        }.resume()
    }
    
    // Helper method to show alerts
    func showAlert(message: String) {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alertController, animated: true, completion: nil)
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
