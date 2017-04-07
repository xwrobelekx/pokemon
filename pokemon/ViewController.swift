//
//  ViewController.swift
//  pokemon
//
//  Created by Kamil Wrobel on 4/7/17.
//  Copyright © 2017 Kamil Wrobel. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate {

    
    @IBOutlet weak var mapView: MKMapView!
    
    
    
    
    // this var gives us acces to location, so we can do some work with it later
    var locationManager = CLLocationManager()
    
    // this variable will allow as later to control the locati on map update.
    var updateCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        locationManager.delegate = self
        
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            print("ready to go")
            mapView.showsUserLocation = true
            
            // this code gives your current location
            
            locationManager.startUpdatingLocation()
            
            
        } else {
            locationManager.requestWhenInUseAuthorization()
        }
        
        
    }
    
    
    //this function tell the delegate that the location was updated, and that there is a new location avaliable
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("we made it")
        
        if updateCount < 7 {
        
        // this region constant takes your curent location, and then u set up how much the map should be zoomed in
        let region = MKCoordinateRegionMakeWithDistance(locationManager.location!.coordinate, 1000, 1000)
        
        // this sshows your current location on map zoomed in when app is lunched
        mapView.setRegion(region, animated: false)
            
            updateCount += 1
        }
    }
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

