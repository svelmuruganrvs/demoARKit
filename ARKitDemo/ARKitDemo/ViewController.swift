//
//  ViewController.swift
//  ARKitDemo
//
//  Created by velmurugan on 31/12/17.
//  Copyright © 2017 Velmurugan. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation



class ViewController: UIViewController,CLLocationManagerDelegate,MKMapViewDelegate {
    @IBOutlet weak var mapView: MKMapView!
    
    var locationManager : CLLocationManager? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.showsUserLocation = true
        mapView.isZoomEnabled = true
        mapView.isScrollEnabled = true
        mapView.delegate = self
        
        locationManager = CLLocationManager.init()
        locationManager?.delegate = self
        locationManager?.desiredAccuracy = kCLLocationAccuracyBest
        locationManager?.requestAlwaysAuthorization()

        
        if CLLocationManager.locationServicesEnabled() {
            locationManager?.startUpdatingLocation()
        }


        // Do any additional setup after loading the view, typically from a nib.
    }
    private func locationManager(manager: CLLocationManager!,
                         didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        switch status {
        case CLAuthorizationStatus.restricted:
            print ("Restricted Access to location")
        case CLAuthorizationStatus.denied:
            print ("User denied access to location")
        case CLAuthorizationStatus.notDetermined:
            print ("Status not determined")
        default:
            print ("Allowed to location Access")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
extension ViewController  {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation:CLLocation = locations[0] as CLLocation
        
        let center = CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        
        mapView.setRegion(region, animated: true)
    }
    private func locationManager(manager: CLLocationManager, didFailWithError error: Error)
    {
        print("Error \(error)")
    }
}
extension ViewController  {
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView)  {
        if let annotationTitle = view.annotation?.title
        {
            print("User tapped on annotation with title: \(annotationTitle!)")
            self.performSegue(withIdentifier: "ARDemoViewControllerSegueID", sender: nil)
        }
    }
}
