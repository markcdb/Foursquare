//
//  API.swift
//  FourSquare
//
//  Created by Mark Christian Buot on 30/01/2019.
//  Copyright © 2019 Mark Christian Buot. All rights reserved.
//

import Foundation
import Networking

enum HTTPMethod {
    case get
    case post
}

class API {
    
    private var networking: Networking?
    public var host: String
    
    init(host: String) {
        
        self.host = host
        self.networking = Networking(baseURL: host)
    }
    
    private func createQueryString(from parameters: [String: Any]) -> String {
        var queryString = ""
        if parameters.keys.count > 0 {
            queryString.append("?")
            let sortedKeys = parameters.keys.sorted()
            for key in sortedKeys {
                queryString.append("\(key)=\(parameters[key] ?? "")")
                if sortedKeys.last != key {
                    queryString.append("&")
                }
            }
        }
        return queryString
    }
    
    public func request(jsonRequest: JSONRequest? = nil,
                              request: Request) {
        
        let method = request.method
        let path = request.path
        
        let completion: (_ result: JSONResult) -> Void = request.getCompletion()
        
        print("Requesting from: \(path)")
        
        switch method {
        case .get:
            var queryString = ""
            if let parameters = jsonRequest?.parameters {
                
                queryString = jsonRequest != nil ? createQueryString(from: parameters) : ""
                queryString = queryString.addingPercentEncoding(
                    withAllowedCharacters: NSCharacterSet.urlQueryAllowed) ?? ""
            }
            
            self.networking?.get("\(path)\(queryString)",
                completion: completion)
        case .post:
            self.networking?.post(path,
                                  parameters: jsonRequest?.parameters,
                                  completion: completion)
        }
    }
}
