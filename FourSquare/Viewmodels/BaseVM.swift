//
//  BaseVM.swift
//  FourSquare
//
//  Created by Mark Christian Buot on 31/01/2019.
//  Copyright © 2019 Mark Christian Buot. All rights reserved.
//

import Foundation

enum ViewState: Equatable {
    case loading(String?)
    case success(String?)
    case error(String?)
    
    func getString() -> String {
        switch self {
        case .loading(let str):
            return str ?? ""
        case .success(let str):
            return str ?? ""
        case .error(let str):
            return str ?? ""
        }
    }
    
    static func == (lhs: ViewState, rhs: ViewState) -> Bool {

        switch (lhs, rhs) {
        case (.loading(_), .loading(_)):
            return true
        case (.success(_), .success(_)):
            return true
        case (.error(_), .error(_)):
            return true
        default:
            return false
        }
    }
    
    static func != (lhs: ViewState, rhs: ViewState) -> Bool {
        
        switch (lhs, rhs) {
        case (.loading(_), .loading(_)):
            return false
        case (.success(_), .success(_)):
            return false
        case (.error(_), .error(_)):
            return false
        default:
            return true
        }
    }
}

class BaseVM: NSObject {
    
    var repository: RepositoryProtocol!
    open var state: ViewState!
}
