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
}
