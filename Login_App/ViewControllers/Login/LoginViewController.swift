//
//  LoginViewController.swift
//  Login_App
//
//  Created by Henadzi on 17/11/2022.
//

import Foundation
import UIKit
import AuthenticationServices

let userLogindataUDKey = "UserLoginData"

class LoginViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!

    @IBOutlet weak var logInButton: UIButton!
    
    @IBOutlet weak var createAccountLabel: UILabel!
    @IBOutlet weak var createAccountButton: UIButton!
    @IBOutlet weak var secureEntryButton: UIButton!

    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    
    @IBOutlet private weak var createContainerBottomConstraint: NSLayoutConstraint!

    @IBAction func actionButtonTapped(_ sender: UIButton) {
        if sender.tag == 1 { // && emailTextField.text?.isEmpty == false {
            let storyboard = UIStoryboard(name: "HomeViewControllerStoryboard", bundle: nil)
            let homeVC = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as? HomeViewController
            guard let homeVC else { return }

            let email = emailTextField.text ?? ""
            let password = passwordTextField.text ?? ""
            
            UserDefaults.standard.set([email, password], forKey: userLogindataUDKey)
            
            navigationController?.show(homeVC, sender: nil)
        } else {
            // register
        }
    }
    
    @IBAction func showPasswordTapped(_ sender: UIButton) {
        // Toggle меняет значение у Bool на противоположное текущему
        secureEntryButton.isSelected.toggle()
        passwordTextField.isSecureTextEntry = secureEntryButton.isSelected
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let safeAreaInsets = UIApplication.shared.keyWindow!.safeAreaInsets
//        print(safeAreaInsets.top) // 59.0
//        print(safeAreaInsets.bottom) // 34.0
        setupAppearance()
    }
        
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
        
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        view.endEditing(true)
    }
}

private extension LoginViewController {
    func setupAppearance() {
        guard
            let biogemSemiboldFont40 = UIFont(name: "Biogem-Semibold", size: 40),
            let biogemSemiboldFont24 = UIFont(name: "Biogem-Semibold", size: 24),
            let interRegularFont16 = UIFont(name: "Inter-Regular", size: 16)
        else {
            return
        }
        
        titleLabel.font = biogemSemiboldFont40
        subtitleLabel.font = interRegularFont16
        
        emailTextField.font = interRegularFont16
        passwordTextField.font = interRegularFont16
        
        logInButton.titleLabel?.font = biogemSemiboldFont24
        
        createAccountLabel.font = biogemSemiboldFont24
        createAccountButton.titleLabel?.font = biogemSemiboldFont24
                
        if UIScreen.main.bounds.width < 414 {
            createContainerBottomConstraint.constant = 10
        } else {
            createContainerBottomConstraint.constant = 31
        }
        
        view.layoutIfNeeded()
    }
}
