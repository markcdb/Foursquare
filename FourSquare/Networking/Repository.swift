//
//  Repository.swift
//  FourSquare
//
//  Created by Mark Christian Buot on 31/01/2019.
//  Copyright © 2019 Mark Christian Buot. All rights reserved.
//

import Foundation

protocol RepositoryProtocol {
    
    static var shared: RepositoryProtocol { get }
    
    func getVenues(location: Location,
                   onSuccess success: @escaping (([FoursquareLocation]) -> Void),
                   onError error: @escaping ((NSError) -> Void))
}

final class Repository: RepositoryProtocol {
    
    static var shared: RepositoryProtocol = Repository()
    private var api: API!

    // MARK: - Init
    
    private init() {
        api = API(host: NetworkConfig.baseUrl)
    }
    
    func getVenues(location: Location,
                   onSuccess success: @escaping (([FoursquareLocation]) -> Void),
                   onError error: @escaping ((NSError) -> Void)) {
        
        // Construct the request object (ListRequest)
        var path = Paths.venues
        path = path.replacingOccurrences(of: URLParameters.lat, with: location.lat)
        path = path.replacingOccurrences(of: URLParameters.lng, with: location.lng)
        
        let request = ListRequest(path: path,
                                  method: .get)
        
        request.successCompletion = { response in
            var venues = response.data.compactMap({ (data) -> FoursquareLocation? in
                let venue = FoursquareLocation(json: data)
                
                return venue
            })
            
            venues = venues.sorted(by: { (fs1, fs2) -> Bool in
                let minDistance = Float(fs1.distance) ?? 0.0
                let maxDistance = Float(fs2.distance) ?? 0.0
                
                return minDistance < maxDistance
            })
            
            success(venues)
        }
        
        request.errorCompletion = { response in
            let userInfo = [Keys.error: response.error,
                            Keys.message: response.message!]
            
            let err = NSError(domain: response.error,
                                code: response.statusCode,
                                userInfo: userInfo)
            
            error(err)
        }
        
        api.request(request: request)
    }
}
