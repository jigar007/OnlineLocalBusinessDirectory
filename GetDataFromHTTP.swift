//
//  HTTPPost.swift
//  BluePages
//
//  Created by Kunal Parekh on 22/10/16.
//  Copyright © 2016 Kunal Parekh. All rights reserved.
//

import Foundation

public class convert
{
    public class func contvertToDictionary(_ data:Data) ->Any // because return object may be NSDictionary or NSArray
    {
        
        let responseString = try! JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as? NSDictionary //as? is optional if or else
        
        if responseString != nil
        {
            return responseString!
        }
            
        else
        {
            let responseString2 = try! JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as! NSArray
            
            return responseString2
        }
        
    }
}
