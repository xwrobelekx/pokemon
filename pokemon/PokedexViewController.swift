//
//  PokedexViewController.swift
//  pokemon
//
//  Created by Kamil Wrobel on 4/10/17.
//  Copyright © 2017 Kamil Wrobel. All rights reserved.
//

import UIKit

class PokedexViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    
    @IBOutlet weak var tableView25: UITableView!

    var coughtPokemons : [Pokemon] = []
    
    var uncoughtPokemons : [Pokemon] = []
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        coughtPokemons = getAllCoughtPokemons()
        
        uncoughtPokemons = getAllUncoughtPokemons()
        
        tableView25.dataSource = self
        tableView25.delegate = self
        
    }
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "CAUGHT"
            
        } else {
          return "UNCAUGHT"
        }
    }
    
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            return coughtPokemons.count
        } else {
            return uncoughtPokemons.count
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let pokemon : Pokemon
        
        if indexPath.section == 0 {
            pokemon = coughtPokemons[indexPath.row]
        } else {
            pokemon = uncoughtPokemons[indexPath.row]
        }
        
        let cell = UITableViewCell()
        cell.textLabel?.text = pokemon.name
        cell.imageView?.image = UIImage(named: pokemon.imageName!)
        return cell
    }
    
    
    
    
    
    @IBAction func mapTapped(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
