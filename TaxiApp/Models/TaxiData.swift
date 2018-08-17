//
//  Taxi.swift
//  TaxiApp
//
//  Created by Atay Sultangaziev on 6/16/18.
//  Copyright © 2018 Atay Sultangaziev. All rights reserved.
//


import Foundation
import CoreLocation


struct TaxiData: Decodable {

    struct company: Decodable {
        var contacts: [contact]
        var drivers: [driver]
        var name: String
        var icon: String
    }

    struct driver: Decodable {
        var lat: Double
        var lon: Double
    }

    struct contact: Decodable {
        var contact: String
        var type: String
    }

    var companies: [company]
    var success: Bool
}


