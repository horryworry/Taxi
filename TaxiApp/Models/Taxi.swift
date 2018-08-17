//
//  TaxiModel.swift
//  TaxiApp
//
//  Created by Atay Sultangaziev on 8/15/18.
//  Copyright © 2018 Atay Sultangaziev. All rights reserved.


import CoreLocation

struct Taxi: TaxiDelegate {
    
    
    var latitude: Double
    var longitude: Double
    var contact: String
    var name: String
    var icon: String
    
    public init (latitude: Double, longitude: Double, contact: String, name: String, icon: String) {
        self.latitude = latitude
        self.longitude = longitude
        self.contact = contact
        self.name = name
        self.icon = icon
    }
    

    
    func getTaxiData(at currentLocation: CLLocation, completion: @escaping ([Taxi]?) -> ()) {

        var taxiDataArray:[Taxi] = []
        
        let basePath = "http://openfreecabs.org/nearest/"
        
        guard let url = URL(string: basePath + "\(currentLocation.coordinate.latitude)/\(currentLocation.coordinate.longitude)") else {return}
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard let dataResponse = data, error == nil  else {
                print(error?.localizedDescription ?? "Response Error")
                return }
            
            do {
                
                // data we are getting from network request
                let decoder = JSONDecoder()
                let response = try decoder.decode(TaxiData.self, from: dataResponse)
                if response.success == true {
                    for company in response.companies {
                        let icon = company.icon
                        let name = company.name
                        let contact = company.contacts[1].contact
                        for driver in company.drivers {
                            let taxi = Taxi(latitude: driver.lat, longitude: driver.lon, contact: contact, name: name, icon: icon)
                            taxiDataArray.append(taxi)
                        }
                    }
                }
                
                
            } catch { print(error) }
            
            completion(taxiDataArray)
            taxiDataArray = []
            
        }
        
        task.resume()
        
    }
    
}
