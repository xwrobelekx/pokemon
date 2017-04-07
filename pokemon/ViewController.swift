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
    var location3 = CLLocationManager()
    
    // this variable will allow as later to control the locati on map update.
    var updateCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        location3.delegate = self
        
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            print("ready to go")
            mapView.showsUserLocation = true
            
            // this code gives your current location
            
            location3.startUpdatingLocation()
            
            
        } else {
            location3.requestWhenInUseAuthorization()
        }
        
        
    }
    
    
    //this function tell the delegate that the location was updated, and that there is a new location avaliable
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("we made it")
        
        if updateCount < 4{
        
        // this region constant takes your curent location, and then u set up how much the map should be zoomed in
        let region = MKCoordinateRegionMakeWithDistance(location3.location!.coordinate, 400, 400)
        
        // this sshows your current location on map zoomed in when app is lunched
        mapView.setRegion(region, animated: false)
            
            updateCount += 1
        } else {
            location3.stopUpdatingLocation()
        }
    }
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    // this code will grab our location and center the map
    @IBAction func locationFocusTapped(_ sender: Any) {
        
        // the if statement prevents from running the code if the location is unknown
        if let coord = location3.location?.coordinate {
        let region = MKCoordinateRegionMakeWithDistance(coord, 400, 400)
        mapView.setRegion(region, animated: true)
        
        }
    }
    
}

