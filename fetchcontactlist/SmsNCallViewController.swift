//
//  SmsNCallViewController.swift
//  fetchcontactlist
//
//  Created by MacStudent on 2019-07-16.
//  Copyright © 2019 MacStudent. All rights reserved.
//

import UIKit
import MessageUI

class SmsNCallViewController: UIViewController, MFMessageComposeViewControllerDelegate  {

    
    @IBOutlet weak var txtNumber: UITextField!
    
    @IBOutlet weak var txtMessage: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnSend(_ sender: UIButton) {
        
        if MFMessageComposeViewController.canSendText() {
            
            
            let messageVC = MFMessageComposeViewController()
            
            messageVC.body = "Hello, How are you?"
            messageVC.recipients = ["+11234567890"]
            messageVC.messageComposeDelegate = self
            
            self.present(messageVC, animated: false, completion: nil)
        }
        else{
            print("NO SIM available")
        }
    }
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult)
    {
        
        switch (result) {
        case .cancelled:
            print("Message was cancelled")
            self.dismiss(animated: true, completion: nil)
        case .failed:
            print("Message failed")
            self.dismiss(animated: true, completion: nil)
        case .sent:
            print("Message was sent")
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func btnCall(_ sender: UIButton) {
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
