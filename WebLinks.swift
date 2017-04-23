//
//  WebLinks.swift
//  BluePages
//
//  Created by Kunal Parekh on 22/10/16.
//  Copyright © 2016 Kunal Parekh. All rights reserved.
//


import Foundation
import UIKit
public class webLinks
{
    class func URLS() -> (catagorizeURL:URL,subCatagorizeURL:URL,subCatagoriezTwoURL:URL,profileURL:URL,XRef:URL,papulor1:URL,papulor2:URL)
    {
        let catagoriezURL:URL = URL(string: "http://www.localbluepages.com.au/app/database/mobAppDB.php")!
        
        let subCatagoriezURL:URL = URL(string: "http://www.localbluepages.com.au/app/database/cat_to_subCat_results.php")!
        
        let subCatagoriezTwoURL:URL = URL(string: "http://www.localbluepages.com.au/app/database/subcat_to_bus_results.php")!
        
        let profileURL:URL = URL(string: "http://www.localbluepages.com.au/app/database/buscat_to_pro_results.php")!
        let xref:URL = URL(string: "http://www.localbluepages.com.au/app/database/xref.php")!
        let papulor1:URL = URL(string: "http://www.localbluepages.com.au/app/database/popular.php")!
        
        let papulor2:URL = URL(string: "http://www.localbluepages.com.au/app/database/popularvc2.php")!
        
        
        return (catagoriezURL,subCatagoriezURL,subCatagoriezTwoURL,profileURL,xref,papulor1,papulor2)
    }
    
    // To check Email is Valid or Not
    class func checkEmail(_ emailString:String)->String
    {
        let weblink = webLinks()
        
        if weblink.isValidEmail(emailString) == true
        {
            return emailString
        }
        else
        {
            return "null"
        }
    }
    
    // To check URL is correct or not
    class func checkURL(_ urlString:String)->String
    {
        let weblink = webLinks()
        
        let uppercased = urlString.uppercased()
        let firstchar = uppercased.characters.first
        
        if firstchar == "W"
        {
            let url = "http://"+urlString
            if weblink.isvalidURL(string: url) == true
            {
                return url
            }
            else
            {
                return "null"
            }
        }
        else if weblink.isvalidURL(string: urlString) == true
        {
            return urlString
        }
        else
        {
            return "null"
        }
        
    }
    
    
    
    //Private functions that accesssible only in this class
    
    private func isvalidURL (string: String?) -> Bool {
        
        if string != nil
        {
            
            if let url = NSURL(string: string!)
            {
                
                return UIApplication.shared.canOpenURL(url as URL)
            }
        }
        return false
    }
    private func isValidEmail(_ email:String) -> Bool {
        
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: email)
    }
}

