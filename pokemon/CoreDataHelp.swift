//
//  CoreDataHelp.swift
//  pokemon
//
//  Created by Kamil Wrobel on 4/10/17.
//  Copyright © 2017 Kamil Wrobel. All rights reserved.
//

import Foundation
import UIKit
import CoreData

func adAllPokemon() {
    
    createPokemon(name: "Mew", imageName: "mew")
    createPokemon(name: "Meowth", imageName: "meowth")
    createPokemon(name: "Mankey", imageName: "mankey")
    createPokemon(name: "Pidgey", imageName: "pidgey")
    createPokemon(name: "Pikachu", imageName: "pikachu-2")
    createPokemon(name: "Rattata", imageName: "rattata")
    createPokemon(name: "Eevee", imageName: "eevee")
    createPokemon(name: "Snorlax", imageName: "snorlax")
    createPokemon(name: "Weedle", imageName: "weedle")
    createPokemon(name: "Zubat", imageName: "zubat")
  
    print("byles tu?????")
    
    (UIApplication.shared.delegate as! AppDelegate).saveContext()
}


func createPokemon(name: String, imageName: String) {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    let pokemon = Pokemon(context: context)
    pokemon.name = name
    pokemon.imageName = imageName
    
    
}


func getAllPokemon4() -> [Pokemon] {
    
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    do {
    let pokemons6 = try context.fetch(Pokemon.fetchRequest()) as! [Pokemon]
        
        if pokemons6.count == 0 {
           adAllPokemon()
        return getAllPokemon4()
            
        }
        
    return pokemons6
    } catch {}
    
    return []
}




func getAllCoughtPokemons() -> [Pokemon] {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    let fetchRequest = Pokemon.fetchRequest() as NSFetchRequest<Pokemon>
    
    fetchRequest.predicate = NSPredicate(format: "caught == %@", true as CVarArg)
    
    do {
        // i had wrong amuntr returned because i did context.fetch(Pokemon.fetchRequest())
        let pokemons5 = try context.fetch(fetchRequest) as [Pokemon]
        return pokemons5
        
    } catch {}
    return []
}



func getAllUncoughtPokemons() -> [Pokemon] {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    let fetchRequest = Pokemon.fetchRequest() as NSFetchRequest<Pokemon>
    
    fetchRequest.predicate = NSPredicate(format: "caught == %@", false as CVarArg)
    
    do {
        
        // i had wrong amuntr returned because i did context.fetch(Pokemon.fetchRequest())
        let pokemons5 = try context.fetch(fetchRequest) as [Pokemon]
        return pokemons5
        
    } catch {}
    return []
}







