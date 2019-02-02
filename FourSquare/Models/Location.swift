//
//  Location.swift
//  FourSquare
//
//  Created by Mark Christian Buot on 31/01/2019.
//  Copyright © 2019 Mark Christian Buot. All rights reserved.
//

import Foundation

class Location {
    var id: String
    var lat: String
    var lng: String
    
    init(id: String,
         lat: String,
         lng: String) {
        
        self.id = id
        self.lat = lat
        self.lng = lng
    }
}
