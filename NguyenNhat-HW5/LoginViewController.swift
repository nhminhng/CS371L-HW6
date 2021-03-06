// Project: NguyenNhat-HW6
// EID: nn7294
// Course: CS371L
//
//  LoginViewController.swift
//  NguyenNhat-HW6
//
//  Created by Nhat Minh Nguyen on 6/23/22.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController, UITextFieldDelegate {
    
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
        userIDTextField.delegate = self
        passwordTextField.delegate = self
        confirmPasswordTextField.delegate = self
        passwordTextField.isSecureTextEntry = true
        confirmPasswordTextField.isSecureTextEntry = true
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
    
    override func viewWillAppear(_ animated: Bool) {
        statusLabel.text = ""
    }
    
    // Called when 'return' key pressed
    func textFieldShouldReturn(_ textField:UITextField) -> Bool {
        userIDTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        confirmPasswordTextField.resignFirstResponder()
        return true
    }
    
    // Called when the user clicks on the view outside of the UITextField
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    //called when segment control changed
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
    
    //called when sign Btn pressed
    @IBAction func signBtnPressed(_ sender: Any) {
        if segCtrl.selectedSegmentIndex == 0 {
            doSignIn()
        } else {
            doSignUp()
        }
    }
    
    //doing signing in
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
    
    //doing signing up
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
