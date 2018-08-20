//
//  TaxiModel.swift
//  TaxiApp
//
//  Created by Atay Sultangaziev on 8/15/18.
//  Copyright © 2018 Atay Sultangaziev. All rights reserved.


import CoreLocation

struct Taxi {
    
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

}
