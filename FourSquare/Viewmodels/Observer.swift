//
//  Observer.swift
//  FourSquare
//
//  Created by Mark Christian Buot on 08/02/2019.
//  Copyright © 2019 Mark Christian Buot. All rights reserved.
//

import Foundation

class Observer<T> {
    
    var subscription: ((T) -> Void) = {_ in}
    
    var value: T {
        didSet {
            subscription(value)
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
}
