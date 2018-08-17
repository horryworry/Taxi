//
//  View.swift
//  TaxiApp
//
//  Created by Atay Sultangaziev on 8/17/18.
//  Copyright © 2018 Atay Sultangaziev. All rights reserved.
//

import Foundation
import MapKit

class View: ViewDelegate {
    
    var controllerDelegate: MainViewControllerDelegate?
    
    func updateViewFromModel(at location: CLLocation, with taxiArray: [Taxi]) {
        print("updateViewFromModel")
        let centerLocation = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
        let region = MKCoordinateRegion(center: centerLocation, span: MKCoordinateSpanMake(0.005, 0.005))
        controllerDelegate?.mapView.setRegion(region, animated: true)
        
        let pin = CustomPin(pinTitle: "It's Me", pinSubTitle: "", imageName: "pin", phone: "", location: centerLocation)
        controllerDelegate?.mapView.addAnnotation(pin)
        
        
        
        for taxi in taxiArray {
            
            let centerLocation = CLLocationCoordinate2D(latitude: taxi.latitude, longitude: taxi.longitude)
            
            let pin = CustomPin(pinTitle: taxi.name, pinSubTitle: taxi.contact, imageName: "car", phone: taxi.contact, location: centerLocation)
            controllerDelegate?.mapView.addAnnotation(pin)
            
        }
        
        
    }
}
