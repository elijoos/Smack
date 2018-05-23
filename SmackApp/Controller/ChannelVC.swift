//
//  ChannelVC.swift
//  SmackApp
//
//  Created by COMPUTER on 4/23/18.
//  Copyright © 2018 COMPUTER. All rights reserved.
//

import UIKit

class ChannelVC: UIViewController {

    //Outlets
    //Having the button be an outlet because eventually we will change text of it
    @IBOutlet weak var loginBtn: UIButton!
    @IBAction func prepareForUnwind(segue: UIStoryboardSegue){}
    
    @IBOutlet weak var userImg: CircleImage!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //showing more of the side panel
        self.revealViewController().rearViewRevealWidth = self.view.frame.size.width - 60
        
        //Notification Receiver
        NotificationCenter.default.addObserver(self, selector: #selector(ChannelVC.userDataDidChange(_:)), name: NOTIF_USER_DATA_DID_CHANGE, object: nil)
    }
    
    @objc func userDataDidChange(_ notif: Notification) {
        //If registered+logged in, make this VC show the Username and profile pic. But not when logged out
        if AuthService.instance.isLoggedIn {
            loginBtn.setTitle("\(UserDataService.instance.name)", for: .normal)
            userImg.image = UIImage(named: UserDataService.instance.avatarName)
            //returnUIColor from UserDataVC
            userImg.backgroundColor = UserDataService.instance.returnUIColor(components: UserDataService.instance.avatarColor)
        } else {
            loginBtn.setTitle("Login", for: .normal)
            userImg.image = UIImage(named: "menuProfileIcon")
            userImg.backgroundColor = UIColor.clear
        }
    }

    @IBAction func loginBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: TO_LOGIN, sender: nil)
    }
    

}
