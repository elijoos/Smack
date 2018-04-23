//
//  ChannelVC.swift
//  SmackApp
//
//  Created by COMPUTER on 4/23/18.
//  Copyright © 2018 COMPUTER. All rights reserved.
//

import UIKit

class ChannelVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        //showing more of the side panel
        self.revealViewController().rearViewRevealWidth = self.view.frame.size.width - 60
    }

   

}
