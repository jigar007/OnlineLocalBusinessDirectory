//
//  More.swift
//  BluePages
//
//  Created by Kunal Parekh on 23/10/16.
//  Copyright © 2016 Kunal Parekh. All rights reserved.
//

import UIKit

class More: UIViewController {

    @IBOutlet var logoImage: UIImageView!
    @IBOutlet var getAQuote: UIButton!
    @IBOutlet var topTitleLabel: UILabel!
    @IBOutlet var halfColourView: UIView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       Screens.navigationAlign(ViewController: self, navigationController: self.navigationController!, Image: logoImage, Button: getAQuote,topTitle:topTitleLabel,halfColourView:halfColourView)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    


}
