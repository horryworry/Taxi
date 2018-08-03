//
//  MainViewController.swift
//  TaxiApp
//
//  Created by Atay Sultangaziev on 6/16/18.
//  Copyright © 2018 Atay Sultangaziev. All rights reserved.
//

import UIKit
import MapKit
import Cluster

class MainViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    
    var locationManager = CLLocationManager()
    var taxiDataArray = [Taxi]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLocation()
        mapView.delegate = self
        
    }
    
    func setupLocation() {
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
    
    func getTaxiData() {
        Taxi.taxiAround(withLocation: locationManager.location?.coordinate, completion: { (results:[Taxi]?) in

            if let taxiData = results {
                self.taxiDataArray = taxiData
                self.getLocation()
            }

        })
        
    }
    
    func getLocation() {
        displayLocation(location: locationManager.location!)
        displayOtherTaxi(taxi: taxiDataArray)
    }
    
    func displayLocation(location: CLLocation) {
        let centerLocation = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
        let region = MKCoordinateRegion(center: centerLocation, span: MKCoordinateSpanMake(0.005, 0.005))
        mapView.setRegion(region, animated: true)
        
        let pin = CustomPin(pinTitle: "It's Me", pinSubTitle: "", imageName: "pin", phone: "", location: centerLocation)
        mapView.addAnnotation(pin)
        
    }
    
    func displayOtherTaxi(taxi: [Taxi]) {
        for singleTaxi in taxi {

            let centerLocation = CLLocationCoordinate2D(latitude: singleTaxi.latitude, longitude: singleTaxi.longitude)
            
            let pin = CustomPin(pinTitle: singleTaxi.name, pinSubTitle: singleTaxi.phone, imageName: "car", phone: singleTaxi.phone, location: centerLocation)
            mapView.addAnnotation(pin)
            
        }
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if !(annotation is CustomPin) {
            return nil
        }

        var annotationView = MKMarkerAnnotationView()
        guard let annotation = annotation as? CustomPin else {return nil}
        var identifier = ""
        var color = UIColor.red
        
        switch annotation.imageName{
        case "car":
            identifier = "Car"
            color = .red
        case "pin":
            identifier = "Pin"
            color = .blue
        default:
            print("I have an unexpected case.")
        }

        if let dequedView = mapView.dequeueReusableAnnotationView(
            withIdentifier: identifier)
            as? MKMarkerAnnotationView {
            annotationView = dequedView
        } else{
            annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView.canShowCallout = true
            annotationView.calloutOffset = CGPoint(x: -5, y: 5)
            annotationView.rightCalloutAccessoryView = UIButton(type: .infoDark)
        }
        annotationView.markerTintColor = color
        annotationView.glyphImage = UIImage(named: annotation.imageName!)
        annotationView.glyphTintColor = .yellow
        annotationView.clusteringIdentifier = identifier
        return annotationView

    }

    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView,
                 calloutAccessoryControlTapped control: UIControl) {
        let location = view.annotation as! CustomPin
        let url: NSURL = URL(string: "TEL://\(location.phone ?? "")")! as NSURL
        UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
    }
    
    
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        print("annotation title == \(String(describing: view.annotation?.title!))")
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if (status == CLAuthorizationStatus.denied) {
            // do nothing
        } else if status == CLAuthorizationStatus.authorizedAlways || status == CLAuthorizationStatus.authorizedWhenInUse {
            getTaxiData()
         }
        
    }
    
}

