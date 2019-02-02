//
//  Response.swift
//  FourSquare
//
//  Created by Mark Christian Buot on 30/01/2019.
//  Copyright © 2019 Mark Christian Buot. All rights reserved.
//

import Foundation

protocol Response {
    var statusCode: Int { get set }
    var message: String? { get set }
}

struct SingleResponse: Response {
    var statusCode: Int
    var message: String?
    var data: [String: Any]
}

struct ListResponse: Response {
    var statusCode: Int
    var message: String?
    var data: [[String: Any]]
}

struct ErrorResponse: Response {
    var statusCode: Int
    var message: String?
    var error: String
}
