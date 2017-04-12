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
                
                    
                    // this takes a random pokemonf from an array of pokemons from above
                    let pokemon789 = self.pokemons3[Int(arc4random_uniform(UInt32(self.pokemons3.count)))]
                    
                    //let anno = MKPointAnnotation() // this created anotation object
                    // this replaced the above constant object
                let anno = PokeAnnotation(coord: coord, pokemone: pokemon789)
                    
                    
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
        
        let pokemon123 = (annotation as! PokeAnnotation).pokemone456
        
        
        annoView.image = UIImage(named: pokemon123.imageName!)
        
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
    
    // this funcion lets us tap on annotaions (pins / pokmons)
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        
        mapView.deselectAnnotation(view.annotation, animated: true)
        
        // this prevents from tapping on the trainer/( blue dot)
        if view.annotation is MKUserLocation {
            return
        }
        
        // in this line of ocde when the pokemon is tapped the map centers around it.
        let region = MKCoordinateRegionMakeWithDistance(view.annotation!.coordinate, 200, 200)
        mapView.setRegion(region, animated: true)
        
        
        // were puting timer to give the code time to zoom in to the pokemon location before it determines if we can catch it or not
        Timer.scheduledTimer(withTimeInterval: 1, repeats: false) {(timer) in
            
        
        
        // this like will check if the trainer (blue dot) is witihn the map rectangle of the pokemon (pin), if yes then we can catch the pokemon, if not then we cant
        if let coord2 = self.location3.location?.coordinate {
            
            // first we create pokemon object, which is pulling that information from the anotation that was tapped
            let pokemon = (view.annotation! as! PokeAnnotation).pokemone456
            
            if MKMapRectContainsPoint(mapView.visibleMapRect, MKMapPointForCoordinate(coord2)) {
                
                
                // this code lets you catch the pokemon
                
               
                
                // here were changing its bulean value to true
                
                pokemon.caught = true
                
                // save to core data
                (UIApplication.shared.delegate as! AppDelegate).saveContext()
                
                // to remove cought pokemon from map
                mapView.removeAnnotation(view.annotation!)
                
                
                //here were gone create an alert to let the user know that his to far from the pokemon to cathc it
                
                
                // first create the alert object
                let alertVC = UIAlertController(title: "EE TY", message: "Zlapales \(pokemon.name!), byles szybszy od skubanca", preferredStyle: .alert)
                
                // this is a button to show the cought pokemon
                let pokedexAction = UIAlertAction(title: "pokedex", style: .default, handler: { (action) in
                    
                    // when pokedex button is pressed it trigures a segue to show th cought pokemons
                    self.performSegue(withIdentifier: "pokedexSegues", sender: nil)
                
                })
                
                alertVC.addAction(pokedexAction)
                
                
                // create buttons to the alert
                
                let OKaction = UIAlertAction(title: "OK", style: .default, handler: nil)
                
                // add action to the alert
                
                alertVC.addAction(OKaction)
                
                // present the view controller
                
                self.present(alertVC, animated: true, completion: nil)
                
                
                
            } else {
                
                //here were gone create an alert to let the user know that his to far from the pokemon to cathc it
                
                
                
                // first create the alert object
                let alertVC = UIAlertController(title: "EE TY", message: "\(pokemon.name!) ci spier**l", preferredStyle: .alert)
                
                // create buttons to the alert
                
                let OKaction = UIAlertAction(title: "OK", style: .default, handler: nil)
                
                // add action to the alert
                
                alertVC.addAction(OKaction)
                
                // present the view controller
                
                self.present(alertVC, animated: true, completion: nil)
                
                
            }
        }
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

