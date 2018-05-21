//
//  Constants.swift
//  SmackApp
//
//  Created by COMPUTER on 4/24/18.
//  Copyright © 2018 COMPUTER. All rights reserved.
//

import Foundation

//SIMPLE DEFINITION RENAMING A TYPE
typealias CompletionHandler = (_ Success: Bool) -> ()
//example
typealias Elijah = String
let name: Elijah = "Eli"

//COLORS
let smackPurplePlaceholder = #colorLiteral(red: 0.2588235294, green: 0.3294117647, blue: 0.7254901961, alpha: 0.5)

//NOTIFICATION CONSTANTS
let NOTIF_USER_DATA_DID_CHANGE = Notification.Name("notifUserDataChanged")

//URL CONSTANTS
//added the "v1/" to it. This is the online heroku one. The local server is found in postman
let BASE_URL = "https://smack-app-chat.herokuapp.com/v1/"
//the account/register is the end part of the first method in the POSTMAN SERVER!!!
let URL_REEGISTER = "\(BASE_URL)account/register"
let URL_LOGIN = "\(BASE_URL)account/login"
let URL_USER_ADD = "\(BASE_URL)user/add"

//SEGUES
let TO_LOGIN = "toLogin"
let TO_CREATE_ACCOUNT = "toCreateAccount"
let UNWIND = "unwindToChannel"
let TO_AVATAR_PICKER = "toAvatarPicker"

//USER DEFAULTS FOUNDATION
let TOKEN_KEY = "token"
let LOGGED_IN_KEY = "loggedIn"
let USER_EMAIL = "userEmail"

//Headers
let HEADER =  [
    //LOOK IN POSTMAN. Click #1 and then see "Content-Type", and "
    "Content-Type": "application/json; charset=utf-8"
]
