//
//  Extensions.swift
//  TaxiApp
//
//  Created by Atay Sultangaziev on 8/16/18.
//  Copyright © 2018 Atay Sultangaziev. All rights reserved.
//

import Foundation
import MapKit

extension MainViewController: MKMapViewDelegate {
    
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
}

extension MainViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        if (status == CLAuthorizationStatus.denied) {
            // do nothing
        } else if status == CLAuthorizationStatus.authorizedAlways || status == CLAuthorizationStatus.authorizedWhenInUse {
            downloadData()
        }
        
    }
    
}
