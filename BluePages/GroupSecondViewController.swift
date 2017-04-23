//
//  GroupSecondViewController.swift
//  BluePages
//
//  Created by Kunal Parekh on 23/10/16.
//  Copyright © 2016 Kunal Parekh. All rights reserved.
//

import UIKit
import RealmSwift
import Realm

class GroupSecondViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet var groupSecondTableView: UITableView!
    
    @IBOutlet var navigationView: UIView!
    @IBOutlet var sortMenu: UIView!
    
    var subCatagorizeData = Array<StorageSubCatagoriez>()
    var subCatagorizeData2 = Array<StorageSubCatagoriez2>()
    
    let progress = loadingAnimation.loading()
    let urls = webLinks.URLS()
    let alertMessage = alert()
    let Color = Screens.colors()
    
    let scr = Screens()
    
    var id:String! = nil
    var numberofrows = 0
    
    var papulorReference = 0
    var referenceID = 0
    
    let shadowView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Screens.bottomBar(sortMenu)
        
        sortMenu.backgroundColor = Color.blueColor
        shadowView.isHidden = true
        sortMenu.isHidden = true
        
        let backItem = UIBarButtonItem()
        backItem.title = "Back"
        navigationItem.backBarButtonItem = backItem
        
        self.UpdateSubCatagorize(id,url: urls.subCatagorizeURL)
        self.view.addSubview(progress)
        
        self.sortMenu.layer.position = CGPoint(x: self.scr.size().width-(177/2), y: -48.5)
        shadowView.layer.bounds = self.view.layer.bounds
        shadowView.layer.position = CGPoint(x: scr.size().width/2, y: scr.size().height/2)
      
        shadowView.backgroundColor = UIColor.gray.withAlphaComponent(0)
        self.view.addSubview(shadowView)
        view.bringSubview(toFront: sortMenu)
    }
    
    func animForMenu(_ option:Bool)
    {
        if option == true
        {
            shadowView.isHidden = false
            sortMenu.isHidden = false
            
            UIView.animate(withDuration: 0.4, animations: {
                
                self.sortMenu.layer.position = CGPoint(x: self.scr.size().width-(177/2), y: 48.5)
                self.shadowView.backgroundColor = UIColor.gray.withAlphaComponent(0.6)
            })
            
        }else{
            
            UIView.animate(withDuration: 0.4, animations: {
                self.sortMenu.layer.position = CGPoint(x: self.scr.size().width-(177/2), y: -48.5)
                self.shadowView.backgroundColor = UIColor.gray.withAlphaComponent(0)
                },  completion: { (Bool) in
                    
                    self.shadowView.isHidden = true
                    self.sortMenu.isHidden = true
            })
        }
    }

    //HTTP POST
    func UpdateSubCatagorize(_ id:String,url:URL)
    {
        self.view.isUserInteractionEnabled = false
        progress.isHidden = false
        
        let request = NSMutableURLRequest(url: url)
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
                            
                            let id = dictionary["id"] as! String
                            let name = dictionary["NAME"] as! String
                             let countTotal = dictionary["TOTAL"] as! String
                            
                            DispatchQueue.main.sync
                                {
                                    if self.papulorReference == 0
                                    {
                                        self.subCatagorizeData.append(StorageSubCatagoriez(tempName: name, tempID: id, tempCount: countTotal))
                                    }else{
                                         self.subCatagorizeData2.append(StorageSubCatagoriez2(tempName: name, tempID: id, tempCount: countTotal))
                                    }
                            }
                            
                        }
                        
                        DispatchQueue.main.async {
                            
                            if self.subCatagorizeData.count >= 10
                            {
                                self.numberofrows = 10
                            }
                            else
                            {
                                self.numberofrows = self.subCatagorizeData.count
                            }
                            self.groupSecondTableView.reloadData()
                            self.progress.isHidden = true
                            self.view.isUserInteractionEnabled = true
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
    
    // Table View
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if referenceID == 0
        {
            return subCatagorizeData.count
        }else{
            return subCatagorizeData2.count
        }
    }
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.groupSecondTableView.dequeueReusableCell(withIdentifier: "catagoryCell") as! GroupSubCatCells
        
        if referenceID == 0
        {
        let tableObject:StorageSubCatagoriez = subCatagorizeData[indexPath.row]

        
        // cell.catName.text = tableObject.nameString
     //   cell.countcat.text =  tableObject.ctotal
        
            
        cell.textLabel?.text = tableObject.nameString +  " (" + tableObject.ctotal + ")"
            
        cell.textLabel?.font = UIFont.systemFont(ofSize: 15)
        
        cell.textLabel?.numberOfLines=0
        cell.textLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
        // cell.textLabel?.numberOfLines = 0
        // cell.catName.numberOfLines = 0
        
        //cell?.textLabel?.text = tableObject.ctotal
        }else{
            let tableObject:StorageSubCatagoriez2 = subCatagorizeData2[indexPath.row]
            cell.countcat.text =  tableObject.ctotal
            cell.textLabel?.text = tableObject.nameString               +  " (" + tableObject.ctotal + ")"
            cell.textLabel?.font = UIFont.systemFont(ofSize: 15)
        }
        //
        
        cell.star.tag = indexPath.row
        cell.star.addTarget(self, action: Selector(("saveData")), for: .touchUpInside)
        
        
        //
        return cell
        
    }
    
    @IBAction func saveData(sender: UIButton){
        
        
    }

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
      
            self.performSegue(withIdentifier: "groupSegue3rd", sender: self)

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableViewAutomaticDimension
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let index = groupSecondTableView.indexPathForSelectedRow

        
        let vc = segue.destination as! GroupSubCatThirdView
        
        if referenceID == 0
        {
            let tableObject:StorageSubCatagoriez = subCatagorizeData[(index?.row)!]
            vc.id = tableObject.idString
            vc.catName = tableObject.nameString
            vc.HeaderName = Strings.stringCheck(tableObject.nameString)
            vc.title = Strings.stringCheck(tableObject.nameString)
            
        }else{
            
            let tableObject:StorageSubCatagoriez2 = subCatagorizeData2[(index?.row)!]
            vc.id = tableObject.idString
            vc.catName = tableObject.nameString
            vc.HeaderName = Strings.stringCheck(tableObject.nameString)
            vc.title = Strings.stringCheck(tableObject.nameString)
        }
       

        
    }
    
    @IBAction func SortByAction(_ sender: AnyObject) {
        
        if sortMenu.isHidden == true
        {
            self.animForMenu(true)
        }else{
            self.animForMenu(false)
        }
    }
    
    @IBAction func AlphaBetsAction(_ sender: AnyObject) {
        
        self.referenceID = 0
        self.animForMenu(false)
        self.groupSecondTableView.reloadData()
    }
    
    @IBAction func PapulorAction(_ sender: AnyObject) {
        
        self.referenceID = 1
        self.animForMenu(false)
        
        if subCatagorizeData2.indices.count == 0
        {
            self.papulorReference = 1
           self.UpdateSubCatagorize(id,url: urls.papulor2)
            
        }else{
            self.groupSecondTableView.reloadData()
        }
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    


}
