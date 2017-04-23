//
//  GroupSubCatThirdView.swift
//  BluePages
//
//  Created by Kunal Parekh on 23/10/16.
//  Copyright © 2016 Kunal Parekh. All rights reserved.
//

import UIKit

class GroupSubCatThirdView: UIViewController,UITableViewDelegate,UITableViewDataSource, UIWebViewDelegate{

    @IBOutlet var bussinessTableView: UITableView!
    @IBOutlet var bottomBarView: UIView!
    
    
    let progress = loadingAnimation.loading()
    let urls = webLinks.URLS()
    let alertMessage = alert()
    let Color = Screens.colors()
    
    
    @IBOutlet var allButton: UIButton!
    @IBOutlet var northButton: UIButton!
    @IBOutlet var eastButton: UIButton!
    @IBOutlet var westButton: UIButton!
    @IBOutlet var southButton: UIButton!
    
    var HTMLString:String! = nil
    
    var forAll = 0
    var forN = 0
    var forE = 0
    var forW = 0
    var forS = 0
    var refrencenum = 0
    
    var heightOfTheCell:CGFloat! = nil
    
    var subCatagorizeDataTwo = Array<StorageSubCatagoriezTwo>()
    var subCatagorizeDataTwoN = Array<StorageSubCatagoriezTwoNorth>()
    var subCatagorizeDataTwoE = Array<StorageSubCatagoriezTwoEast>()
    var subCatagorizeDataTwoW = Array<StorageSubCatagoriezTwoWest>()
    var subCatagorizeDataTwoS = Array<StorageSubCatagoriezTwoSouth>()
    var SubCatagoriez3rd = Array<StorageSubCatagoriez3rd>()
    
    var id:String! = nil
    var catName:String! = nil
    var regId = 0
    var HeaderName:String! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Screens.bottomBar(bottomBarView)
        
        buttons.style(allButton,State: "active")
        buttons.style(northButton, State: "normal")
        buttons.style(eastButton, State: "normal")
        buttons.style(westButton, State: "normal")
        buttons.style(southButton, State: "normal")
        
        let backItem = UIBarButtonItem()
        backItem.title = "Back"
        navigationItem.backBarButtonItem = backItem
        
