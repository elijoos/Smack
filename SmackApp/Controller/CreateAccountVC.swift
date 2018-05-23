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
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    
//Variables
    var avatarName = "profileDefault" //also the name of the "avatarImage" image in constants that we set to users as default
    var avatarColor = "[0.5, 0.5, 0.5, 1]" //default light gray color
    //bg color randomly generated for profile
    var bgColor: UIColor?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if UserDataService.instance.avatarName != "" {
            userImg.image = UIImage(named: UserDataService.instance.avatarName)
            avatarName = UserDataService.instance.avatarName
            //If selecting a background color for first time and haven't set color yet
            if avatarName.contains("light") && bgColor == nil {
                userImg.backgroundColor = UIColor.lightGray
            }
        }
    }
    
    @IBAction func createAccountPressed(_ sender: Any) {
        spinner.isHidden = false
        spinner.startAnimating()
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
                                self.spinner.isHidden = true
                                self.spinner.stopAnimating()
                                print("UserDataService Name: \(UserDataService.instance.name) UserDataService Avatar Name \(UserDataService.instance.avatarName)")
                                //segue back home once we create user
                                self.performSegue(withIdentifier: UNWIND, sender: nil)
                                //Notification
                                NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
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
        //r g and b colors are from 0 to 255 then divided by 255. Also must be CGFloat
        let r = CGFloat(arc4random_uniform(255)) / 255
        let g = CGFloat(arc4random_uniform(255)) / 255
        let b = CGFloat(arc4random_uniform(255)) / 255
        //Create random UIColor. Randomly generate an rgb color
        bgColor = UIColor(red: r, green: g, blue: b, alpha: 1)
        //setting the color
        avatarColor = "[\(r), \(g), \(b), 1]"
        
        //animation to change the background color
        UIView.animate(withDuration: 0.5) {
            self.userImg.backgroundColor = self.bgColor
        }
        
    }
    
    //calling this func in viewdidload()
    func setupView() {
        spinner.isHidden = true
        //color for placeholder text. In attributes array we are putting in a dictionary object of key being the color of placeholder and our color being our color in contants file
        usernameTxt.attributedPlaceholder = NSAttributedString(string: "username", attributes: [NSAttributedStringKey.foregroundColor: smackPurplePlaceholder])
        emailTxt.attributedPlaceholder = NSAttributedString(string: "email", attributes: [NSAttributedStringKey.foregroundColor: smackPurplePlaceholder])
        passTxt.attributedPlaceholder = NSAttributedString(string: "password", attributes: [NSAttributedStringKey.foregroundColor: smackPurplePlaceholder])
        
        //dismissing the keyboard using tap gesture recogniser set to self, which is whole vc
        let tap = UITapGestureRecognizer(target: self, action: #selector(CreateAccountVC.handleTap))
        view.addGestureRecognizer(tap)
    }
    
    @objc func handleTap() {
        //if we have a keyboard open, it will dismiss it
        view.endEditing(true)
    }
    
    
}
