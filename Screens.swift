//
//  Screens.swift
//  BluePages
//
//  Created by Kunal Parekh on 22/10/16.
//  Copyright © 2016 Kunal Parekh. All rights reserved.
//

import Foundation
import UIKit

public class Screens{
    
    func size() ->(width:CGFloat,height:CGFloat,centerX:CGFloat,centerY:CGFloat,buttonWidth:CGFloat,buttonHeight:CGFloat,logoHeight:CGFloat,logoWidth:CGFloat,labelSize:CGSize){
        
        let width = UIScreen.main.bounds.width
        let height = UIScreen.main.bounds.height
        let centerX = width/2
        let centerY = height/2
        let buttonWidth = width-centerX/2
        let buttonHeight = buttonWidth/6
        let logoHeight = centerY/2
        let logoWidth = centerY/2
        
        let labelSize:CGSize = CGSize(width: buttonWidth, height: buttonHeight/2)
        
        return (width,height,centerX,centerY,buttonWidth,buttonHeight,logoHeight,logoWidth,labelSize)
    }
    
    public class func bottomBar(_ BottomBar:UIView)
    {
        BottomBar.layer.shadowOpacity = 0.6
        BottomBar.layer.shadowOffset = CGSize(width: 3.0, height: 0.0)
        BottomBar.layer.shadowRadius = 4.0
        BottomBar.layer.shadowColor = UIColor.black.cgColor
        
    }
    public class func colors()->( whiteColor:UIColor,blueColor:UIColor,black:UIColor,lightBlue:UIColor)
    {
        let set = Screens()
        
        let white = set.Color("#ffffff")
        let blue = set.Color("#4fa3ec")
        let black = set.Color("#000000")
        let lightBlue = set.Color("#4f95ec")
        
        return(white,blue,black,lightBlue)

    }
    public class func buttons(_ Button:UIButton)
    {
        Button.isEnabled = true
        Button.layer.cornerRadius = Button.frame.height/2
        Button.layer.shadowColor = UIColor.gray.cgColor
        Button.layer.shadowRadius = 1.4
        Button.layer.shadowOpacity = 0.8
        Button.layer.borderWidth = 2.0
        Button.layer.shadowOffset = CGSize.zero
        Button.layer.borderColor = UIColor.white.cgColor

    }
    public class func navigationAlign(ViewController:UIViewController,navigationController:UINavigationController,Image:UIImageView,Button:UIButton,topTitle:UILabel, halfColourView:UIView)
    {
        let Color = Screens.colors()
        let titles = Constants.contantTitles()
        
        navigationController.navigationBar.addSubview(Button)
        navigationController.navigationBar.addSubview(Image)
        
        let navigationWidth = navigationController.navigationBar.frame.width
        let navigationHeight = navigationController.navigationBar.frame.height/2
        
        Image.layer.frame.size = CGSize(width: navigationHeight-8, height: navigationHeight-8)
        Button.layer.frame.size.height = navigationHeight-16
        Button.layer.frame.size.width = 100
        Button.titleLabel?.adjustsFontSizeToFitWidth = true
        topTitle.layer.frame.size = CGSize(width: navigationWidth-(Image.frame.width+Button.frame.width)-8, height: Button.frame.height)
        
        Button.layer.position = CGPoint(x: navigationWidth-(Button.frame.width/2)-4, y: navigationHeight/2)
        Image.layer.position = CGPoint(x: ((navigationHeight-8)/2)+4, y: navigationHeight/2)
        topTitle.layer.position = CGPoint(x: (Image.layer.position.x+Image.frame.width/2)+topTitle.frame.width/2+4, y: Button.layer.position.y)
        
        halfColourView.layer.frame.size = CGSize(width: navigationWidth, height: navigationHeight+8)
        halfColourView.layer.position = CGPoint(x: navigationWidth/2, y: Image.layer.position.y)
        
//        sortButton.frame.size.height = Button.frame.size.height
//        //sortButton.frame.size.width =
//        sortButton.layer.position = CGPoint(x: Button.layer.position.x, y: (navigationHeight*2)-(sortButton.frame.height/2)-8)
        
        navigationController.navigationBar.tintColor = Color.whiteColor
        //self.edgesForExtendedLayout = []
        navigationController.navigationBar.isTranslucent = false
       // ViewController.navigationItem.title = titles
        topTitle.text = titles.navigationTitle
        //sortButton.setTitle(titles.sortButtonTitle, for: .normal)
        topTitle.textColor = Color.whiteColor
       //sortButton.setTitleColor(Color.blueColor, for: .normal)
       // sortButton.backgroundColor = Color.whiteColor
        halfColourView.backgroundColor = Color.lightBlue
        topTitle.adjustsFontSizeToFitWidth = true
        //sortButton.titleLabel?.adjustsFontSizeToFitWidth = true
        
        navigationController.navigationBar.addSubview(halfColourView)
        navigationController.navigationBar.addSubview(Button)
        navigationController.navigationBar.addSubview(Image)
        navigationController.navigationBar.addSubview(topTitle)
        //navigationController.navigationBar.addSubview(sortButton)
        //styles of Button

        buttons(Button)
        
//        image.layer.borderWidth=1.0
//
//        image.layer.borderColor = UIColor.whiteColor().CGColor
//        image.layer.cornerRadius = 13
//        image.layer.cornerRadius = image.frame.size.height/2
 
        
        navigationController.navigationBar.barTintColor = Color.blueColor.withAlphaComponent(1.0)
    }
    
    private func Color (_ hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        if ((cString.characters.count) != 6) {
            return UIColor.gray
        }
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}

