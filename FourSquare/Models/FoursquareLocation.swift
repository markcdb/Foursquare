//
//  FoursquareLocation.swift
//  FourSquare
//
//  Created by Mark Christian Buot on 31/01/2019.
//  Copyright © 2019 Mark Christian Buot. All rights reserved.
//

import Foundation

class FoursquareLocation: Location {
    
    var name: String!
    var address: String!
    var cc: String!
    var city: String!
    var crossStreet: String!
    var distance: String!
    var formattedAddress: String!
    var postalCode: String!
    var state: String!
    
    
    init(json: [String: Any]) {
        let id = json["id"] as? String ?? ""
        let name = json["name"] as? String ?? ""
        let location = json["location"] as? [String: Any]
        
        let lat = "\(location?["lat"] ?? 0.0)"
        let lng = "\(location?["lng"] ?? 0.0)"
        let distance = "\(location?["distance"] ?? 0.0)"
        let postalCode = "\(location?["postalCode"] ?? 0)"
        let formattedAddress = location?["formattedAddress"] as? [String] ?? []
        
        self.name = name
        self.address = location?["address"] as? String ?? ""
        self.cc = location?["cc"] as? String ?? ""
        self.city = location?["city"] as? String ?? ""
        self.crossStreet = location?["crossStreet"] as? String ?? ""
        self.distance = distance
        self.formattedAddress = formattedAddress.joined(separator: ", ")
        self.postalCode = postalCode
        self.state = location?["state"] as? String ?? ""
        
        super.init(id: id,
                   lat: lat,
                   lng: lng)
        
    }
}
