//
//  AvatarPickerVC.swift
//  SmackApp
//
//  Created by COMPUTER on 5/19/18.
//  Copyright © 2018 COMPUTER. All rights reserved.
//

import UIKit

class AvatarPickerVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    //Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var segmentControl: UISegmentedControl!
    
    // Variables
    var avatarType = AvatarType.dark
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //delegate + datasource
        collectionView.delegate = self
        collectionView.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "avatarCell", for: indexPath) as? AvatarCell{

            cell.configureCell(index: indexPath.item, type: avatarType)
            
            return cell
        } else {
            return UICollectionViewCell()
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var numberOfColumns: CGFloat = 3
        //getting width of screen size. 320 is smallest size -> iPhone SE
        if UIScreen.main.bounds.width > 320 {
            numberOfColumns = 4
        }
        //space between columns
        let spaceBetweenCollumns: CGFloat = 10
        //total padding on left and right
        let padding: CGFloat = 40
        //math to find width of individual cell (which is also height because it's a square)
        let cellDimension = ((collectionView.bounds.width - padding) - (numberOfColumns - 1) * spaceBetweenCollumns) / numberOfColumns
        return CGSize(width: cellDimension, height: cellDimension)
    }
    
    //When select a cell, saving avatar image to UserDataService. ALSO WHEN WE SELECT AN IMAGE WE NEED TO GO TO CREATEACCOUNTVC, IN VIEWDIDAPPEAR, AND REPLACE PLACEHOLDER IMAGE WITH ONE WE SELECTED.
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if avatarType == .dark {
            UserDataService.instance
            .setAvatarName(avatarName: "dark\(indexPath.item)")
        } else {
            UserDataService.instance.setAvatarName(avatarName: "light\(indexPath.item)")
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 28
    }
    
    
    @IBAction func segmentControlChanged(_ sender: Any) {
        switch segmentControl.selectedSegmentIndex
        {
        case 0:
            print("On left side")
            avatarType = .dark
    
        case 1:
            print("On right side")
            avatarType = .light
   
        default:
            break
        }
        collectionView.reloadData()
    }
    
    @IBAction func backPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    

}
