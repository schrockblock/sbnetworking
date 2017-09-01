//
//  AuthenticatedNetworkCall.swift
//  SBNetworking
//
//  Created by Elliot Schrock on 8/31/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit
import SBNetworking

open class AuthenticatedNetworkCall: BaseNetworkCall {
    fileprivate static let apiKeyHeader = "Auth"
    
    override init() {
        super.init()
        if var headers = httpHeaders, let apiKey = AuthManager.apiKey() {
            headers[AuthenticatedNetworkCall.apiKeyHeader] = apiKey
        }
    }
}
