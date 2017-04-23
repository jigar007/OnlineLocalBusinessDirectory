//
//  TempStorage.swift
//  BluePages
//
//  Created by Kunal Parekh on 22/10/16.
//  Copyright © 2016 Kunal Parekh. All rights reserved.
//

import Foundation
import UIKit

class JSONTableData
{
    var nameString:String!
    var idString:String!
    var icons:UIImage!
    var gbcount:String!
    
    init(tempName:String,tempID:String,icons:UIImage, tempgbcount:String)
    {
        self.nameString = tempName
        self.idString  = tempID
        self.icons = icons
        self.gbcount = tempgbcount
    }
}

class JSONTableData2
{
    var nameString:String!
    var idString:String!
    var icons:UIImage!
    var gbcount:String!
    
    init(tempName:String,tempID:String,icons:UIImage, tempgbcount:String)
    {
        self.nameString = tempName
        self.idString  = tempID
        self.icons = icons
        self.gbcount = tempgbcount
    }
}

class StorageSubCatagoriez
{
    var nameString:String
    var idString:String
    var ctotal:String
    
    init(tempName:String,tempID:String, tempCount:String)
    {
        self.nameString = tempName
        self.idString  = tempID
        self.ctotal = tempCount
    }
}

class StorageSubCatagoriez2
{
    var nameString:String
    var idString:String
    var ctotal:String
    
    init(tempName:String,tempID:String, tempCount:String)
    {
        self.nameString = tempName
        self.idString  = tempID
        self.ctotal = tempCount
    }
}


class StorageSubCatagoriezTwo
{
    var nameString:String
    var idString:String
    var address:String
    var telephone:String
    var email:String
    var website:String
    
    init(tempName:String,tempID:String,tempaddress:String,tempTelephone:String,tempEmail:String,tempWebsite:String)
    {
        self.nameString = tempName.trimmingCharacters(in:  CharacterSet.whitespacesAndNewlines)
        self.idString  = tempID.trimmingCharacters(in:  CharacterSet.whitespacesAndNewlines)
        self.address = tempaddress.trimmingCharacters(in:  CharacterSet.whitespacesAndNewlines)
        self.telephone = tempTelephone.trimmingCharacters(in:  CharacterSet.whitespacesAndNewlines)
        self.email = tempEmail.trimmingCharacters(in:  CharacterSet.whitespacesAndNewlines)
        self.website = tempWebsite.trimmingCharacters(in:  CharacterSet.whitespacesAndNewlines)
    }
}

class StorageSubCatagoriezTwoNorth
{
    var nameString:String
    var idString:String
    var address:String
    var telephone:String
    var email:String
    var website:String
    
    init(tempName:String,tempID:String,tempaddress:String,tempTelephone:String,tempEmail:String,tempWebsite:String)
    {
        self.nameString = tempName.trimmingCharacters(in:  CharacterSet.whitespacesAndNewlines)
        self.idString  = tempID.trimmingCharacters(in:  CharacterSet.whitespacesAndNewlines)
        self.address = tempaddress.trimmingCharacters(in:  CharacterSet.whitespacesAndNewlines)
        self.telephone = tempTelephone.trimmingCharacters(in:  CharacterSet.whitespacesAndNewlines)
        self.email = tempEmail.trimmingCharacters(in:  CharacterSet.whitespacesAndNewlines)
        self.website = tempWebsite.trimmingCharacters(in:  CharacterSet.whitespacesAndNewlines)
    }
}

class StorageSubCatagoriezTwoEast
{
    var nameString:String
    var idString:String
    var address:String
    var telephone:String
    var email:String
    var website:String
    
    init(tempName:String,tempID:String,tempaddress:String,tempTelephone:String,tempEmail:String,tempWebsite:String)
    {
        self.nameString = tempName.trimmingCharacters(in:  CharacterSet.whitespacesAndNewlines)
        self.idString  = tempID.trimmingCharacters(in:  CharacterSet.whitespacesAndNewlines)
        self.address = tempaddress.trimmingCharacters(in:  CharacterSet.whitespacesAndNewlines)
        self.telephone = tempTelephone.trimmingCharacters(in:  CharacterSet.whitespacesAndNewlines)
        self.email = tempEmail.trimmingCharacters(in:  CharacterSet.whitespacesAndNewlines)
        self.website = tempWebsite.trimmingCharacters(in:  CharacterSet.whitespacesAndNewlines)
    }
}

class StorageSubCatagoriezTwoWest
{
    var nameString:String
    var idString:String
    var address:String
    var telephone:String
    var email:String
    var website:String
    
    init(tempName:String,tempID:String,tempaddress:String,tempTelephone:String,tempEmail:String,tempWebsite:String)
    {
        self.nameString = tempName.trimmingCharacters(in:  CharacterSet.whitespacesAndNewlines)
        self.idString  = tempID.trimmingCharacters(in:  CharacterSet.whitespacesAndNewlines)
        self.address = tempaddress.trimmingCharacters(in:  CharacterSet.whitespacesAndNewlines)
        self.telephone = tempTelephone.trimmingCharacters(in:  CharacterSet.whitespacesAndNewlines)
        self.email = tempEmail.trimmingCharacters(in:  CharacterSet.whitespacesAndNewlines)
        self.website = tempWebsite.trimmingCharacters(in:  CharacterSet.whitespacesAndNewlines)    }
}

class StorageSubCatagoriezTwoSouth
{
    var nameString:String
    var idString:String
    var address:String
    var telephone:String
    var email:String
    var website:String
    
    init(tempName:String,tempID:String,tempaddress:String,tempTelephone:String,tempEmail:String,tempWebsite:String)
    {
        self.nameString = tempName.trimmingCharacters(in:  CharacterSet.whitespacesAndNewlines)
        self.idString  = tempID.trimmingCharacters(in:  CharacterSet.whitespacesAndNewlines)
        self.address = tempaddress.trimmingCharacters(in:  CharacterSet.whitespacesAndNewlines)
        self.telephone = tempTelephone.trimmingCharacters(in:  CharacterSet.whitespacesAndNewlines)
        self.email = tempEmail.trimmingCharacters(in:  CharacterSet.whitespacesAndNewlines)
        self.website = tempWebsite.trimmingCharacters(in:  CharacterSet.whitespacesAndNewlines)
    }
}



class StorageContactTime
{
    var timeString:String
    
    init(tempName:String)
    {
        self.timeString = tempName
    }
}

class StorageContactAddress
{
    var addressString:String
    
    init(tempName:String)
    {
        self.addressString = tempName
    }
}

class aboutStorageClass
{
    var textViewString:String
    
    init(tempText:String)
    {
        self.textViewString = tempText
    }
}

