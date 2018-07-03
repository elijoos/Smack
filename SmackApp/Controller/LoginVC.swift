//
//  LoginVC.swift
//  SmackApp
//
//  Created by COMPUTER on 4/24/18.
//  Copyright © 2018 COMPUTER. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {

    //Outlets
    @IBOutlet weak var usernameTxt: UITextField!
    
    @IBOutlet weak var passwordTxt: UITextField!
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
    }

    @IBAction func loginPressed(_ sender: Any) {
        //1. Log user in with email and passowrd
        //Then use
        spinner.isHidden = false
        spinner.startAnimating()
        //unwrap username and pass
        guard let email = usernameTxt.text , usernameTxt.text != "" else { return }
        guard let pass = passwordTxt.text , passwordTxt.text != "" else { return }
        
        AuthService.instance.loginUser(email: email, password: pass) { (success) in
            if success {
                //HERE WE WILL USE THAT "Find user by email" postman call
                AuthService.instance.findUserByEmail(completion: { (success) in
                    //We have repopulated our UserDataService information
                    
                    if UserDataService.instance.name != "" {
                    //Send out our post notification that our User data has changed
                    NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
                    
                    self.spinner.isHidden = true
                    self.spinner.stopAnimating()
                    self.dismiss(animated: true, completion: nil)
                    }
                })
                
                
            }
        }
    }
    
    func dismissTheLoginView() {
        self.spinner.isHidden = true
        self.spinner.stopAnimating()
        self.dismiss(animated: true, completion: nil)
        
        
    }
    @IBAction func closePressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func createAccountBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: TO_CREATE_ACCOUNT, sender: nil)
    }
    
    func setupView() {
        spinner.isHidden = true
        usernameTxt.attributedPlaceholder = NSAttributedString(string: "username", attributes: [NSAttributedStringKey.foregroundColor: smackPurplePlaceholder])
        passwordTxt.attributedPlaceholder = NSAttributedString(string: "password", attributes: [NSAttributedStringKey.foregroundColor: smackPurplePlaceholder])
    }
    
    
}
