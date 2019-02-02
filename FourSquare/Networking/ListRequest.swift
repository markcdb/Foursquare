//
//  ListRequest.swift
//  FourSquare
//
//  Created by Mark Christian Buot on 31/01/2019.
//  Copyright © 2019 Mark Christian Buot. All rights reserved.
//

import Foundation
import Networking

class ListRequest: Request {
    
    var path: String
    var method: HTTPMethod
    var successCompletion: ((ListResponse) -> Void)!
    var errorCompletion: ((ErrorResponse) -> Void)!
    
    init(path: String,
         method: HTTPMethod) {
        
        self.path = path
        self.method = method
    }
    
    func getCompletion() -> (JSONResult) -> Void {

        return { result in
            
            switch result {
            case .success(let response):
                let responseDict = response.dictionaryBody
                
                print("""
                    path:\(self.path)
                    response: \(String(describing: responseDict[Keys.response] ?? ""))
                    """)
                
                let statusCode = responseDict[Keys.statusCode] as? Int ?? 0
                let message = responseDict[Keys.message] as? String ?? ""
                var response = responseDict[Keys.response] as? [String: Any] ?? [:]
                let data = response[Keys.venues] as? [[String: Any]] ?? []
                let successResponse = ListResponse(statusCode: statusCode,
                                               message: message,
                                               data: data)
                
                self.successCompletion(successResponse)
            case .failure(let response):
                let responseDict = response.dictionaryBody
                var errorResponse: ErrorResponse!
                var statusCode = 0
                var message = ""
                var error = ""
                
                if !responseDict.isEmpty {
                    statusCode = responseDict[Keys.statusCode] as? Int ?? 0
                    message = responseDict[Keys.message] as? String ?? ""
                    error = responseDict[Keys.error] as? String ?? ""
                }
                else{
                    statusCode = response.error.code
                    message = response.error.localizedDescription
                    error = response.error.domain
                }
                
                errorResponse = ErrorResponse(statusCode: statusCode,
                                              message: message,
                                              error: error)
                
                DispatchQueue.main.async {
                    self.errorCompletion(errorResponse)
                }
            }
        }
    }
}
