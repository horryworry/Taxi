//
//  CustomPin.swift
//  TaxiApp
//
//  Created by Atay Sultangaziev on 6/16/18.
//  Copyright © 2018 Atay Sultangaziev. All rights reserved.
//

import UIKit
import MapKit

class CustomPin: NSObject, MKAnnotation {
    
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    var imageName: String?
    var phone: String?
    
    init(pinTitle: String, pinSubTitle: String, imageName: String, phone: String, location: CLLocationCoordinate2D) {
        self.title = pinTitle
        self.subtitle = pinSubTitle
        self.coordinate = location
        self.imageName = imageName
        self.phone = phone
    }
    
}
