//
//  ViewController.swift
//  BluePages
//
//  Created by Kunal Parekh on 22/10/16.
//  Copyright © 2016 Kunal Parekh. All rights reserved.
//

import UIKit


extension UINavigationBar {
    open override func sizeThatFits(_ size: CGSize) -> CGSize {
        let width = UIScreen.main.bounds.width
        let newSize = CGSize(width: width, height: 88)
        return newSize
    }
}

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UINavigationControllerDelegate{
    
    
    @IBOutlet var groupTableView: UITableView!
    
    @IBOutlet var getAQuote: UIButton!

    @IBOutlet var logoImage: UIImageView!
    @IBOutlet var topTitleLabel: UILabel!
    @IBOutlet var halfColourView: UIView!
    
    @IBOutlet var sortMenu: UIView!
    
    let scr = Screens()
    
    let progress = loadingAnimation.loading()
    let urls = webLinks.URLS()
    let alertMessage = alert()
    let Color = Screens.colors()
    
    var tableData = Array<JSONTableData>()
    var tableData2 = Array<JSONTableData2>()
    var numberofrows = 0

    let titles = Constants.contantTitles()
    var isAscending = true
    
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
        
        Screens.navigationAlign(ViewController: self, navigationController: self.navigationController!, Image: logoImage, Button: getAQuote,topTitle:topTitleLabel,halfColourView:halfColourView)
        
        statusbar.color("white")
        
        self.updateDetails(urls.catagorizeURL)
        self.view.addSubview(progress)

        self.sortMenu.layer.position = CGPoint(x: self.scr.size().width-(177/2), y: -96)
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
    //HTTP GET
    func updateDetails(_ url:URL)
    {

        self.view.isUserInteractionEnabled = false
        progress.isHidden = false
        let request = NSMutableURLRequest(url: url)
        
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
                            let icon = dictionary["icon"] as! String
                            let total = dictionary["TOTAL"] as! String
                            
                            DispatchQueue.main.async
                                {
                                    if self.papulorReference == 0
                                    {
                                    self.checkStrings(icon, id: id, name: name, total: total)
                                    }else{
                                        self.checkStrings2(icon, id: id, name: name, total: total)
                                    }
                            }
                            
                        }
                        DispatchQueue.main.async {
                            
                            if self.tableData.count >= 10
                            {
                                self.numberofrows = 10
                            }
                            else
                            {
                                self.numberofrows = self.tableData.count
                            }
                            self.groupTableView.reloadData()
                            self.progressIsHidden(true)
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
    
    private func progressIsHidden(_ isHidden:Bool)
    {
        self.progress.isHidden = isHidden
        self.view.isUserInteractionEnabled = isHidden
    }
    
    
    func checkStrings(_ imageString:String,id:String,name:String, total:String)
    {
        
        if imageString.characters.count >= 2
        {
            if imageString != "<null>"
            {
                let url:URL = URL(string:"http://www.localbluepages.com.au/images/groupicons/"+imageString)!
                
                let data = NSData(contentsOf:url)
                if data != nil
                {
                    //profileImageView.image = UIImage(data:data! as Data)
                    self.tableData.append(JSONTableData(tempName: name, tempID: id, icons: UIImage(data:data! as Data)!, tempgbcount: total))
                    self.groupTableView.reloadData()
                    //self.progressIsHidden(true)
                }
                else
                {
                    //profileImageView.image = UIImage(named: "cover")
                    print(imageString,id,name)
                    self.tableData.append(JSONTableData(tempName: name, tempID: id, icons: UIImage(named: "cover")!, tempgbcount: total))
                    self.groupTableView.reloadData()
                    //self.progressIsHidden(true)
                    
                }
                
            }
            else
            {
                //profileImageView.image = UIImage(named: "cover")
                print(imageString,id,name)
                self.tableData.append(JSONTableData(tempName: name, tempID: id, icons: UIImage(named: "cover")!, tempgbcount: total))
                
            }
        }
        else
        {
            print(imageString,id,name)
            self.tableData.append(JSONTableData(tempName: name, tempID: id, icons: UIImage(named: "cover")!, tempgbcount: total))
        }
        
    }
    
    //for papulor. we have no time na.. so
    func checkStrings2(_ imageString:String,id:String,name:String, total:String)
    {
        
        if imageString.characters.count >= 2
        {
            if imageString != "<null>"
            {
                let url:URL = URL(string:"http://www.localbluepages.com.au/images/groupicons/"+imageString)!
                
                let data = NSData(contentsOf:url)
                if data != nil
                {
                    //profileImageView.image = UIImage(data:data! as Data)
                    self.tableData2.append(JSONTableData2(tempName: name, tempID: id, icons: UIImage(data:data! as Data)!, tempgbcount: total))
                    self.groupTableView.reloadData()
                    //self.progressIsHidden(true)
                }
                else
                {
                    //profileImageView.image = UIImage(named: "cover")
                    print(imageString,id,name)
                    self.tableData2.append(JSONTableData2(tempName: name, tempID: id, icons: UIImage(named: "cover")!, tempgbcount: total))
                    self.groupTableView.reloadData()
                    //self.progressIsHidden(true)
                    
                }
                
            }
            else
            {
                //profileImageView.image = UIImage(named: "cover")
                print(imageString,id,name)
                self.tableData2.append(JSONTableData2(tempName: name, tempID: id, icons: UIImage(named: "cover")!, tempgbcount: total))
                
            }
        }
        else
        {
            print(imageString,id,name)
            self.tableData2.append(JSONTableData2(tempName: name, tempID: id, icons: UIImage(named: "cover")!, tempgbcount: total))
        }
        
    }

    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if referenceID == 0
        {
            return tableData.count
        }else{
            return tableData2.count
        }

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.groupTableView.dequeueReusableCell(withIdentifier: "groupCells", for: indexPath) as! groupCells
        
        
        if referenceID == 0
        {
            let tableObject:JSONTableData = tableData[indexPath.row]
            
            cell.imageIcon.image = tableObject.icons
            cell.groupNameLabel.text = tableObject.nameString
            cell.grCount.text = tableObject.gbcount
        }else{
            let tableObject:JSONTableData2 = tableData2[indexPath.row]
            
            cell.imageIcon.image = tableObject.icons
            cell.groupNameLabel.text = tableObject.nameString
            cell.grCount.text = tableObject.gbcount
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.performSegue(withIdentifier: "groupSegue2nd", sender: self)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "groupSegue2nd"
        {

            let index = groupTableView.indexPathForSelectedRow

            let vc = segue.destination as! GroupSecondViewController
            if referenceID == 0
            {
                let tableObject:JSONTableData = tableData[index!.row]
                vc.id = tableObject.idString
                vc.title = Strings.stringCheck(tableObject.nameString)
                
            }else{
                let tableObject:JSONTableData2 = tableData2[index!.row]
                vc.id = tableObject.idString
                vc.title = Strings.stringCheck(tableObject.nameString)
            }

            
        }else{
            
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        topTitleLabel.isHidden = false
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        topTitleLabel.isHidden = false
        
    }
    @IBAction func SortByAction(_ sender: AnyObject) {
        
        if sortMenu.isHidden == true
        {
            animForMenu(true)
        }else{
            animForMenu(false)
        }
    }
    
    @IBAction func AlphaBetsAction(_ sender: AnyObject) {
        
        self.referenceID = 0
        animForMenu(false)
        self.groupTableView.reloadData()
    }
    
    @IBAction func PapulorAction(_ sender: AnyObject) {
        
        self.referenceID = 1
        animForMenu(false)
        
        if tableData2.indices.count == 0
        {
            self.papulorReference = 1
            self.updateDetails(urls.papulor1)
            
        }else{
            self.groupTableView.reloadData()
        }

    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

