//
//  LoginViewController.swift
//  NguyenNhat-HW5
//
//  Created by Nhat Minh Nguyen on 6/23/22.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
    
    @IBOutlet weak var segCtrl: UISegmentedControl!
    
    @IBOutlet weak var userIDTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordLabel: UILabel!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var signButton: UIButton!
    @IBOutlet weak var statusLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        confirmPasswordLabel.isHidden = true
        confirmPasswordTextField.isHidden = true
        signButton.setTitle("Sign in", for: .normal)
        statusLabel.text = ""
        
        
        Auth.auth().addStateDidChangeListener() {
            auth, user in
            if user != nil {
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
                self.userIDTextField.text = nil
                self.passwordTextField.text = nil
                self.confirmPasswordTextField.text = nil
            }
        }
    }
    
    @IBAction func onSegmentChanged(_ sender: Any) {
        switch segCtrl.selectedSegmentIndex {
        case 0:
            confirmPasswordLabel.isHidden = true
            confirmPasswordTextField.isHidden = true
            signButton.setTitle("Sign in", for: .normal)
            break
        case 1:
            confirmPasswordLabel.isHidden = false
            confirmPasswordTextField.isHidden = false
            signButton.setTitle("Sign up", for: .normal)
            break
        default:
            break
        }
    }
    
    
    @IBAction func signBtnPressed(_ sender: Any) {
        
        if segCtrl.selectedSegmentIndex == 0 {
            doSignIn()
        } else {
            doSignUp()
        }
        
    }
    
    func doSignIn() {
        let userID = userIDTextField.text!
        let password = passwordTextField.text!
        Auth.auth().signIn(withEmail: userID, password: password) {
            authResult, error in
            if let error = error as NSError? {
                self.statusLabel.text = "\(error.localizedDescription)"
            } else {
                self.statusLabel.text = "Signed in successfully"
            }
        }
        
        
    }
    
    func doSignUp() {
        
        let userID = userIDTextField.text!
        let password = passwordTextField.text!
        let confirmPassword = confirmPasswordTextField.text!
        
        if (password == confirmPassword){
            Auth.auth().createUser(withEmail: userID, password: password) {
                authResult, error in
                if let error = error as NSError? {
                    self.statusLabel.text = "\(error.localizedDescription)"
                } else {
                    self.statusLabel.text = "Account is created (from Firebase)"
                }
            }
        } else {
            statusLabel.text = "Password does not match confirmed password."
        }
    
    }
    
}
