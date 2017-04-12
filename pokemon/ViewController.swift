//
//  ViewController.swift
//  pokemon
//
//  Created by Kamil Wrobel on 4/7/17.
//  Copyright © 2017 Kamil Wrobel. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {

    
    @IBOutlet weak var mapView: MKMapView!
    
    
    
    
    // this var gives us acces to location, so we can do some work with it later
    var location3 = CLLocationManager()
    
    // this variable will allow as later to control the locati on map update.
    var updateCount = 0
    
    
    var pokemons3 : [Pokemon] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        pokemons3 = getAllPokemon4()
        
        location3.delegate = self
        
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            
            mapView.delegate = self
            
            mapView.showsUserLocation = true
            
            // this code gives your current location
            
            location3.startUpdatingLocation()
            
            
            Timer.scheduledTimer(withTimeInterval: 5, repeats: true, block: { (timer) in
                // this code gets run every 5 second, or what ever is set to:
                
                if let coord = self.location3.location?.coordinate {
                let anno = MKPointAnnotation() // this created anotation object
                
                anno.coordinate = coord
                    
                    //this two constants create random number that gets added to the latitude and longitude
                    let randoLat = (Double(arc4random_uniform(200)) - 100.0 ) / 50000.0
                    let randoLon = (Double(arc4random_uniform(200)) - 100.0 ) / 50000.0
                    
                    // this adds the random numbers to the location
                    anno.coordinate.latitude += randoLat
                    anno.coordinate.longitude += randoLon
                    
                    // this adds a pin in the random location that was generated above
                 self.mapView.addAnnotation(anno)
                }
            })
            
            
        } else {
            location3.requestWhenInUseAuthorization()
        }
        
        
    }
    
    //this functions gets called when the anotation is about to get called, here we can change the pin to our image
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        // this line works with the blue dot that shows your location
        if annotation is MKUserLocation {
            
            
            let annoView = MKAnnotationView(annotation: annotation, reuseIdentifier: nil)
            
            annoView.image = UIImage(named: "player")
            
            var frame = annoView.frame
            
            frame.size.height = 40
            frame.size.width = 40
            
            annoView.frame = frame
            
            return annoView
        }
        
        // this code here replaced the pin with picture
        
        let annoView = MKAnnotationView(annotation: annotation, reuseIdentifier: nil)
        
        annoView.image = UIImage(named: "mew")
        
        var frame = annoView.frame
        
        frame.size.height = 30
        frame.size.width = 30
        
        annoView.frame = frame
        
        return annoView
    }
    
    
    //this function tell the delegate that the location was updated, and that there is a new location avaliable
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    
        
        if updateCount < 4{
        
        // this region constant takes your curent location, and then u set up how much the map should be zoomed in
        let region = MKCoordinateRegionMakeWithDistance(location3.location!.coordinate, 200, 200)
        
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
        let region = MKCoordinateRegionMakeWithDistance(coord, 200, 200)
        mapView.setRegion(region, animated: true)
        
        }
    }
    
}

