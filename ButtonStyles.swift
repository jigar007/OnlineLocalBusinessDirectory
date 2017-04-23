//
//  ButtonStyles.swift
//  BluePages
//
//  Created by Kunal Parekh on 23/10/16.
//  Copyright © 2016 Kunal Parekh. All rights reserved.
//

import Foundation
import UIKit

public class buttons
{
    public class func style(_ Button:UIButton, State:String)
    {
        //Also Set Any colors As you need :)
        
        let white = UIColor.white
        
        let  blue = UIColor(red: 0, green: 122/255, blue: 255/255, alpha: 1.0)
        
        if State == "normal"
        {
            Button.setTitleColor(white, for: .normal)
            Button.layer.backgroundColor = blue.cgColor
            
        }
        else if State == "active"
        {
            Button.setTitleColor(blue, for: .normal)
            Button.layer.backgroundColor = white.cgColor
        }
    }
}
