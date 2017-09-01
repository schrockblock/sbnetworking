//
//  BaseNetworkCall.swift
//  Pods
//
//  Created by Elliot Schrock on 8/31/17.
//
//

import UIKit

open class BaseNetworkCall: NSObject {
    public var configuration: ServerConfigurationProtocol! = ServerConfiguration.defaultConfiguration
    public var errorMessaging: NetworkErrorMessaging? = DefaultErrorMessaging()
    public var endpoint: String!
    public var httpMethod: String! = "GET"
    public var postData: Data?
    public var httpHeaders: Dictionary<String, String>? = ["Content-type": "application/json", "Accept": "application/json"]
    fileprivate var task: URLSessionTask?
    
    public func execute(_ completion: @escaping ((Any?, NSError?) -> Void)){
        let session = URLSession(configuration: URLSessionConfiguration.default, delegate: nil, delegateQueue: OperationQueue.main)
        let request = mutableRequest()
        task = session.dataTask(with: request as URLRequest) { (data, response, error) in
            if let connectionError = error as NSError? {
                self.handleError(connectionError)
                completion(JsonSerializer.serialize(data), connectionError as NSError?)
            } else if let responseCode = (response as? HTTPURLResponse)?.statusCode {
                if responseCode < 300 {
                    completion(JsonSerializer.serialize(data), nil)
                } else {
                    let url = request.url?.absoluteString ?? ""
                    let serverError = NSError(domain: "Server", code: responseCode, userInfo: ["url" : url])
                    self.handleError(serverError)
                    completion(JsonSerializer.serialize(data), serverError)
                }
            }
        }
        task!.resume()
    }
    
    public func cancel() {
        task?.cancel()
    }
    
    open func mutableRequest() -> NSMutableURLRequest {
        let mutableRequest = NSMutableURLRequest()
        mutableRequest.url = url(endpoint)
        
        if let headers = httpHeaders {
            for key in headers.keys {
                mutableRequest.addValue(headers[key]!, forHTTPHeaderField: key)
            }
        }
        
        mutableRequest.httpMethod = httpMethod
        if httpMethod != "GET" {
            mutableRequest.httpBody = postData
        }
        
        return mutableRequest
    }
    
    open func url(_ endpoint: String) -> URL? {
        let baseUrlString = "\(configuration.scheme)://\(configuration.host)/"
        if let apiRoute = configuration.apiRoute {
            return URL(string: "\(baseUrlString)/\(apiRoute)/\(endpoint)")
        } else {
            return URL(string: "\(baseUrlString)/\(endpoint)")
        }
    }
    
    open func handleError(_ error: NSError) {
        if let messages = self.errorMessaging?.errorMessages {
            for errorMessage in messages {
                if error.code == errorMessage.forCode {
                    self.notify(title: errorMessage.title, message: errorMessage.message)
                    break
                }
            }
        }
    }
    
    open func notify(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
        }))
        alert.show()
    }
}

extension UIAlertController {
    
    public func show(animated flag: Bool = true, completion: (() -> Void)? = nil) {
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = UIViewController()
        window.backgroundColor = UIColor.clear
        window.windowLevel = UIWindowLevelAlert
        
        if let rootViewController = window.rootViewController {
            window.makeKeyAndVisible()
            
            rootViewController.present(self, animated: flag, completion: completion)
        }
    }
}
