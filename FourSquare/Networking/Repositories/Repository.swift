//
//  Repository.swift
//  FourSquare
//
//  Created by Mark Christian Buot on 31/01/2019.
//  Copyright © 2019 Mark Christian Buot. All rights reserved.
//

import Foundation

protocol RepositoryProtocol {
    //Screen specific request
    func request()
}

class Repository: RepositoryProtocol {
    
    var api: API!
    var requests: [Request] = [] {
        didSet {
            if requests.isEmpty == false {
                request()
            }
        }
    }
    
    func request() {
        // Construct the request object (ListRequest)
        guard let currRequest = requests.last else { return }
        api.request(request: currRequest)
    }
}
