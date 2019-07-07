//
//  LoginViewController.swift
//  TechWarriors
//
//  Created by Mishra, Pooja (Cognizant) on 05/07/19.
//  Copyright © 2019 Mishra, Pooja (Cognizant). All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var usernameTxt : TextField!
    @IBOutlet weak var passwordTxt : TextField!
    @IBOutlet weak var showBtn : UIButton!
    @IBOutlet weak var loginBtn : UIButton!
    
    let defaultUsername = "admin"
    let defaultPassword = "admin"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        usernameTxt.layer.borderColor = UIColor.gray.cgColor
        passwordTxt.layer.borderColor = UIColor.gray.cgColor
        passwordTxt.padding = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 50)
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(gesture)
    }
    
    @IBAction func loginTapped() {
        dismissKeyboard()
        if usernameTxt.text == defaultUsername && passwordTxt.text == defaultPassword {
            Preferences.shared().setPreference(value: true, key: loginKey)
            Utilily.showDashboard()
        }
    }

    @IBAction func forgotPasswordTapped() {
        dismissKeyboard()
        view.makeToast("Coming soon!!!")
    }
    
    @IBAction func showTapped() {
        passwordTxt.isSecureTextEntry = !passwordTxt.isSecureTextEntry
        showBtn.setTitle(passwordTxt.isSecureTextEntry ? "Show" : "Hide", for: .normal)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == usernameTxt {
            passwordTxt.becomeFirstResponder()
        } else {
            loginTapped()
        }
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == usernameTxt && (textField.text?.trimmingCharacters(in: .whitespaces).count == 0 || textField.text != defaultUsername) {
            usernameTxt.layer.borderColor = mainColor.cgColor
        } else if textField == passwordTxt && (textField.text?.trimmingCharacters(in: .whitespaces).count == 0 || textField.text != defaultPassword) {
            passwordTxt.layer.borderColor = mainColor.cgColor
        } else if usernameTxt.text == defaultUsername && passwordTxt.text == defaultPassword {
            loginBtn.setTitleColor(UIColor.white, for: .normal)
            loginBtn.backgroundColor = mainColor
            loginBtn.isEnabled = true
        }
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

class TextField: UITextField {
    
    var padding = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
}
