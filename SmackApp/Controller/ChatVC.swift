//
//  ChatVC.swift
//  SmackApp
//
//  Created by COMPUTER on 4/23/18.
//  Copyright © 2018 COMPUTER. All rights reserved.
//

import UIKit

//REMOTE FOR GITHUB IS "SMACK"
class ChatVC: UIViewController {

    //Outlets
    //this button an outlet because adding action in viewDidLoad()
    @IBOutlet weak var menuBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //created a selector, which is a method we want to invoce, which is from the SWRevealViewController file
        menuBtn.addTarget(revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
       
        //both these methods are also from SWRevealLibrary that we are calling. The first one allows you to swipe to see the side bar and the next to tap the right vc to go back to it
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        
    }

  
}
