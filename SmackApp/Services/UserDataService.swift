//
//  UserDataService.swift
//  SmackApp
//
//  Created by COMPUTER on 5/12/18.
//  Copyright © 2018 COMPUTER. All rights reserved.
//

import Foundation
class UserDataService {
    
    static let instance = UserDataService()
    
    //a public getter variable. ALL CLASSES CAN READ THESE, but other classes CANNOT SET THE VALUE DIRECTLY. Only this file can modify value
    //These are the places where we will store the data when we receive the data from the api request (3. creating a user)
    public private(set) var id = ""
    public private(set) var avatarColor = ""
    public private(set) var avatarName = ""
    public private(set) var email = ""
    public private(set) var name = ""
    
    //now we are SETTING THESE VARIABLES. This function allows us to set those variables from other classes once we get api info back
    func setUserData(id: String, color: String, avatarName: String, email: String, name: String) {
        self.id = id
        self.avatarColor = color
        self.avatarName = avatarName
        self.email = email
        self.name = name
    }
    
    //Update avatar name. Something we will use later on, prob when we want to change it
    func setAvatarName(avatarName: String) {
        self.avatarName = avatarName
    }
    
    //USE THIS IN CHANNELVC where we set the color. Cmnd f search for "returnUIColor from UserDataVC" We don't need to go into database because we already have it called from database in variable avatarColor
    //very important function because we are calling it so many times in this app for each message and for opening profile 
    func returnUIColor(components: String) -> UIColor {
        // what string we are going to scan "[0.4, 0.615686274509804, 0.552941176470588, 1]"
        //Extract from this string ^ from db, into r g b and alpha values
        //Scanner Variable - Scanns a string or array and have it do different things
        let scanner = Scanner(string: components)
        //tell scanner which characters to skip (4 characters) use the string one
        let skipped = CharacterSet(charactersIn: "[], ")
        //Start at beginning and scan up to this character (stop at the comma)
        let comma = CharacterSet(charactersIn: ",")
        scanner.charactersToBeSkipped = skipped
        
        //Actually start scanning. Saving r g b values into seperate variables
        var r, g, b, a: NSString?
        //Starting at beginning scan up to the comma, skipping the brackets and space. DOING THIS FOR ALL THESE VARIABLES
        scanner.scanUpToCharacters(from: comma, into: &r)
        scanner.scanUpToCharacters(from: comma, into: &g)
        scanner.scanUpToCharacters(from: comma, into: &b)
        scanner.scanUpToCharacters(from: comma, into: &a)
        
        let defaultColor = UIColor.lightGray
        
        //unwrap each of those variables
        guard let rUnwrapped = r else {return defaultColor}
        guard let gUnwrapped = g else {return defaultColor}
        guard let bUnwrapped = b else {return defaultColor}
        guard let aUnwrapped = a else {return defaultColor}
        
        //Now convert these Strings into CGFloat. Not a direct way so have to do it long way
        
        let rfloat = CGFloat(rUnwrapped.doubleValue)
        let gfloat = CGFloat(gUnwrapped.doubleValue)
        let bfloat = CGFloat(bUnwrapped.doubleValue)
        let afloat = CGFloat(aUnwrapped.doubleValue)
        
        let newUIColor = UIColor(red: rfloat, green: gfloat, blue: bfloat, alpha: afloat)
        
        
        return newUIColor
    }
}
