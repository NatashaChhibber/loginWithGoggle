//
//  MapView.swift
//  24_03
//
//  Created by Appinventiv on 27/03/18.
//  Copyright © 2018 Appinventiv. All rights reserved.
//

import UIKit
import GoogleMaps

class MapView: UIViewController {

    var Lat,Long:CLLocationDegrees!
    let locationManager = CLLocationManager()
    var mapView:GMSMapView!

    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self as? CLLocationManagerDelegate
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled()
          {
            locationManager.delegate = self as? CLLocationManagerDelegate
            locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
            locationManager.startUpdatingLocation()
            
          }
    }

    override func didReceiveMemoryWarning()
     {
        super.didReceiveMemoryWarning()
     }
   

    override func loadView()
        {
            let camera = GMSCameraPosition.camera(withLatitude: 28.6060, longitude: 77.3623, zoom: 16.0)
            mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
            view = mapView
            
            let marker = GMSMarker()
            marker.position = CLLocationCoordinate2D(latitude: 28.6060, longitude: 77.3623)
            marker.title = "Appinventiv"
            marker.snippet = "India"
            marker.map = mapView
        }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        print("locations = \(locValue.latitude) \(locValue.longitude)")
        self.Lat = locValue.latitude
        self.Long = locValue.longitude
    }
    

}
