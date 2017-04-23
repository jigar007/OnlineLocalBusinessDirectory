//
//  Strings.swift
//  BluePages
//
//  Created by Kunal Parekh on 25/10/16.
//  Copyright © 2016 Kunal Parekh. All rights reserved.
//

import Foundation

public class Strings
{
    public class func stringCheck(_ nameString:String) ->String
    {
        let titleString = nameString.components(separatedBy: " ")
        
        if titleString.count >= 3
        {
            
            if titleString[0].characters.count == 1
            {
                return (titleString[0]+" "+titleString[1]+" "+titleString[2]+" "+titleString[3]).capitalized
            }
            else if titleString[1].characters.count == 1
            {
                return (titleString[0]+" "+titleString[1]+" "+titleString[2]).capitalized
            }
            else if titleString[2].characters.count == 1
            {
               return (titleString[0]+" "+titleString[1]+" "+titleString[2]+" "+titleString[3]).capitalized
            }
            else
            {
                return (titleString[0]+" "+titleString[1]+" "+titleString[2]).capitalized
            }
            
        }
        else
        {
            return nameString.capitalized
        }
    }
}
