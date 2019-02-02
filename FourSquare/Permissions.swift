//
//  Permissions.swift
//  FourSquare
//
//  Created by Mark Christian Buot on 01/02/2019.
//  Copyright © 2019 Mark Christian Buot. All rights reserved.
//

import Foundation
import MapKit

internal enum Authorization: Int {
    case authorized = 0
    case rejected
    case notDetermined
}

class Permissions {
    
    static func isLocationServiceAuthorized(_ completion: @escaping ((Authorization) -> Void)) {
        let authorizationStatus = CLLocationManager.authorizationStatus()
        
        switch authorizationStatus {
        case .authorizedAlways:
            DispatchQueue.main.async {
                completion(.authorized)
            }
        case .authorizedWhenInUse:
            DispatchQueue.main.async {
                completion(.authorized)
            }
        case .denied:
            DispatchQueue.main.async {
                completion(.rejected)
            }
        case .notDetermined:
            DispatchQueue.main.async {
                completion(.notDetermined)
            }
        case .restricted:
            DispatchQueue.main.async {
                completion(.rejected)
            }
        }
    }
}
