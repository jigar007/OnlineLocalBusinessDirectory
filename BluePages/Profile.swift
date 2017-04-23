//
//  Profile.swift
//  BluePages
//
//  Created by Kunal Parekh on 23/10/16.
//  Copyright © 2016 Kunal Parekh. All rights reserved.
//

import UIKit

class Profile: UIViewController,UITableViewDataSource,UITableViewDelegate{
    
    let logoImage:UIImage! = nil

    @IBOutlet var bottomBaeView: UIView!
    let headerTitles = ["ADDRESS","OPENING TIME","ABOUT_US","SPECIALS"]
    
    
    let dummieData = ["dfskdskdfkkfgkldfgklfdgkldlkgl","djkskgdfjklgeriuthjgdkfgj"]
    
    
    var id:String? = nil
    
    var imageWidth:CGFloat = 0
    var imageHeight:CGFloat = 0
    var tabelHeight:CGFloat = 0
    
    let logoImageView:UIImageView! = UIImageView()
    
    let progress = loadingAnimation.loading()
    let urls = webLinks.URLS()
    let alertMessage = alert()
    
    var ContactAddress = Array<StorageContactAddress>()
    var ContactTime = Array<StorageContactTime>()
    var aboutStorage = Array<aboutStorageClass>()
    
    //Temp Storage for Dynamic URL's, Email and Phone
    
    var phoneNumber:String! = nil
    var emailURL:String! = nil
    var webURL:String! = nil
    var googleURL:String! = nil
    var youtubeURL:String! = nil
    var facebookURL:String! = nil
    var twitterURL:String! = nil
    
    var bussinessName:String! = nil
    // which is used to pass url string from this vc to web vc
    
    var destinationTitle:String! = nil
    var destinationURL:String! = nil
    
    let scr = Screens()
    
    @IBOutlet var profileTableView: UITableView!
    @IBOutlet var aboutTableView: UITableView!
    
    @IBOutlet var profileButton: UIButton!
    @IBOutlet var contactButton: UIButton!
    @IBOutlet var aboutButton: UIButton!
    
    @IBOutlet var profileVIew: UIView!
    @IBOutlet var aboutView: UIView!
    
    var referenceID = 0
    var aboutString:String! = nil
    var specialString:String! = nil
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        aboutView.isHidden = true
        profileVIew.isHidden = false
        
        Screens.bottomBar(bottomBaeView)
        buttons.style(profileButton,State: "active")
        buttons.style(aboutButton, State: "normal")
        buttons.style(contactButton, State: "normal")
        
        let backItem = UIBarButtonItem()
        backItem.title = "Back"
        navigationItem.backBarButtonItem = backItem
        
