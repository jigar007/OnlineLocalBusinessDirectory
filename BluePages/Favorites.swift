//
//  Favorites.swift
//  BluePages
//
//  Created by Kunal Parekh on 23/10/16.
//  Copyright © 2016 Kunal Parekh. All rights reserved.
//

import UIKit

class Favorites: UIViewController, UITableViewDataSource,UITableViewDelegate {

    @IBOutlet var logoImage: UIImageView!
    @IBOutlet var getAQuotes: UIButton!
    @IBOutlet var topTitleLabel: UILabel!
    @IBOutlet var halfColourView: UIView!
 
    @IBOutlet weak var favoriteCatTble: UITableView!
    
    var favcat = ["fav1","fav2","fav3"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       Screens.navigationAlign(ViewController: self, navigationController: self.navigationController!, Image: logoImage, Button: getAQuotes,topTitle:topTitleLabel,halfColourView:halfColourView)

     favoriteCatTble.dataSource=self
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int  {
     
        return favcat.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell  {
    
        let myCell: UITableViewCell = favoriteCatTble.dequeueReusableCell(withIdentifier: "proto", for: indexPath)
        
        myCell.textLabel?.text=favcat[indexPath.row]

        return myCell
    }
   
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
        self.performSegue(withIdentifier:"favcat2favsubcat", sender: self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    


}
