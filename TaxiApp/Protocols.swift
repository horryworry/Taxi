//
//  Protocols.swift
//  TaxiApp
//
//  Created by Atay Sultangaziev on 8/17/18.
//  Copyright © 2018 Atay Sultangaziev. All rights reserved.
//
import CoreLocation
import MapKit

protocol MainViewControllerDelegate {
    var mapView: MKMapView! { get set }
}

protocol TaxiDelegate {
    func getTaxiData(at: CLLocation, completion: @escaping ([Taxi]?) -> ())
}

protocol ViewDelegate {
    func updateViewFromModel(at location: CLLocation, with taxiArray: [Taxi])
}
