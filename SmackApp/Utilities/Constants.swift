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

//URL CONSTANTS
//added the "v1/" to it. This is the online heroku one. The local server is found in postman
let BASE_URL = "https://smack-app-chat.herokuapp.com/v1/"
//the account/register is the end part of the first method in the POSTMAN SERVER!!!
let URL_REEGISTER = "\(BASE_URL)account/register"
let URL_LOGIN = "\(BASE_URL)account/login"


//SEGUES
let TO_LOGIN = "toLogin"
let TO_CREATE_ACCOUNT = "toCreateAccount"
let UNWIND = "unwindToChannel"

//USER DEFAULTS FOUNDATION
let TOKEN_KEY = "token"
let LOGGED_IN_KEY = "loggedIn"
let USER_EMAIL = "userEmail"

//Headers
let HEADER =  [
    //LOOK IN POSTMAN. Click #1 and then see "Content-Type", and "
    "Content-Type": "application/json; charset=utf-8"
]
