//
//  ProfileVCViewController.swift
//  SmackApp
//
//  Created by COMPUTER on 5/24/18.
//  Copyright © 2018 COMPUTER. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController {
//Outlets

    @IBOutlet weak var profileImg: UIImageView!
   
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userEmail: UILabel!
    @IBOutlet weak var bgView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    @IBAction func closeModalPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func logoutPressed(_ sender: Any) {
        //when we logged in we set a whole bunch of variables and booleans in our userdataservice and authservice, so when we log out we need to clear all of that. So we need a logoutUser function in our UserDataService
        UserDataService.instance.loggoutUser()
        NotificationCenter.default.post(name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
        dismiss(animated: true, completion: nil)
    }
    
    func setupView() {
        //userEmail.text = UserDefaults.standard.string(forKey: USER_EMAIL)
        userEmail.text = UserDataService.instance.email
        userName.text = UserDataService.instance.name
        profileImg.image = UIImage(named: UserDataService.instance.avatarColor)
        profileImg.backgroundColor = UserDataService.instance.returnUIColor(components: UserDataService.instance.avatarColor)
        
        let closeTouch = UITapGestureRecognizer(target: self, action: #selector(ProfileVC.closeTap(_:)))
        bgView.addGestureRecognizer(closeTouch)
    }
    @objc func closeTap(_ recognizer: UITapGestureRecognizer) {
        dismiss(animated: true, completion: nil)
    }

}
