//
//  ViewController.swift
//  fetchcontactlist
//
//  Created by MacStudent on 2019-07-16.
//  Copyright © 2019 MacStudent. All rights reserved.
//

import UIKit

class EmailViewController: UIViewController {

    @IBOutlet weak var txtEmail: UITextField!
    
    @IBOutlet weak var txtSubject: UITextField!
    
    
    @IBOutlet weak var txtBody: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBAction func sendEmail(_ sender: UIButton) {
    }
}

