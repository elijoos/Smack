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
    
    //Adding User api call
    func createUser(name: String, email: String, avatarName: String, avatarColor: String, completion: @escaping CompletionHandler) {
        
        let lowerCaseEmail = email.lowercased()
        
        //setting values of body to be whatever we pass into this function
        let body: [String: Any] = [
            //replicating postman body for this function and setting it
            "name": name,
            "email": lowerCaseEmail,
            "avatarName": avatarName,
            "avatarColor": avatarColor
            
        ]
        //Header; This time we have the Authorization header as well as other header MOVED TO CONSTANTS
//        let header = [
//            //both our headers are in here. See how the Authorization header in postman "value" required "Bearer authtoken"!
//            //We basically trying to replicate the postman one
//            "Authorization": "Bearer \(AuthService.instance.authToken)",
//            "Content-Type": "application/json; charset=utf-8"
//        ]
        
        Alamofire.request(URL_USER_ADD, method: .post, parameters: body, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseString { (response) in
            
            if response.result.error == nil{
                 guard let data = response.data else { return }
                do {
                    self.setUserInfo(data: data)
                    completion(true)
                }
                
            } else {
                //this completion method will tell us if the .request was a failure
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
    }
    
    func findUserByEmail(completion: @escaping CompletionHandler) {
        //create our url in utilities called URL_USER_BY_EMAIL
        //dont need a body or anything for this call, but will use a header
        //This function allows us to, if we are logged in, to access any of the user's profile info by just passing in an email
        //AlamoFireRequest. See how we append the userEmail to the end of it???
        Alamofire.request("\(URL_USER_BY_EMAIL)\(userEmail)", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: BEARER_HEADER).responseJSON { (response) in
            //YO! BASICALLY DOING EXACTLY WHAT W DID IN THE "URL_USER_ADD" body of function above in this file
            if response.result.error == nil{
                guard let data = response.data else { return }
               // self.setUserInfo(data: data)
                do{
                    let json = try JSON(data: data)
                    let id = json["_id"].stringValue
                    let color = json["avatarColor"].stringValue
                    let avatarName = json["avatarName"].stringValue
                    let email = json["email"].stringValue
                    let name = json["name"].stringValue
                    UserDataService.instance.setUserData(id: id, color: color, avatarName: avatarName, email: email, name: name)
                } catch {
                    print (error.localizedDescription)
                }
                
            } else {
                //this completion method will tell us if the .request was a failure
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
        
        
    }
    
    func setUserInfo(data: Data) {
        do{
        let json = try JSON(data: data)
            let id = json["_id"].stringValue
            let color = json["avatarColor"].stringValue
            let avatarName = json["avatarName"].stringValue
            let email = json["email"].stringValue
            let name = json["name"].stringValue
            UserDataService.instance.setUserData(id: id, color: color, avatarName: avatarName, email: email, name: name)
        } catch {
             print (error.localizedDescription)
        }
        //putting the data we get back from our response AND CALL THAT FUNCTION FROM UserDataService TO SET THE USERDATA VARIABLES!
        
    }
    
    
    
    
    
    
    
}
