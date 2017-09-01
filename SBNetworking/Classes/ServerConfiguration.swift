//
//  ServerConfiguration.swift
//  Pods
//
//  Created by Elliot Schrock on 8/31/17.
//
//

import UIKit

public protocol ServerConfigurationProtocol {
    var scheme: String { get }
    var host: String { get }
    var apiRoute: String? { get }
}

open class ServerConfiguration: ServerConfigurationProtocol {
    public static var defaultConfiguration: ServerConfiguration?
    public let scheme: String
    public let host: String
    public let apiRoute: String?
    
    public init(scheme: String, host: String, apiRoute: String?) {
        self.scheme = scheme
        self.host = host
        self.apiRoute = apiRoute
    }
}
