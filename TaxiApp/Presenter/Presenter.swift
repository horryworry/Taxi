//
//  Presenter.swift
//  TaxiApp
//
//  Created by Atay Sultangaziev on 8/20/18.
//  Copyright © 2018 Atay Sultangaziev. All rights reserved.
//
import CoreLocation

protocol PresenterProtocol {
    func getAndParseData(location: CLLocation)
}

class Presenter: NSObject, PresenterProtocol {

    var view: ViewProtocol?

    var taxiDataArray = [Taxi]()
    
    func getAndParseData(location: CLLocation) {
        
        DataService.getTaxiData(at: location, completion: { (result: Data?) in
            if let data = result {
                
                do {
                    
                    // data we are getting from network request
                    let decoder = JSONDecoder()
                    let response = try decoder.decode(TaxiData.self, from: data)
                    if response.success == true {
                        for company in response.companies {
                            let icon = company.icon
                            let name = company.name
                            let contact = company.contacts[1].contact
                            for driver in company.drivers {
                                let taxi = Taxi(latitude: driver.lat, longitude: driver.lon, contact: contact, name: name, icon: icon)
                                self.taxiDataArray.append(taxi)
                            }
                            
                        }
                        DispatchQueue.main.async {
                            self.view?.updateViewFromModel(at: location, with: self.taxiDataArray)
                        }
                        
                    }
                    
                } catch { print(error) }
                
                
                
            }
        })
        
    }
    
    
    
}

