//
//  ProgressAnimation.swift
//  BluePages
//
//  Created by Kunal Parekh on 22/10/16.
//  Copyright © 2016 Kunal Parekh. All rights reserved.
//

// Custom Progross loading animatio.. like as library class
import Foundation
import UIKit

class loadingAnimation
{
    
    class func loading()->UIView
    {
        let scr = Screens()
        let screen = scr.size()
        let backgroundShadow:UIView = UIView()
        let loadingLabel:UILabel = UILabel()
        
        loadingLabel.text = "LOADING..."
        loadingLabel.font = UIFont.boldSystemFont(ofSize: (screen.buttonHeight+screen.buttonHeight/2)/2)
        loadingLabel.textAlignment = NSTextAlignment.center
        loadingLabel.textColor = UIColor.white
        loadingLabel.backgroundColor = UIColor.clear
        backgroundShadow.addSubview(loadingLabel)
        backgroundShadow.backgroundColor = UIColor.black.withAlphaComponent(0)
        backgroundShadow.layer.bounds = CGRect(x: 0, y: 0, width: screen.width, height: screen.height)
        backgroundShadow.layer.position = CGPoint(x: screen.centerX, y: screen.centerY)
        loadingLabel.layer.frame.size = CGSize(width: screen.width/2, height: screen.buttonHeight+screen.buttonHeight/2)
        loadingLabel.layer.position = CGPoint(x: backgroundShadow.frame.size.width/2, y: backgroundShadow.frame.size.height/2)
        
        let activity:UIActivityIndicatorView = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.whiteLarge)
        activity.layer.position = CGPoint(x: backgroundShadow.frame.size.width/2, y: loadingLabel.layer.position.y+loadingLabel.frame.height/2+activity.frame.height/2)
        activity.color = UIColor.white
        activity.startAnimating()
        backgroundShadow.addSubview(activity)
        UIView.animate(withDuration: 0.2, animations: {
            
            backgroundShadow.backgroundColor = UIColor.black.withAlphaComponent(0.8)
            
        })
        backgroundShadow.isHidden = true
        
        return backgroundShadow
        
    }
}


