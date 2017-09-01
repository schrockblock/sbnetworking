//
//  NetworkErrorMessaging.swift
//  Pods
//
//  Created by Elliot Schrock on 8/31/17.
//
//

import UIKit

public protocol ErrorMessage {
    var title: String { get }
    var message: String { get }
    var forCode: Int { get }
}

public protocol NetworkErrorMessaging {
    var errorMessages: [ErrorMessage]? { get }
}

public struct DefaultServerUnavailableErrorMessage: ErrorMessage {
    public let title: String = "Ruh Roh"
    public let message: String = "The server is unavailable! Try again in a bit. If this keeps happening, please let us know!"
    public let forCode: Int = 503
}

public struct DefaultServerIssueErrorMessage: ErrorMessage {
    public let title: String = "Ruh Roh"
    public let message: String = "Looks like we're having a problem. Please let us know about it!"
    public let forCode: Int = 500
}

public struct DefaultOfflineErrorMessage: ErrorMessage {
    public let title: String = "Hmmm..."
    public let message: String = "Looks like you're offline. Try reconnecting to the internet!"
    public let forCode: Int = -1009
}

public struct DefaultErrorMessaging: NetworkErrorMessaging {
    public var errorMessages: [ErrorMessage]? = [DefaultServerUnavailableErrorMessage(), DefaultServerIssueErrorMessage(), DefaultOfflineErrorMessage()]
}
