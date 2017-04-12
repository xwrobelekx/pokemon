//
//  pokeAnotation.swift
//  pokemon
//
//  Created by Kamil Wrobel on 4/12/17.
//  Copyright © 2017 Kamil Wrobel. All rights reserved.
//

import Foundation
import UIKit
import MapKit


// here were creating a sub clas for MKAnnotation, which is gone have everything that MKAnnotation has plus our own stuff

class PokeAnnotation : NSObject, MKAnnotation {
    
    var coordinate: CLLocationCoordinate2D
    
    var pokemone456: Pokemon
    
    init(coord: CLLocationCoordinate2D, pokemone: Pokemon){
        self.coordinate = coord
        self.pokemone456 = pokemone
    }
    
}
