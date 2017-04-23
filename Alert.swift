//
//  Alert.swift
//  BluePages
//
//  Created by Kunal Parekh on 22/10/16.
//  Copyright © 2016 Kunal Parekh. All rights reserved.
//

import Foundation
import UIKit

public class alert:UIView
{
    func alert(_ Message:String,icon:String,View:UIViewController)
    {
        let imageView = UIImageView(frame: CGRect(x: 70, y: 14, width: 30, height: 30))
        imageView.image = UIImage(named: icon)
        
        let alertController = UIAlertController(title: "Alert!", message: "\n"+Message, preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.default,handler: nil))
        alertController.view.addSubview(imageView)
        View.present(alertController, animated: true, completion: nil)
    }
    
    
}