        self.UpdateSubCatagorize(id!)
        self.view.addSubview(progress)
    }
    
    @IBAction func actionProfileButton(_ sender: AnyObject) {
        
        aboutView.isHidden = true
        profileVIew.isHidden = false
        
        buttons.style(profileButton,State: "active")
        buttons.style(aboutButton, State: "normal")
        buttons.style(contactButton, State: "normal")
    }
    
    @IBAction func actionContactButton(_ sender: AnyObject) {
        
        aboutView.isHidden = false
        profileVIew.isHidden = true
        referenceID = 1
        aboutTableView.reloadData()
        
        buttons.style(profileButton,State: "normal")
        buttons.style(aboutButton, State: "normal")
        buttons.style(contactButton, State: "active")
    }
    
    @IBAction func actionAboutButton(_ sender: AnyObject) {
        
        aboutView.isHidden = false
        profileVIew.isHidden = true
        referenceID = 0
        aboutTableView.reloadData()
        
        buttons.style(profileButton,State: "normal")
        buttons.style(aboutButton, State: "active")
        buttons.style(contactButton, State: "normal")
    }
    
    
    func UpdateSubCatagorize(_ id:String)
    {
        
        
        self.view.isUserInteractionEnabled = false
        progress.isHidden = false
        
        let request = NSMutableURLRequest(url: urls.profileURL as URL)
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
                    let responseString = convert.contvertToDictionary(data!) as? NSArray
                    
                    if responseString != nil
                    {
                        let DictionaryFromresponseString = responseString?[0] as! NSDictionary
                        
                        let name = String(describing: DictionaryFromresponseString["BUSINESS_NAME"]!)
                        //let region = String(describing: DictionaryFromresponseString["region"]!)
                        let email = String(describing: DictionaryFromresponseString["EMAIL"]!)
                        let url = String(describing: DictionaryFromresponseString["WEBURL"]!)
                        let fb = String(describing: DictionaryFromresponseString["FACEBOOK_URL"])
                        let google = String(describing: DictionaryFromresponseString["GOOGLEPLUS_URL"]!)
                        let twt = String(describing: DictionaryFromresponseString["TWITTER_URL"]!)
                        let yt = String(describing: DictionaryFromresponseString["YOUTUBE_URL"]!)
                        let Suburb = String(describing: DictionaryFromresponseString["Suburb"]!)
                        let abtus = String(describing: DictionaryFromresponseString["ABOUT_US"]!)
                        let ps = String(describing: DictionaryFromresponseString["SPECIALS"]!)
                        //let addloc = String(describing: DictionaryFromresponseString["ADDITIONAL_LOCATION"]!)
                        let streetno = String(describing: DictionaryFromresponseString["STREET_NO"]!)
                        let streetname = String(describing:DictionaryFromresponseString["STREET_NAME"]!)
                        let postcode = String(describing: DictionaryFromresponseString["POSTCODE"]!)
                        
                        let phone = String(describing: DictionaryFromresponseString["PHONE_FIXED"]!)
                        let mobile = String(describing: DictionaryFromresponseString["PHONE_MOBILE"]!)
                        let mono = String(describing: DictionaryFromresponseString["monO"]!)
                        let monc = String(describing: DictionaryFromresponseString["monC"]!)
                        let tueo = String(describing: DictionaryFromresponseString["tueO"]!)
                        let tuec = String(describing: DictionaryFromresponseString["tueC"]!)
                        let wedo = String(describing: DictionaryFromresponseString["wedO"]!)
                        let wedc = String(describing: DictionaryFromresponseString["wedC"]!)
                        let thuro = String(describing: DictionaryFromresponseString["thurO"]!)
                        let thurc = String(describing: DictionaryFromresponseString["thurC"]!)
                        let frio = String(describing: DictionaryFromresponseString["friO"]!)
                        let fric = String(describing: DictionaryFromresponseString["friC"]!)
                        let sato = String(describing: DictionaryFromresponseString["satO"]!)
                        let satc = String(describing: DictionaryFromresponseString["satC"]!)
                        let suno = String(describing: DictionaryFromresponseString["sunO"]!)
                        let sunc = String(describing: DictionaryFromresponseString["sunC"]!)
                        
                        let img = String(describing: DictionaryFromresponseString["FILE_LOCATION"]!)
                        print(img)
                        let SuburbCap = Suburb.capitalized
                        DispatchQueue.main.async
                            {
                                self.progress.isHidden = true
                                self.view.isUserInteractionEnabled = true
                                
                                /*If Image Is available then apply it to ImageView*/
                                self.checkImage(img)
                                
                                /*Update Address Values array One By One*/
                                self.addressArrayUpdate(streetno+" "+streetname+" "+SuburbCap+" "+postcode)
                                self.addressArrayUpdate(phone+" "+mobile)
                                self.addressArrayUpdate(email)
                                self.addressArrayUpdate(url)
                                
                                /*Update Time Values array One By One*/
                                self.timeArrayUpdate(suno, CloseTime: sunc,Date: "Sunday")
                                self.timeArrayUpdate(mono, CloseTime: monc,Date: "Monday")
                                self.timeArrayUpdate(tueo, CloseTime: tuec,Date: "Tuesday")
                                self.timeArrayUpdate(wedo, CloseTime: wedc,Date: "Wednesday")
                                self.timeArrayUpdate(thuro, CloseTime: thurc,Date: "Thursday")
                                self.timeArrayUpdate(frio, CloseTime: fric,Date: "Friday")
                                self.timeArrayUpdate(sato, CloseTime: satc,Date: "Saturday")
                                
                                self.aboutArrayUpdate(abtus,id: 0)
                                self.aboutArrayUpdate(ps,id: 1)
                                
                                self.phoneNumber = mobile
                                self.emailURL = webLinks.checkEmail(email)
                                print(self.emailURL,email,mobile)
                                self.webURL = webLinks.checkURL(url)
                                self.googleURL = webLinks.checkURL(google)
                                self.youtubeURL = webLinks.checkURL(yt)
                                self.facebookURL = webLinks.checkURL(fb)
                                self.twitterURL = webLinks.checkURL(twt)
                                
                                /*Set text for profile Tab*/
                                
                                
                                /*BussinessName for next view TITLE*/
                                
                                self.bussinessName = name
                                
                                /*Reload tableViews after sccessfully updating array one by one. i.e., 0,1,2,...N */
                                
                                self.profileTableView.reloadData()
                                self.aboutTableView.reloadData()
                                
                                
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

    private func checkImage(_ imageString:String)
    {
        if imageString.characters.count >= 2
        {
            if imageString != "<null>"
            {
                let url = NSURL(string:"http://www.localbluepages.com.au/images/"+imageString)
                
                let data = NSData(contentsOf:url! as URL)
                if data != nil
                {
                    logoImageView.image = UIImage(data:data! as Data)
                    
                    let data = NSData(contentsOf: url as! URL)
                    let Image = UIImage(data: data as! Data)!
                    let tableWidth = UIScreen.main.bounds.width
                    let imagHeight = Image.size.height
                    let imagWidth = Image.size.width
                    
                    if tableWidth <= imageWidth
                    {
                        //nothing
                    }
                    else{
                        imageHeight = (imagHeight/imagWidth)*tableWidth
                        imageWidth = (imagWidth/imageHeight)*imagHeight
                    }
                    self.profileTableView.reloadData()
                }
            }
            else
            {
                //logoImageView.image = UIImage(named: "error-404")
            }
        }
        else
        {
            //logoImageView.image = UIImage(named: "error-404")
        }
    }
    
    private func addressArrayUpdate(_ value:String)
    {
        if value.characters.count != 0
        {
            if value != ""
            {
                if value != "<null>"
                {
                    self.ContactAddress.append(StorageContactAddress(tempName: value))
                }
                else
                {
                   // self.ContactAddress.append(StorageContactAddress(tempName: "")) //insert value for satisfy array indices
                }
            }
            else
            {
                //self.ContactAddress.append(StorageContactAddress(tempName: ""))
            }
            
        }
    }
    
    func convertDateFormater(_ time: String) -> String
    {
        
        if time.characters.count == 2
        {
            switch time {
            case "13":
                return "01"
            case "14":
                return "02"
            case "15" :
                return "03"
            case "16":
                return "04"
            case "17":
                return "05"
            case "18":
                return "06"
            case "19":
                return "07"
            case "20":
                return "08"
            case "21":
                return "09"
            case "22":
                return "10"
            case "23":
                return "11"
            case "24":
                return "12"
            default:
                return time
            }
        }
        else
        {
          return "null"
        }
    }
    
    private func timeArrayUpdate(_ OpenTime:String,CloseTime:String,Date:String)
        
    {
        if OpenTime.characters.count >= 2
        {
            if OpenTime != "<null>"
            {
                let separatorOne = OpenTime.components(separatedBy: ":")
                let separatorTwo = CloseTime.components(separatedBy: ":")
                
                let morning = separatorOne[0]
                let evening = separatorTwo[0]
                
                
                let OpenTimed = self.convertDateFormater(morning)
                let CloseTimed = self.convertDateFormater(evening)
                if OpenTimed != "null"
                {
                        if CloseTime != "null"
                        {
                            self.ContactTime.append(StorageContactTime(tempName:Date+" "+OpenTimed+":"+separatorOne[1]+" AM To "+CloseTimed+":"+separatorTwo[1]+" PM"))
                    }
                }

            }
            else
            {
              // self.ContactTime.append(StorageContactTime(tempName: "Not Found!"))
            }
        }
        else
        {
            //self.ContactTime.append(StorageContactTime(tempName: "Not Found!"))
        }
        
    }
    
    private func aboutArrayUpdate(_ value:String,id:Int)
    {
        if value != ""
        {
            if value != "<null>"
            {
                let valueTrimmed = value.replacingOccurrences(of: "[br]", with: "") //What is the [br]??
                let valueTrimmedTwo = valueTrimmed.replacingOccurrences(of: "&#124;", with: "") //What is this &#124;?
               // self.aboutStorage.append(aboutStorageClass(tempText: valueTrimmedTwo))
                switch id {
                case 0:
                    self.aboutString = valueTrimmedTwo
                case 1:
                    self.specialString = valueTrimmedTwo
                default:
                    break
                }

            }
            else
            {
                //self.aboutStorage.append(aboutStorageClass(tempText: ""))
                
            }
        }
        else
        {
           // self.aboutStorage.append(aboutStorageClass(tempText: ""))
            
        }
        
    }

    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        if tableView == profileTableView
        {
            return 3
        }
        else
        {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      
        if tableView == profileTableView
        {
            if section == 0
            {
                return 1
            }
            else if section == 1
            {
                return ContactAddress.count
            }
            else
            {
                return ContactTime.count
            }
        }
        else
        {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        if tableView == profileTableView
        {
            if indexPath.section == 0
            {
                
                let cell1 = self.profileTableView.dequeueReusableCell(withIdentifier: "profileCell1", for: indexPath)
                
                logoImageView.layer.frame.size = CGSize(width: scr.size().width-8, height: imageHeight*2)
                logoImageView.center = cell1.center
                cell1.addSubview(logoImageView)
                cell1.selectionStyle = UITableViewCellSelectionStyle.none
                return cell1
            }
            else if indexPath.section == 1
            {
                let cell = self.profileTableView.dequeueReusableCell(withIdentifier: "profileCell2", for: indexPath)
//                if indexPath.row == 6
//                {
//                    cell.textLabel?.text = "GET DIRECTION"
//                    cell.textLabel?.textColor = UIColor.green
//                    cell.backgroundColor = UIColor.white
//                    cell.selectionStyle = UITableViewCellSelectionStyle.default
//                }
//                else
//                {
                    let addressValues:StorageContactAddress = ContactAddress[indexPath.row]
                    cell.textLabel?.text = addressValues.addressString
                    cell.selectionStyle = UITableViewCellSelectionStyle.none
//                }
                return cell
            }
            else if indexPath.section == 2
            {
    
                let cell = self.profileTableView.dequeueReusableCell(withIdentifier: "profileCell2", for: indexPath)
                
                let timeValues:StorageContactTime = ContactTime[indexPath.row]
                cell.textLabel?.text = timeValues.timeString
                cell.selectionStyle = UITableViewCellSelectionStyle.none
                return cell
            }
            else
            {
                let cell = self.profileTableView.dequeueReusableCell(withIdentifier: "profileCell", for: indexPath)
                return cell
            }
        }
        else
        {
            let cell = self.aboutTableView.dequeueReusableCell(withIdentifier: "aboutCell", for: indexPath) as! AboutCell
//             let textViewValues:aboutStorageClass = aboutStorage[indexPath.row]
            if referenceID == 0
            {
                cell.aboutTextView.text = aboutString
            }else{
                cell.aboutTextView.text = specialString
            }
            
            return cell
        }
        
    }

    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
       if tableView == profileTableView
       {
            if indexPath.section == 0 // tableview had only one section 0
            {
                return (imageHeight*2)+8 //Row height depends on detailTextLabel on section 0
            }
            return UITableViewAutomaticDimension
        
        }
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if tableView == profileTableView
        {
            if tableView == profileTableView
            {
                if section == 0
                {
                    
                    return nil
                }else if section == 1{
                    
                    return headerTitles[0]
                }
                else
                {
                    return headerTitles[1]
                }
            }
            else
            {
                return nil
            }
        }
        else
        {
//            if section == 1{
//                return headerTitles[2]
//            }else{
//                return headerTitles[3]
//            }
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if tableView == profileTableView
        {
            if indexPath.section == 1
            {
                if indexPath.row == 6
                {
                    print("GO TO MAP")
                }
            }

        }
        else
        {
            //nothing
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }


}
