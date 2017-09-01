//
//  JsonSerializer.swift
//  Pods
//
//  Created by Elliot Schrock on 8/31/17.
//
//

import UIKit

public class JsonSerializer: NSObject {
    public static func serialize(_ data: Data?) -> Any? {
        if let jsonData = data {
            do {
                let json = try JSONSerialization.jsonObject(with: jsonData, options: JSONSerialization.ReadingOptions.allowFragments)
                return json
            } catch {
                return nil
            }
        } else {
            return nil
        }
    }
}
