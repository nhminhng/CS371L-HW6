//
//  LoginViewController.swift
//  NguyenNhat-HW5
//
//  Created by Nhat Minh Nguyen on 6/23/22.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var segCtrl: UISegmentedControl!
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
    
    
}
