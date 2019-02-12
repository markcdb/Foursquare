//
//  FoursquareState.swift
//  FourSquare
//
//  Created by Mark Christian Buot on 08/02/2019.
//  Copyright © 2019 Mark Christian Buot. All rights reserved.
//

import Foundation

struct FoursquareState {
    
    var venue: [FoursquareLocation] = []
    var state: ViewState!
}

extension FoursquareState {
    
    mutating func insertVenue(_ venue: [FoursquareLocation]) {
        self.venue = venue
    }
}
