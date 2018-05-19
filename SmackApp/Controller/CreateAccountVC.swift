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
    
//Variables
    var avatarName = "profileDefault" //also the name of the "avatarImage" image in constants that we set to users as default
    var avatarColor = "[0.5, 0.5, 0.5, 1]" //default light gray color
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func createAccountPressed(_ sender: Any) {
        //guard statements are another way to unwrap an optional value
        guard let name = usernameTxt.text, usernameTxt.text != "" else{return}
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
                        //CALL OUR NEXT API CALL TO CREATE USER
                        AuthService.instance.createUser(name: name, email: email, avatarName: self.avatarName, avatarColor: self.avatarColor, completion: { (success) in
                            if success {
                                print("UserDataService Name: \(UserDataService.instance.name) UserDataService Avatar Name \(UserDataService.instance.avatarName)")
                                //segue back home once we create user
                                self.performSegue(withIdentifier: UNWIND, sender: nil)
                            }
                        })
                    }
                })
            }
        }
    }
    
    @IBAction func closePressed(_ sender: Any) {
    performSegue(withIdentifier: UNWIND, sender: nil)
    }
    @IBAction func pickAvatarPressed(_ sender: Any) {
        performSegue(withIdentifier: TO_AVATAR_PICKER, sender: nil)
    }
    @IBAction func pickBGColorPressed(_ sender: Any) {
    }
    
    
}
