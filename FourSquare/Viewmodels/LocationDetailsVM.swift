//
//  LocationDetailsVM.swift
//  FourSquare
//
//  Created by Mark Christian Buot on 02/02/2019.
//  Copyright © 2019 Mark Christian Buot. All rights reserved.
//

import Foundation

class LocationDetailsVM: BaseVM {
    
    private var venue: FoursquareLocation!
    private var values: [[String: String]] = []
    
    init(venue: FoursquareLocation) {
        super.init()
        self.venue = venue
        
        self.values.append(["Key": getName() ?? ""])
        self.values.append(["Address": getFormattedAddress() ?? ""])
        self.values.append(["Lat": getLat() ?? ""])
        self.values.append(["Long": getLong() ?? ""])
    }
    
    public func getName() -> String? {
        
        return venue.name
    }

    public func getFormattedAddress() -> String? {
        
        return venue.formattedAddress
    }
    
    public func getLat() -> String? {
        
        return venue.lat
    }
    
    public func getLong() -> String? {
        
        return venue.lng
    }
    
    public func getValueAt(_ index: Int) -> [String: Any]? {
        guard index < values.count else { return nil }
        
        return values[index]
    }
}
