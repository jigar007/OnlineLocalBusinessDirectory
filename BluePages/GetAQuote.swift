//
//  GetAQuote.swift
//  BluePages
//
//  Created by Kunal Parekh on 23/10/16.
//  Copyright © 2016 Kunal Parekh. All rights reserved.
//

import UIKit
import MessageUI

extension String {
    var isAlpha: Bool {
        
        return range(of: "^[a-zA-Z]+$", options: .regularExpression) != nil
    }
}

class GetAQuote: UIViewController,MFMailComposeViewControllerDelegate,UITextFieldDelegate,UITextViewDelegate{

    @IBOutlet var closeButton: UIButton!
    @IBOutlet var nameField: UITextField!
    @IBOutlet var suburbField: UITextField!
    @IBOutlet var contactField: UITextField!
    @IBOutlet var emailField: UITextField!
    @IBOutlet var messageVIew: UITextView!
    
    @IBOutlet var urgentButton: UIButton!
    @IBOutlet var quoteOne: UIButton!
    @IBOutlet var quoteTwo: UIButton!
    @IBOutlet var quoteThree: UIButton!
    @IBOutlet var futureButton: UIButton!
    
    @IBOutlet var submitButtin: UIButton!
    
    let alertMessage = alert()
    
    var urgent = "NO"
    var noOfQuote = 1
    var futureCommunication = "NO"
    var bodyString:String! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Screens.buttons(closeButton)
        Screens.buttons(submitButtin)
        submitButtin.layer.frame.size.width = 109
        submitButtin.layer.position.x = UIScreen.main.bounds.width/2
        
        let color:UIColor = self.view.backgroundColor!
        view.backgroundColor = color.withAlphaComponent(0.9)
        
        self.quoteOne.setTitle("■", for: .normal)
        self.quoteTwo.setTitle("", for: .normal)
        self.quoteThree.setTitle("", for: .normal)
        self.urgentButton.setTitle("", for: .normal)
        self.futureButton.setTitle("", for: .normal)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        

            if (nameField.text?.isEmpty ?? true) {
                textField.resignFirstResponder()
            }
            else if textField == nameField {
                suburbField.becomeFirstResponder()
                
            }
            else if textField == suburbField
            {
                contactField.becomeFirstResponder()
            }
                
            else if textField == contactField
            {
                emailField.becomeFirstResponder()
            }
            else if textField == emailField
            {
                messageVIew.becomeFirstResponder()
            }
            else
            {
                textField.resignFirstResponder()
            }
            
