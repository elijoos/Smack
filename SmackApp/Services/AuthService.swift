//
//  AuthService.swift
//  SmackApp
//
//  Created by COMPUTER on 5/8/18.
//  Copyright © 2018 COMPUTER. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
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
        
        //create JSON object (MOVED TO CONSTANTS FILE)
//        let header = [
//            //LOOK IN POSTMAN. Click #1 and then see "Content-Type", and "
//            "Content-Type": "application/json; charset=utf-8"
//        ]
        
        let body: [String: Any] = [
            "email": lowerCaseEmail,
            "password": password
        ]
        
        //create web request since defined header and body. We want the longer one because we need to send a request with a specific method, pass in parameters (our body), type of encoding, and also headers. We add the .request then .response NOTE: USUSALLY YOU WILL SAY .RESPONSEJSON but this specific one for our register it's a string
        Alamofire.request(URL_REEGISTER, method: .post, parameters: body, encoding: JSONEncoding.default, headers: HEADER).responseString { (response) in
            
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
    
    func loginUser(email: String, password: String, completion: @escaping CompletionHandler) {
        let lowerCaseEmail = email.lowercased()
        
        let body: [String: Any] = [
            "email": lowerCaseEmail,
            "password": password
        ]
        
        Alamofire.request(URL_LOGIN, method: .post, parameters: body, encoding: JSONEncoding.default, headers: HEADER).responseJSON { (response) in
            
            if response.result.error == nil {
                //In register user we didn't need to get anything back from the response. But here we do because look at JSON in header of login method on postman we get a JSON object "user" and "token" ----->>> PARSE THE DATA
                //PARSING DATA
//                if let json = response.result.value as? Dictionary<String, Any> {
//                    if let email = json["user"] as? String {
//                        self.userEmail = email
//                    }
//                    if let token = json["token"] as? String {
//                        self.authToken = token
//                    }
//                }
                //RE-WRITE PARSE DATA USING SWIFTYJSON
                guard let data = response.data else { return }
                do {
                    let json = try JSON(data: data)
                    self.userEmail = json["user"].stringValue
                    self.authToken = json["token"].stringValue
                } catch {
                    print (error.localizedDescription)
                }
                
                self.isLoggedIn = true
                completion(true)
            } else {
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
}