        self.UpdateSubCatagorizeTwo(id)
        self.view.addSubview(progress)
    }

    
    //HTTP Request again for updating StorageSubCatagoriezTwo
    
    func UpdateSubCatagorizeTwo(_ id:String)
    {
        subCatagorizeDataTwo.removeAll()
        subCatagorizeDataTwoN.removeAll()
        subCatagorizeDataTwoE.removeAll()
        subCatagorizeDataTwoW.removeAll()
        subCatagorizeDataTwoS.removeAll()
        SubCatagoriez3rd.removeAll()
        self.view.isUserInteractionEnabled = false
        progress.isHidden = false
        
        let request = NSMutableURLRequest(url: urls.subCatagoriezTwoURL as URL)
        let postString = "id="+id
        request.httpBody = postString.data(using: String.Encoding.utf8)
        request.httpMethod = "POST"
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) { data,response,error in
            guard error == nil && data != nil else
            {
                self.progress.isHidden = true
                self.view.isUserInteractionEnabled = true
                self.alertMessage.alert("Error:\(error)", icon: "error", View: self)
                return
            }
            
            let httpStatus = response as? HTTPURLResponse
            
            if httpStatus!.statusCode == 200
            {
                if data?.count != 0
                {
                    let responseString = convert.contvertToDictionary(data!) as? [[String:AnyObject]]
                    
                    if responseString != nil
                    {
                        for dictionary in responseString!
                        {
                            
                            let id = String(describing: dictionary["id"]!)
                            let name = String(describing: dictionary["BUSINESS_NAME"]!)
                            let email = String(describing: dictionary["EMAIL"]!)
                            var streetNo = String(describing: dictionary["STREET_NO"]!)
                            var streetName = String(describing: dictionary["STREET_NAME"]!)
                            var suburbID = String(describing: dictionary["SUBURB_ID"]!)
                            var postCode = String(describing: dictionary["POSTCODE"]!)
                            let regionID = String(describing: dictionary["REGION_ID"]!)
                            var landline = String(describing: dictionary["PHONE_FIXED"]!)
                            var mobile = String(describing: dictionary["PHONE_MOBILE"]!)
                            let website = String(describing: dictionary["WEBURL"]!)
                            var suburbName = String(describing: dictionary["Suburb"]!)
                            let streedNoHide = String(describing: dictionary["STREET_NO_HIDDEN"]!)
                            let streetNameHide = String(describing: dictionary["STREET_NAME_HIDDEN"]!)
                            let suburbHide = String(describing: dictionary["SUBURB_HIDDEN"]!)
                            let postCodeHide = String(describing: dictionary["POSTCODE_HIDDEN"]!)
                            let mobileHide = String(describing: dictionary["PHONE_MOBILE_HIDDEN"]!)
                            let landlineHide = String(describing: dictionary["PHONE_FIXED_HIDDEN"]!)
                            
                            if streedNoHide != "0"
                            {
                                streetNo = ""
                            }else{
                            
                            }
                            
                            if streetNameHide != "0"
                            {
                                streetName=""
                            }
                            else{
                               //nothing here
                            }
                            
                            
                            if suburbHide != "0"
                            {
                                suburbName = ""
                                suburbID = ""
                            }
                            else{
                                //nothing here
                            }
                            
                            
                            if postCodeHide != "0"
                            {
                                postCode = ""
                            }
                            else{
                                //nothing here
                            }
                            
                            if mobileHide != "0"
                            {
                                mobile = ""
                            }
                            else{
                                //nothing here
                            }
                            if landlineHide != "0"
                            {
                                landline = ""
                            }else
                            {
                                
                            }
                            // streetno
                            DispatchQueue.main.async
                                {
                                    
                                    if regionID == "1"
                                    {
                                        self.subCatagorizeDataTwoN.append(StorageSubCatagoriezTwoNorth(tempName: name, tempID: id, tempaddress: suburbID+" "+streetName+" "+suburbName+" "+postCode, tempTelephone: landline+" "+mobile, tempEmail: email, tempWebsite: website))
                                    }
                                    else if regionID == "2"
                                    {
                                        self.subCatagorizeDataTwoE.append(StorageSubCatagoriezTwoEast(tempName: name, tempID: id, tempaddress: suburbID+" "+streetName+" "+suburbName+" "+postCode, tempTelephone: landline+" "+mobile, tempEmail: email, tempWebsite: website))
                                        
                                    }
                                    else if regionID == "3"
                                    {
                                        self.subCatagorizeDataTwoS.append(StorageSubCatagoriezTwoSouth(tempName: name, tempID: id, tempaddress: suburbID+" "+streetName+" "+suburbName+" "+postCode, tempTelephone: landline+" "+mobile, tempEmail: email, tempWebsite: website))
                                    }
                                    else if regionID == "4"
                                    {
                                        self.subCatagorizeDataTwoW.append(StorageSubCatagoriezTwoWest(tempName: name, tempID: id, tempaddress: suburbID+" "+streetName+" "+suburbName+" "+postCode, tempTelephone: landline+" "+mobile, tempEmail: email, tempWebsite: website))
                                    }
                                    self.subCatagorizeDataTwo.append(StorageSubCatagoriezTwo(tempName: name, tempID: id, tempaddress: suburbID+" "+streetName+" "+suburbName+" "+postCode, tempTelephone: landline+" "+mobile, tempEmail: email, tempWebsite: website))
                            }
                            
                        }
                        
                        DispatchQueue.main.async
                            {
                                
                                if self.subCatagorizeDataTwo.count >= 10
                                {
                                    self.regId = 0
                                    self.forAll = 10
                                    self.refrencenum = 1
                                }
                                else
                                {
                                    self.forAll = self.subCatagorizeDataTwo.count
                                }
                                
                                if self.subCatagorizeDataTwoN.count >= 10
                                {
                                    self.forN = 10
                                }
                                else
                                {
                                    self.forN = self.subCatagorizeDataTwoN.count
                                }
                                
                                if self.subCatagorizeDataTwoE.count >= 10
                                {
                                    self.forE = 10
                                }
                                else
                                {
                                    self.forE = self.subCatagorizeDataTwoE.count
                                }
                                
                                if self.subCatagorizeDataTwoS.count >= 10
                                {

                                    self.forS = 10
                                }
                                else
                                {
                                    self.forS = self.subCatagorizeDataTwoS.count
                                }
                                
                                if self.subCatagorizeDataTwoW.count >= 10
                                {

                                    self.forW = 10
                                }
                                else
                                {
                                    self.forW = self.subCatagorizeDataTwoW.count
                                }
                                
                                self.UpdateSubCatagorizeTwo1(self.catName, url: self.urls.XRef)
                        }
                    }
                    else
                    {
                        DispatchQueue.main.async
                            {
                                self.progress.isHidden = true
                                self.view.isUserInteractionEnabled = true
                                self.alertMessage.alert("Problem with Requesting! Error 404", icon: "error", View: self)
                        }
                    }
                    
                }
                else
                {
                    DispatchQueue.main.async
                        {
                            self.progress.isHidden = true
                            self.view.isUserInteractionEnabled = true
                            self.alertMessage.alert("No data got from url!", icon: "error", View: self)
                    }
                }
            }
            else
            {
                DispatchQueue.main.async
                    {
                        self.progress.isHidden = true
                        self.view.isUserInteractionEnabled = true
                        self.alertMessage.alert("error httpstatus code is : \(httpStatus!.statusCode)", icon: "error", View: self)
                }
            }
        }
        task.resume()
        
    }
    
    private func UpdateSubCatagorizeTwo1(_ id:String,url:URL)
    {
        
        self.view.isUserInteractionEnabled = false
        progress.isHidden = false
        
        let headers = [
            "content-type": "multipart/form-data; boundary=---011000010111000001101001",
            "cache-control": "no-cache",
            "postman-token": "141318ab-3f30-381f-3984-f80c3b1ab861"
        ]
        let parameters = [
            [
                "name": "id",
                "value": String(catName!)
            ]
        ]
        let boundary = "---011000010111000001101001"
        
        var body = ""
        let error: NSError? = nil
        for param in parameters {
            let paramName = param["name"]!
            body += "--\(boundary)\r\n"
            body += "Content-Disposition:form-data; name=\"\(paramName)\""
            if let filename = param["fileName"] {
                let contentType = param["content-type"]!
                if (error != nil) {
                    print(error)
                }
                body += "; filename=\"\(filename)\"\r\n"
                body += "Content-Type: \(contentType)\r\n\r\n"
            } else if let paramValue = param["value"] {
                body += "\r\n\r\n\(paramValue)"
            }
        }
        
        let request = NSMutableURLRequest(url: NSURL(string: "http://www.localbluepages.com.au/app/database/xref.php")! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = headers
        request.httpBody = body.data(using: String.Encoding.utf8)
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) { data,response,error in
            guard error == nil && data != nil else
            {
                self.progress.isHidden = true
                self.view.isUserInteractionEnabled = true
                self.alertMessage.alert("Error:\(error)", icon: "error", View: self)
                return
            }
            
            let httpStatus = response as? HTTPURLResponse
            
            if httpStatus!.statusCode == 200
            {
                if data?.count != 0
                {
                    let responseString = convert.contvertToDictionary(data!) as? [[String:AnyObject]]
                    if responseString != nil
                    {
                        for dictionary in responseString!
                        {
                            
                            if let id = dictionary["CATEGORY_ID"] as? String
                            {
                                if let name = dictionary["CATEGORY_NAME"] as? String
                                {
                                    DispatchQueue.main.async
                                        {
                                            self.SubCatagoriez3rd.append(StorageSubCatagoriez3rd(tempName: name, tempID: id))
                                             self.bussinessTableView.reloadData()
                                    }
                                }
                                else
                                {
                                    self.alertMessage.alert("Problem with Requesting! Error 404", icon: "error", View: self)
                                }

                            }
                            else
                            {
                                self.alertMessage.alert("Problem with Requesting! Error 404", icon: "error", View: self)
                            }
                        }
                        DispatchQueue.main.async
                            {
                                self.progress.isHidden = true
                                self.view.isUserInteractionEnabled = true
                                self.bussinessTableView.reloadData()
                        }
                        

                    }
                    else
                    {
                        DispatchQueue.main.async
                            {
                                self.progress.isHidden = true
                                self.view.isUserInteractionEnabled = true
                                self.alertMessage.alert("Problem with Requesting! Error 404", icon: "error", View: self)
                        }
                    }
                    
                }
                else
                {
                    DispatchQueue.main.async
                        {
                            self.progress.isHidden = true
                            self.view.isUserInteractionEnabled = true
                            self.alertMessage.alert("No data got from url!", icon: "error", View: self)
                    }
                }
            }
            else
            {
                DispatchQueue.main.async
                    {
                        self.progress.isHidden = true
                        self.view.isUserInteractionEnabled = true
                        self.alertMessage.alert("error httpstatus code is : \(httpStatus!.statusCode)", icon: "error", View: self)
                }
            }
        }
        task.resume()
        
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0
        {
            if regId == 1
            {
                
                return forN
            }
            else if regId == 2
            {
                
                return forE
            }
            else if regId == 3
            {
                
                return forS
            }
            else if regId == 4
            {
                
                return forW
            }
            else
            {
                
                return forAll
            }
        }
        else if section == 1
        {
            return refrencenum
        }
        else
        {
            return SubCatagoriez3rd.count
        }

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0
        {
            let cell = self.bussinessTableView.dequeueReusableCell(withIdentifier: "bussinessCell", for: indexPath) as! BussinessCell
            
            let tableObjects:StorageSubCatagoriezTwo = subCatagorizeDataTwo[indexPath.row]
            
            let charCheck = (tableObjects.address).replacingOccurrences(of: " ", with: "")
            cell.bussinessWebView.scrollView.isScrollEnabled = false
            
            var strings = ""
            
            if regId == 1
            {
                cell.bussinessName.text = " "
                let tableObjects:StorageSubCatagoriezTwoNorth = subCatagorizeDataTwoN[indexPath.row]
                
                if tableObjects.address.characters.isEmpty != true
                {
                     strings = strings+(tableObjects.nameString.characters.count > 0 ? "<font size=\"3\"><b>"+tableObjects.nameString+"</b></font><br>" : "")
                }
                else
                {
                    //nothing
                }
                if tableObjects.telephone.characters.isEmpty != true
                {
                    strings = strings+(tableObjects.telephone.characters.count > 0 ? "<img style='width:22px; height:22px;' src=\"http://getmydetails.pe.hu/img/mobile.gif\"> "+tableObjects.telephone+"<br>" : "")
                }
                else
                {
                    
                }
                if tableObjects.email.characters.isEmpty != true
                {
                    strings = strings+(tableObjects.email.characters.count > 0 ? "<img style='width:22px; height:22px;'  src=\"http://localbluepages.com.au/images/icons/email.gif\"> "+tableObjects.email+"<br>" : "")
                }
                else
                {
                    
                }
                if tableObjects.website.characters.isEmpty != true{
                     strings = strings+(tableObjects.website.characters.count > 0 ? "<img style='width:22px; height:22px;'  src=\"http://getmydetails.pe.hu/img/website.gif\"> "+tableObjects.website : "")
                }
                else{
                    
                }
            }
            else if regId == 2
            {
                cell.bussinessName.text = " "
                let tableObjects:StorageSubCatagoriezTwoEast = subCatagorizeDataTwoE[indexPath.row]
                //cell.bussinessName.text = tableObjects.nameString
                if tableObjects.address.characters.isEmpty != true
                {
                  //  cell.bussinessName.text = tableObjects.nameString
                    strings = strings+(tableObjects.nameString.characters.count > 0 ? "<font size=\"3\"><b>"+tableObjects.nameString+"</b></font><br>" : "")
                }
                else
                {
                    //nothing
                }
                if tableObjects.telephone.characters.isEmpty != true
                {
                    strings = strings+(tableObjects.telephone.characters.count > 0 ? "<img style='width:22px; height:22px;' src=\"http://getmydetails.pe.hu/img/mobile.gif\"> "+tableObjects.telephone+"<br>" : "")
                }
                else
                {
                    
                }
                if tableObjects.email.characters.isEmpty != true
                {
                    strings = strings+(tableObjects.email.characters.count > 0 ? "<img style='width:22px; height:22px;'  src=\"http://localbluepages.com.au/images/icons/email.gif\"> "+tableObjects.email+"<br>" : "")
                }
                else
                {
                    
                }
                if tableObjects.website.characters.isEmpty != true{
                    strings = strings+(tableObjects.website.characters.count > 0 ? "<img style='width:22px; height:22px;'  src=\"http://getmydetails.pe.hu/img/website.gif\"> "+tableObjects.website : "")
                }
                else{
                    
                }
            }
            else if regId == 3
            {
                cell.bussinessName.text = " "
                let tableObjects:StorageSubCatagoriezTwoSouth = subCatagorizeDataTwoS[indexPath.row]
               // cell.bussinessName.text = tableObjects.nameString
                if tableObjects.address.characters.isEmpty != true
                {
                    //cell.bussinessName.text = tableObjects.nameString
                    strings = strings+(tableObjects.nameString.characters.count > 0 ? "<font size=\"3\"><b>"+tableObjects.nameString+"</b></font><br>" : "")
                }
                else
                {
                    //nothing
                }
                if tableObjects.telephone.characters.isEmpty != true
                {
                    strings = strings+(tableObjects.telephone.characters.count > 0 ? "<img style='width:22px; height:22px;' src=\"http://getmydetails.pe.hu/img/mobile.gif\"> "+tableObjects.telephone+"<br>" : "")
                }
                else
                {
                    
                }
                if tableObjects.email.characters.isEmpty != true
                {
                    strings = strings+(tableObjects.email.characters.count > 0 ? "<img style='width:22px; height:22px;'  src=\"http://localbluepages.com.au/images/icons/email.gif\"> "+tableObjects.email+"<br>" : "")
                }
                else
                {
                    
                }
                if tableObjects.website.characters.isEmpty != true{
                    strings = strings+(tableObjects.website.characters.count > 0 ? "<img style='width:22px; height:22px;'  src=\"http://getmydetails.pe.hu/img/website.gif\"> "+tableObjects.website : "")
                }
                else{
                    
                }
            }
            else if regId == 4
            {
                cell.bussinessName.text = " "
                let tableObjects:StorageSubCatagoriezTwoWest = subCatagorizeDataTwoW[indexPath.row]
            //    cell.bussinessName.text = tableObjects.nameString
                if tableObjects.address.characters.isEmpty != true
                {
                  //  cell.bussinessName.text = tableObjects.nameString
                    strings = strings+(tableObjects.nameString.characters.count > 0 ? "<font size=\"3\"><b>"+tableObjects.nameString+"</b></font><br>" : "")
                }
                else
                {
                    //nothing
                }
                if tableObjects.telephone.characters.isEmpty != true
                {
                    strings = strings+(tableObjects.telephone.characters.count > 0 ? "<img style='width:22px; height:22px;' src=\"http://getmydetails.pe.hu/img/mobile.gif\"> "+tableObjects.telephone+"<br>" : "")
                }
                else
                {
                    
                }
                if tableObjects.email.characters.isEmpty != true
                {
                    strings = strings+(tableObjects.email.characters.count > 0 ? "<img style='width:22px; height:22px;'  src=\"http://localbluepages.com.au/images/icons/email.gif\"> "+tableObjects.email+"<br>" : "")
                }
                else
                {
                    
                }
                if tableObjects.website.characters.isEmpty != true{
                    strings = strings+(tableObjects.website.characters.count > 0 ? "<img style='width:22px; height:22px;'  src=\"http://getmydetails.pe.hu/img/website.gif\"> "+tableObjects.website : "")
                }
                
            }
            else{
                let tableObjects:StorageSubCatagoriezTwo = subCatagorizeDataTwo[indexPath.row]
                cell.bussinessName.text = tableObjects.nameString
                
                let charCheck = (tableObjects.address).replacingOccurrences(of: " ", with: "")
                print(charCheck)
                cell.bussinessName.text = " "
                
                var strings = ""
                
                strings = strings+(tableObjects.nameString.characters.count > 0 ? "<font size=\"3\"><b>"+tableObjects.nameString+"</b></font><br>" : "")
                strings = strings+(tableObjects.nameString.characters.count > 0 ? "<font size=\"3\"><b>"+tableObjects.address+"</b></font><br>" : "")
                // strings = strings+(tableObjects.address.characters.count > 0 ? "<img src=\"http://getmydetails.pe.hu/img/yt.jpg\"> "+tableObjects.address+"<br>" : "")
                
                strings = strings+(tableObjects.telephone.characters.count > 0 ? "<img style='width:22px; height:22px;' src=\"http://getmydetails.pe.hu/img/mobile.gif\"> "+tableObjects.telephone+"<br>" : "")
                
                strings = strings+(tableObjects.email.characters.count > 0 ? "<img style='width:22px; height:22px;'  src=\"http://getmydetails.pe.hu/img/email.gif\"> "+tableObjects.email+"<br>" : "")
                
                strings = strings+(tableObjects.website.characters.count > 0 ? "<img style='width:22px; height:22px;'  src=\"http://getmydetails.pe.hu/img/website.gif\"> "+tableObjects.website : "")
                
                // cell.bussinessWebView.loadHTMLString("<font size=\"5\"><b>"+tableObjects.nameString+"</b></font><br><img src=\"http://getmydetails.pe.hu/img/yt.jpg\"> "+tableObjects.address+"<br><img src=\"http://getmydetails.pe.hu/img/mobile.gif\"> "+tableObjects.telephone+"<br><img src=\"http://getmydetails.pe.hu/img/email.gif\"> "+tableObjects.email+"<br><img src=\"http://getmydetails.pe.hu/img/website.gif\"> "+tableObjects.website, baseURL: nil)
                
                cell.bussinessWebView.loadHTMLString(strings, baseURL: nil)
                let heightIndex = strings.components(separatedBy: "<br>")
                let heightMul = heightIndex.count
                print(heightMul*32)
                
                self.heightOfTheCell = CGFloat(((heightMul)*32)+4)
                
                
            }
            return cell
        }
        else if indexPath.section == 1
        {
            let cell = self.bussinessTableView.dequeueReusableCell(withIdentifier: "bussinessCell2")
            cell?.textLabel?.textAlignment = .center
            switch regId
            {
            case 0:
                if subCatagorizeDataTwo.count != forAll
                {
                    cell?.textLabel?.text = "LOAD MORE DATA"
                    cell?.textLabel?.textColor = Color.whiteColor
                    cell?.backgroundColor = UIColor.darkGray
                    
                }else{
                    cell?.textLabel?.text = "NO MORE FOUND!"
                    cell?.textLabel?.textColor = UIColor.darkGray
                    cell?.backgroundColor = UIColor.gray
                    cell?.selectionStyle = UITableViewCellSelectionStyle.none
                }
            case 1:
                if subCatagorizeDataTwoN.count != forN
                {
                    cell?.textLabel?.text = "LOAD MORE DATA"
                    cell?.textLabel?.textColor = Color.whiteColor
                    cell?.backgroundColor = UIColor.darkGray
                    
                }else{
                    cell?.textLabel?.text = "NO MORE FOUND!"
                    cell?.textLabel?.textColor = UIColor.darkGray
                    cell?.backgroundColor = UIColor.gray
                    cell?.selectionStyle = UITableViewCellSelectionStyle.none
                }
            case 2:
                if subCatagorizeDataTwoE.count != forE
                {
                    cell?.textLabel?.text = "LOAD MORE DATA"
                    cell?.textLabel?.textColor = Color.whiteColor
                    cell?.backgroundColor = UIColor.darkGray
                    
                }else{
                    cell?.textLabel?.text = "NO MORE FOUND!"
                    cell?.textLabel?.textColor = UIColor.darkGray
                    cell?.backgroundColor = UIColor.gray
                    cell?.selectionStyle = UITableViewCellSelectionStyle.none
                }
            case 3:
                if subCatagorizeDataTwoS.count != forS
                {
                    cell?.textLabel?.text = "LOAD MORE DATA"
                    cell?.textLabel?.textColor = Color.whiteColor
                    cell?.backgroundColor = UIColor.darkGray
                    
                }else{
                    cell?.textLabel?.text = "NO MORE FOUND!"
                    cell?.textLabel?.textColor = UIColor.darkGray
                    cell?.backgroundColor = UIColor.gray
                    cell?.selectionStyle = UITableViewCellSelectionStyle.none
                }
            case 4:
                if subCatagorizeDataTwoW.count != forW
                {
                    cell?.textLabel?.text = "LOAD MORE DATA"
                    cell?.textLabel?.textColor = Color.whiteColor
                    cell?.backgroundColor = UIColor.darkGray
                    
                }else{
                    cell?.textLabel?.text = "NO MORE FOUND!"
                    cell?.textLabel?.textColor = UIColor.darkGray
                    cell?.backgroundColor = UIColor.gray
                    cell?.selectionStyle = UITableViewCellSelectionStyle.none
                }
                
            default:break
            }
            
            return cell!
        }
        else
        {
            let tableObjects:StorageSubCatagoriez3rd = SubCatagoriez3rd[indexPath.row]
            let cell = self.bussinessTableView.dequeueReusableCell(withIdentifier: "bussinessCell3")
            cell?.textLabel?.text = tableObjects.nameString
            return cell!
            
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section == 0
        {
            self.performSegue(withIdentifier: "profileSegue", sender: self)
        }
        else if indexPath.section == 1
        {
            if regId == 1
            {
                if self.subCatagorizeDataTwoN.count >= forN+10
                {
                    self.forN = forN+10
                }
                else
                {
                    self.forN = self.subCatagorizeDataTwoN.count
                }

            }
            else if regId == 2
            {
                if self.subCatagorizeDataTwoE.count >= forE+10
                {
                    self.forE = forE+10
                }
                else
                {
                    self.forE = self.subCatagorizeDataTwoE.count
                }
                
            }
            else if regId == 3
            {
                if self.subCatagorizeDataTwoS.count >= forN+10
                {
                    self.forS = forS+10
                }
                else
                {
                    self.forS = self.subCatagorizeDataTwoS.count
                }
            }
            else if regId == 4
            {
                if self.subCatagorizeDataTwoW.count >= forW+10
                {
                    self.forW = forW+10
                }
                else
                {
                    self.forW = self.subCatagorizeDataTwoW.count
                }
            }
            else
            {
                if self.subCatagorizeDataTwo.count >= forAll+10
                {
                    self.forAll = forAll+10
                }
                else
                {
                    self.forAll = self.subCatagorizeDataTwo.count
                }
            }
            
            self.bussinessTableView.reloadData()
                
        }
        else
        {
            let index = bussinessTableView.indexPathForSelectedRow
            let tableObjects:StorageSubCatagoriez3rd = SubCatagoriez3rd[(index?.row)!]
            self.id = tableObjects.idString
            self.catName = tableObjects.nameString
            navigationItem.title = Strings.stringCheck(catName)
            self.UpdateSubCatagorizeTwo(id)
        }
    }
    
    @IBAction func actionAll(_ sender: AnyObject) {
        
        self.regId = 0
        bussinessTableView.reloadData()
        buttons.style(allButton,State: "active")
        buttons.style(northButton, State: "normal")
        buttons.style(eastButton, State: "normal")
        buttons.style(westButton, State: "normal")
        buttons.style(southButton, State: "normal")
        
    }
    
    @IBAction func actionNorth(_ sender: AnyObject) {
        
        self.regId = 1
        bussinessTableView.reloadData()
        buttons.style(allButton,State: "normal")
        buttons.style(northButton, State: "active")
        buttons.style(eastButton, State: "normal")
        buttons.style(westButton, State: "normal")
        buttons.style(southButton, State: "normal")
    }
    
    @IBAction func actionEast(_ sender: AnyObject) {

        
        self.regId = 3
        bussinessTableView.reloadData()
        
        buttons.style(allButton,State: "normal")
        buttons.style(northButton, State: "normal")
        buttons.style(eastButton, State: "active")
        buttons.style(westButton, State: "normal")
        buttons.style(southButton, State: "normal")
    }
    @IBAction func actionWest(_ sender: AnyObject) {
        
        self.regId = 2
        bussinessTableView.reloadData()
        buttons.style(allButton,State: "normal")
        buttons.style(northButton, State: "normal")
        buttons.style(eastButton, State: "normal")
        buttons.style(westButton, State: "active")
        buttons.style(southButton, State: "normal")
        
    }
    @IBAction func actionSouth(_ sender: AnyObject) {
        
        self.regId = 4
        bussinessTableView.reloadData()
        buttons.style(allButton,State: "normal")
        buttons.style(northButton, State: "normal")
        buttons.style(eastButton, State: "normal")
        buttons.style(westButton, State: "normal")
        buttons.style(southButton, State: "active")

    }
    
    func tableReload(_ Value:CGFloat)
    {
        self.heightOfTheCell = Value
        bussinessTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        if indexPath.section == 0
        {
            if heightOfTheCell != nil
            {
                return heightOfTheCell
            }else{
                return UITableViewAutomaticDimension
            }
        }
        else{
            return UITableViewAutomaticDimension
        }



    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {

        print(webView.scrollView.contentSize.height)
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        

            return UITableViewAutomaticDimension
        


    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if section == 2
        {
            
            if SubCatagoriez3rd.indices.count >= 1
            {
                return "Related Categories"
            }else{
                return nil
            }
        }
        return nil
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let index = bussinessTableView.indexPathForSelectedRow
        
        let tableObjects:StorageSubCatagoriezTwo = subCatagorizeDataTwo[(index?.row)!]
        let vc = segue.destination as! Profile
        
        vc.id = tableObjects.idString
        vc.title = Strings.stringCheck(tableObjects.nameString)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    



}
