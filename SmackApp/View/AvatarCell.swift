//
//  AvatarCell.swift
//  SmackApp
//
//  Created by COMPUTER on 5/19/18.
//  Copyright © 2018 COMPUTER. All rights reserved.
//

import UIKit

enum AvatarType {
    case dark
    case light

}
class AvatarCell: UICollectionViewCell {
    @IBOutlet weak var avatarImg: UIImageView!
    
    override func awakeFromNib() {
        //the first thing that's called when it wakes up from being a nib. You must call super.awakefromnib so that parent class can perform additional initialization they require
        super.awakeFromNib()
        setUpView()
    }
    
    func configureCell(index: Int, type: AvatarType) {
        if type == AvatarType.dark {
            avatarImg.image = UIImage(named: "dark\(index)")
            self.layer.backgroundColor = UIColor.lightGray.cgColor
        } else {
            avatarImg.image = UIImage(named: "light\(index)")
            self.layer.backgroundColor = UIColor.gray.cgColor
        }
    }
    
    func setUpView() {
    //where we edit how the cell looks: the cornerradius's, bg colors, etc.
    self.layer.backgroundColor = UIColor.lightGray.cgColor
    self.layer.cornerRadius = 10
    self.clipsToBounds = true
    }
}
