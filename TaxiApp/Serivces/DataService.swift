//
//  DataService.swift
//  TaxiApp
//
//  Created by Atay Sultangaziev on 8/20/18.
//  Copyright © 2018 Atay Sultangaziev. All rights reserved.
//

import CoreLocation


struct DataService {
    
    static func getTaxiData(at currentLocation: CLLocation, completion: @escaping (Data?) -> ()) {
        
        let basePath = "http://openfreecabs.org/nearest/"
        
        guard let url = URL(string: basePath + "\(currentLocation.coordinate.latitude)/\(currentLocation.coordinate.longitude)") else {return}
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error == nil {
                completion(data)
            }
            
        }
        
        task.resume()
        
    }
    
}
