//
//  SingleRequest.swift
//  FourSquare
//
//  Created by Mark Christian Buot on 31/01/2019.
//  Copyright © 2019 Mark Christian Buot. All rights reserved.
//

import Foundation
import Networking

class SingleRequest: Request {
    
    var path: String
    var method: HTTPMethod
    var successCompletion: ((SingleResponse) -> Void)!
    var errorCompletion: ((ErrorResponse) -> Void)!
    
    init(path: String,
         method: HTTPMethod) {
        
        self.path = path
        self.method = method
    }
    
    func getCompletion() -> (JSONResult) -> Void {
        return { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let response):
                let responseDict = response.dictionaryBody
                
                print("""
                    path:\(self.path)
                    response: \(String(describing: responseDict[Keys.response] ?? ""))
                    """)
                
                let statusCode = responseDict[Keys.statusCode] as? Int ?? 0
                let message = responseDict[Keys.message] as? String ?? ""
                let data = responseDict[Keys.response] as? [String: Any] ?? [:]
                
                let successResponse = SingleResponse(statusCode: statusCode,
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
                
                self.errorCompletion(errorResponse)
            }
        }
    }
}
