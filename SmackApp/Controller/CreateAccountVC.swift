//
//  CreateAccountVC.swift
//  SmackApp
//
//  Created by COMPUTER on 4/26/18.
//  Copyright © 2018 COMPUTER. All rights reserved.
//

import UIKit

class CreateAccountVC: UIViewController {

//Outlets
    @IBOutlet weak var usernameTxt: UITextField!
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var passTxt: UITextField!
    @IBOutlet weak var userImg: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func createAccountPressed(_ sender: Any) {
        //guard statements are another way to unwrap an optional value
        guard let email = emailTxt.text , emailTxt.text != "" else{return}
        guard let pass = passTxt.text , passTxt.text != "" else{return}
        
        //calling  register user from Auth Service
        AuthService.instance.registerUser(email: email, password: pass) { (success) in
            if success {
                //we just coded web request to server to api, api took info, created account object, and sent it to mongo db and saved it. (find db link in heroku)
                print("registered user")
                //Call our next api call to LOG IN USER
                AuthService.instance.loginUser(email: email, password: pass, completion: { (success) in
                    if success {
                        print("user is logged in", AuthService.instance.authToken)
                    }
                })
            }
        }
    }
    
    @IBAction func closePressed(_ sender: Any) {
    performSegue(withIdentifier: UNWIND, sender: nil)
    }
    @IBAction func pickAvatarPressed(_ sender: Any) {
    }
    @IBAction func pickBGColorPressed(_ sender: Any) {
    }
    
    
}
