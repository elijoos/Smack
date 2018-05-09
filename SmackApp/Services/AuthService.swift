//
//  AuthService.swift
//  SmackApp
//
//  Created by COMPUTER on 5/8/18.
//  Copyright © 2018 COMPUTER. All rights reserved.
//

import Foundation
import Alamofire
class AuthService {
    
    static let instance = AuthService()
    
    let defaults = UserDefaults.standard
    
    var isLoggedIn : Bool {
        get {
            return defaults.bool(forKey: LOGGED_IN_KEY)
        }
        set {
            defaults.set(newValue, forKey: LOGGED_IN_KEY)
        }
    }
    
    var authToken: String {
        get{
            return defaults.value(forKey: TOKEN_KEY) as! String
        }
        set {
            defaults.set(newValue, forKey: TOKEN_KEY)
        }
    }
    
    var userEmail: String {
        get{
            return defaults.value(forKey: USER_EMAIL) as! String
        }
        set {
            defaults.set(newValue, forKey: USER_EMAIL)
        }
    }
    
    
    //WEB REQUESTS, Specify Header, Specify Body, how it is returned; Using AlamoFire built on top of Apple's URLSession. We just said "import AlamoFire" to import it. Go to alamofire github page and read the Response Data Handler info
    
    func registerUser(email: String, password: String, completion: @escaping CompletionHandler) {
        //web requests need a complesion handler because we have no idea when we will get data back
        
        let lowerCaseEmail = email.lowercased()
        
        //need a header, which is basically an attachment to the http request where you can do a bunch like specify content, api keys, etc.
        
        //create JSON object
        let header = [
            //LOOK IN POSTMAN. Click #1 and then see "Content-Type", and "
            "Content-Type": "application/json; charset=utf-8"
        ]
        
        let body: [String: Any] = [
            "email": lowerCaseEmail,
            "password": password
        ]
        
        //create web request since defined header and body. We want the longer one because we need to send a request with a specific method, pass in parameters (our body), type of encoding, and also headers. We add the .request then .response NOTE: USUSALLY YOU WILL SAY .RESPONSEJSON but this specific one for our register it's a string
        Alamofire.request(URL_REEGISTER, method: .post, parameters: body, encoding: JSONEncoding.default, headers: header).responseString { (response) in
            
            if response.result.error == nil{
                //this completion method will tell us if the .request was succesfull
                completion(true)
            } else {
                //this completion method will tell us if the .request was a failure
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
