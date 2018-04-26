//
//  CreateAccountVC.swift
//  SmackApp
//
//  Created by COMPUTER on 4/26/18.
//  Copyright © 2018 COMPUTER. All rights reserved.
//

import UIKit

class CreateAccountVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func closePressed(_ sender: Any) {
    performSegue(withIdentifier: UNWIND, sender: nil)
    }
    
}
