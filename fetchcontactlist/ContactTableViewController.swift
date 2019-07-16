//
//  ContactTableViewController.swift
//  fetchcontactlist
//
//  Created by MacStudent on 2019-07-16.
//  Copyright © 2019 MacStudent. All rights reserved.
//

import UIKit
import ContactsUI

class ContactTableViewController: UITableViewController {

    var phoneContact = [PhoneContact]()
    
    let contactStore = CNContactStore()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.getContacts()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.phoneContact.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "contactCell", for: indexPath)

        
        let contact = self.phoneContact[indexPath.row]
        cell.textLabel?.text = contact.name
        
        if let img  = contact.avatarData{
          
            cell.imageView?.image = UIImage(data: img)
        }
        
        if contact.phoneNumber.count>0{
            cell.detailTextLabel?.textColor = UIColor.blue
            cell.detailTextLabel?.text = contact.phoneNumber[0]
        }
        
        // Configure the cell...

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    
    func getContacts() {
        
        if CNContactStore.authorizationStatus(for: .contacts) == .notDetermined {
            self.contactStore.requestAccess(for: .contacts, completionHandler: { (authorized: Bool, error: Error?) -> Void in
                if authorized {
                    self.readPhoneContact()
                }
                } as! (Bool, Error?) -> Void as! (Bool, Error?) -> Void)
        } else if CNContactStore.authorizationStatus(for: .contacts) == .authorized {
            self.readPhoneContact()
        }
    }
    
    func retrieveContactsWithStore() {
        do {
            let groups = try self.contactStore.groups(matching: nil)
            let predicate = CNContact.predicateForContactsInGroup(withIdentifier: groups[0].identifier)
            //let predicate = CNContact.predicateForContactsMatchingName("John")
            let keysToFetch = [CNContactFormatter.descriptorForRequiredKeys(for: .fullName), CNContactEmailAddressesKey, CNContactImageDataKey, CNContactThumbnailImageDataKey, CNContactPhoneNumbersKey] as [Any]
            
            let contacts = try self.contactStore.unifiedContacts(matching: predicate, keysToFetch: keysToFetch as! [CNKeyDescriptor])
            
            //self.objects = contacts
            DispatchQueue.main.async(){
                for contact in contacts
                {
                    let p = PhoneContact(contact: contact)
                    self.phoneContact.append(p)
                    
                }
                self.tableView.reloadData()
                print(self.phoneContact.count)
            }
            
        } catch {
            print(error)
        }
    }
    
    private func readPhoneContact()
    {
        var contacts = [CNContact]()
        let keys = [CNContactFormatter.descriptorForRequiredKeys(for: .fullName), CNContactEmailAddressesKey, CNContactImageDataKey, CNContactThumbnailImageDataKey, CNContactPhoneNumbersKey] as [Any]
        let request = CNContactFetchRequest(keysToFetch: keys as! [CNKeyDescriptor])
        
        do {
            try self.contactStore.enumerateContacts(with: request) {
                (contact, stop) in
                // Array containing all unified contacts from everywhere
                //contacts.append(contact)
                let p = PhoneContact(contact: contact)
                self.phoneContact.append(p)
                self.tableView.reloadData()
                //p.display()
                //print(contact.emailAddresses)
            }
        }
        catch {
            print("Unable to fetch contacts...")
        }
    }
    
}
