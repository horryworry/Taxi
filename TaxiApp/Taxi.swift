//
//  Taxi.swift
//  TaxiApp
//
//  Created by Atay Sultangaziev on 6/16/18.
//  Copyright © 2018 Atay Sultangaziev. All rights reserved.
//


import Foundation
import CoreLocation

struct Taxi {
    let name: String
    let icon: String
    let latitude: Double
    let longitude: Double
    let phone: String
    
    enum SerializationError:Error {
        case missing(String)
        case invalid(String, Any)
    }
    
    
    init(json:[String:Any]) throws {
        guard let name = json["name"] as? String else {throw SerializationError.missing("name is missing")}
        
        guard let icon = json["icon"] as? String else {throw SerializationError.missing("icon is missing")}
        
        guard let latitude = json["lat"] as? Double else {throw SerializationError.missing("latitude is missing")}
        
        guard let longitude = json["lon"] as? Double else {throw SerializationError.missing("longitude is missing")}
        
        guard let phone = json["phone"] as? String else {throw SerializationError.missing("phone is missing")}
        
        self.name = name
        self.icon = icon
        self.latitude = latitude
        self.longitude = longitude
        self.phone = phone
    }
    
    
    static let basePath = "http://openfreecabs.org/nearest/"
    
    static func taxiAround (withLocation location:CLLocationCoordinate2D?, completion: @escaping ([Taxi]?) -> ()) {

        if let currentLocation = location {
            let url = basePath + "\(currentLocation.latitude)/\(currentLocation.longitude)"
            let request = URLRequest(url: URL(string: url)!)
            
            let task = URLSession.shared.dataTask(with: request) { (data:Data?, response:URLResponse?, error:Error?) in
                
                var taxiArray:[Taxi] = []
                if let data = data {
                    
                    do {
                        if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any] {
                            
                            let success = json["success"] as? Bool
                            if success == true {
                                
                                var phone: [String: String] = ["phone": ""]
                                
                                if let companies = json["companies"] as? [[String:Any]] {
                                    for company in companies {
                                        if let contacts = company["contacts"] as? [[String: Any]] {
                                            let contact = contacts[1]
                                            let phone1 = contact["contact"] as? String
                                            phone = ["phone": phone1] as! [String : String]
                                            
                                            
                                        }
                                    }
                                    for company in companies {
                                        let name = ["name": company["name"]] as? [String: String]
                                        let icon = ["icon": company["icon"]] as? [String: String]
                                        
                                        
                                        if let drivers = company["drivers"] as? [[String:Any]] {
                                            
                                            for driver in drivers {
                                                
                                                let nameCombined = driver.merging(name!) { $1 }
                                                let iconCombined = nameCombined.merging(icon!) { $1 }
                                                let phoneCombined = iconCombined.merging(phone) { $1 }
                                                
                                                if let taxiObject = try? Taxi(json: phoneCombined) {
                                                    taxiArray.append(taxiObject)
                                                    
                                                }
                                            }
                                            
                                        }
                                        
                                    }
                                }
                            }
                            
                            
                        }
                    }catch {
                        print(error.localizedDescription)
                    }
                    
                    completion(taxiArray)
                    
                }
                
                
            }
            
            task.resume()
            
        }
        }
        
    
    
}

