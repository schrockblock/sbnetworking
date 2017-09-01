//
//  LoginNetworkCall.swift
//  SBNetworking
//
//  Created by Elliot Schrock on 8/31/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit
import SBNetworking
import Eson

open class LoginNetworkCall: BaseNetworkCall {
    fileprivate static let usernameKey = "username"
    fileprivate static let passwordKey = "password"
    
    override init() {
        super.init()
        endpoint = "user/auth/local/login"
        httpMethod = "POST"
    }
    
    func login(username: String, password: String, completion: @escaping ((LoginSuccessObject?, NSError?) -> Void)) {
        let json = [LoginNetworkCall.usernameKey: username, LoginNetworkCall.passwordKey: password]
        do {
            try postData = JSONSerialization.data(withJSONObject: json, options: JSONSerialization.WritingOptions.prettyPrinted)
        } catch let parseError as NSError {
            NSLog("Parse error: %@", parseError.localizedDescription);
        }
        
        execute { (object, error) in
            if let json = object as? [String: AnyObject] {
                let responseObject = Eson().fromJsonDictionary(json, clazz: ResponseObject<LoginSuccessObject>.self)
                completion(responseObject?.dataObject(), error)
            }else{
                completion(nil, error)
            }
        }
    }
}
