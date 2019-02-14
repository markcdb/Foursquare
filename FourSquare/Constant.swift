//
//  Constant.swift
//  FourSquare
//
//  Created by Mark Christian Buot on 30/01/2019.
//  Copyright © 2019 Mark Christian Buot. All rights reserved.
//

import Foundation

struct NetworkConfig {
    
    static let baseUrl = "https://api.foursquare.com/v2"
}

struct Tokens {
    static let gmAppKey = "AIzaSyD_HKvigKHS0yJhODqL3CO2P3BUzGlcLEI"
    static let fsClientId = "ODRZVQEOVPDLALISFYCTVUTJCX4VM2Q24GS5V1K1L4X01QRY"
    static let fsClientSecret = "ZWCXPIANUAYF40LC53NFCDAL2UPOEX4GBRNTLY1LPQUXWSFP"
}

struct Paths {
    
   
    static let venues = "/venues/search?ll=$[lat],$[lng]&client_id=\(Tokens.fsClientId)&client_secret=\(Tokens.fsClientSecret)&v=20190131"
}

struct Keys {
    
    static let language = "language"
    static let statusCode = "statusCode"
    static let message = "message"
    static let response = "response"
    static let venues = "venues"
    static let error = "error"
    static let hosts = "hosts"
    static let hostResponses = "hostResponses"
}

struct Cells {
    
    static let locationCell = "LocationCell"
    static let loaderCell = "LoaderCell"
    static let permissionCell = "PermissionCell"
    static let locationTitleCell = "LocationTitleCell"
    static let locationDetailsCell = "LocationDetailsCell"
}

struct URLParameters {
    
    static let lat = "$[lat]"
    static let lng = "$[lng]"
}

struct Titles {
    
    static let nearby = "Nearby"
}

struct Segues {
    
    static let locationDetails = "LocationDetailsVC"
}