            return true
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool
    {
        if text == "\n"
        {
            view.endEditing(true)
            return false
        }
        else
        {
            return true
        }
        
        
    }

    
    @IBAction func dismissAction(_ sender: AnyObject) {
        
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func urgentAction(_ sender: UIButton) {
    }
    
    @IBAction func QuoteAction(_ sender: UIButton) {
        
        self.quoteTwo.setTitle("", for: .normal)
        self.quoteThree.setTitle("", for: .normal)
        
        if sender.currentTitle == "■"
        {
            noOfQuote = 1
            sender.setTitle("", for: .normal)
        }
        else
        {
            sender.setTitle("■", for: .normal)
            noOfQuote = 1
        }
        
    }
    
    @IBAction func QuoteActionTwo(_ sender: UIButton) {
        
        self.quoteOne.setTitle("", for: .normal)
        self.quoteThree.setTitle("", for: .normal)
        
        if sender.currentTitle == "■"
        {
            noOfQuote = 1
            sender.setTitle("", for: .normal)
        }
        else
        {
            sender.setTitle("■", for: .normal)
            noOfQuote = 2
        }
    }
    
    @IBAction func quoteActionThree(_ sender: UIButton) {
        
        self.quoteOne.setTitle("", for: .normal)
        self.quoteTwo.setTitle("", for: .normal)
        
        if sender.currentTitle == "■"
        {
            noOfQuote = 1
            sender.setTitle("", for: .normal)
            
        }
        else
        {
            sender.setTitle("■", for: .normal)
            noOfQuote = 3
        }
        
    }
    
    @IBAction func UrgentAction(_ sender: UIButton) {
        
        if sender.currentTitle == "■"
        {
            self.urgent = "NO"
            sender.setTitle("", for: .normal)
        }
        else
        {
            self.urgent = "YES"
            sender.setTitle("■", for: .normal)
        }
    }
    
    @IBAction func futureAction(_ sender: UIButton) {
       
        if sender.currentTitle == "■"
        {
            self.futureCommunication = "NO"
            sender.setTitle("", for: .normal)
        }
        else
        {
            self.futureCommunication = "YES"
            sender.setTitle("■", for: .normal)
        }
    }

    
    @IBAction func submitAction(_ sender: UIButton) {
        
        let name = nameField.text
        let suburb = suburbField.text
        let contact = contactField.text
        let email = emailField.text
        let body = messageVIew.text
        
        let contactCheck = Int64(contact!)
        
        if name?.isAlpha == true
        {
            if suburb?.characters.isEmpty != true
            {
                if contactCheck != nil
                {
                    if isValidEmail(email!) == true
                    {
                        if (body?.characters.count)! >= 10
                        {
                            bodyString = "Name: "+name!+"\n"+"Suburb: "+suburb!+"\n"+"Contact: "+contact!+"\n"+"EMail :"+email!+"\n"+"Is Job Urgent: "+urgent+"\nNo of Quotes: "+String(noOfQuote)+"\nInclude in future communications: "+futureCommunication+"\nMessage: "+body!
                           self.emailSuccess()
                        }
                        else
                        {
                            self.alertMessage.alert("Please brief your Message!", icon: "error", View: self)
                        }
                    }
                    else
                    {
                        self.alertMessage.alert("Please Enter valid Email!", icon: "error", View: self)
                    }
                }
                else
                {
                    self.alertMessage.alert("Please Enter Valid Contact Number!", icon: "error", View: self)
                }
            }
            else
            {
                self.alertMessage.alert("Please Enter Suburb Name!", icon: "error", View: self)
            }
        }
        else
        {
            self.alertMessage.alert("Invalid Name!", icon: "error", View: self)
        }
        
    }
    
    private func isValidEmail(_ email:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: email)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.view.endEditing(true)
    }
    
    
    func emailSuccess()
    {
        let imageView = UIImageView(frame: CGRect(x: 70, y: 14, width: 30, height: 30))
        imageView.image = UIImage(named: "avatar")
        
        let alertController = UIAlertController(title: "Alert!", message: "\nAre you Sure Want Email to Bluey's?", preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.destructive,handler: { action in
            self.emailPressed()
        }))
        alertController.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default,handler: nil))
        alertController.view.addSubview(imageView)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func emailPressed()
    {
        let mailComposeViewController = configuredMailComposeViewController()
        if MFMailComposeViewController.canSendMail() {
            self.present(mailComposeViewController, animated: true, completion: nil)
        } else {
            self.showSendMailErrorAlert()
        }
        
    }
    func configuredMailComposeViewController() -> MFMailComposeViewController {
        
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self // Extremely important to set the --mailComposeDelegate-- property, NOT the --delegate-- property
        
        mailComposerVC.setToRecipients([Constants.contantTitles().emailID])
        mailComposerVC.setSubject("Mail-Bluey's iOS App")
        mailComposerVC.setMessageBody(bodyString, isHTML: false)
        
        return mailComposerVC
    }
    
    func showSendMailErrorAlert() {
        
        let imageView = UIImageView(frame: CGRect(x: 70, y: 14, width: 30, height: 30))
        imageView.image = UIImage(named: "error")
        
        let alertController = UIAlertController(title: "Alert!", message: "\nError with Email Sending!", preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.default,handler: nil))
        alertController.view.addSubview(imageView)
        self.present(alertController, animated: true, completion: nil)
        
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }


}
