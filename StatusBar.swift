//
//  StatusBar.swift
//  BluePages
//
//  Created by Kunal Parekh on 22/10/16.
//  Copyright © 2016 Kunal Parekh. All rights reserved.
//

import Foundation
import UIKit

public class statusbar{
    class func color(_ Color:String){
        if Color == "white"{
            
            let Color = Screens.colors()
            UIApplication.shared.statusBarStyle = UIStatusBarStyle.lightContent
            
            guard let statusBar = UIApplication.shared.value(forKeyPath: "statusBarWindow.statusBar") as? UIView else { return }
            
            statusBar.backgroundColor = Color.lightBlue
            
        }else{
            UIApplication.shared.statusBarStyle = UIStatusBarStyle.default
        }
        
    }
}
