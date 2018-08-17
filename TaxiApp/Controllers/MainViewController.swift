//
//  MainViewController.swift
//  TaxiApp
//
//  Created by Atay Sultangaziev on 6/16/18.
//  Copyright © 2018 Atay Sultangaziev. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MainViewController: UIViewController, MainViewControllerDelegate {

    var viewDelegate: ViewDelegate?
    var modelDelegate: TaxiDelegate?
    
    var locationManager = CLLocationManager()
    
    var taxiDataArray = [Taxi]()
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        askUserForLocation()
        setupDelegateLogic()
        
        
    }
    
    func setupDelegateLogic() {
        mapView.delegate = self
        let view = View()
        viewDelegate = view
        view.controllerDelegate = self
        let taxiModel = Taxi(latitude: 0, longitude: 0, contact: "", name: "", icon: "")
        modelDelegate = taxiModel
    }
    
    func downloadData() {
        modelDelegate?.getTaxiData(at: locationManager.location!, completion: { (results: [Taxi]?) in
            if let taxiData = results {
                self.taxiDataArray = taxiData
                self.viewDelegate?.updateViewFromModel(at: self.locationManager.location!, with: self.taxiDataArray)
            }
        })
    }
    
    func askUserForLocation() {
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
        let authorizationCode = CLLocationManager.authorizationStatus()
        
        if authorizationCode == .notDetermined && locationManager.responds(to: #selector(CLLocationManager.requestAlwaysAuthorization)) || locationManager.responds(to: #selector(CLLocationManager.requestWhenInUseAuthorization)) {
            
            if Bundle.main.object(forInfoDictionaryKey: "NSLocationAlwaysUsageDescription") != nil {
                locationManager.requestAlwaysAuthorization()
                
            } else {
                print("No description provided")
            }
            
        }
    }
    
    
    
    
}

