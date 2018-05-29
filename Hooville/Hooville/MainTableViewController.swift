//
//  MainTableViewController.swift
//  Hooville
//
//  Created by Elliott Kim on 4/16/18.
//  Copyright © 2018 Amanda Nguyen. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class MainTableViewController: UITableViewController {
    // Properties - Events
    var nameText:String = ""
    
    var eventItems = [eventItem]()
    
    func loadSampleItems() {
        //let item1 = BucketItem(name: "My Awesomeness", date: Date(), noteText: "Here is some stuff!")
        //bucketItems += [item1]
        //let item2 = BucketItem(name: "More Notes!", date: Date(), noteText: "Here is some stuff!")
        //bucketItems += [item2]
        let eventitem1 = eventItem(name: "Go hiking")
        eventItems += [eventitem1]
        let eventitem2 = eventItem(name: "Go biking")
        eventItems += [eventitem2]
        let eventitem3 = eventItem(name: "Go piking")
        eventItems += [eventitem3]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let ref = Database.database().reference(withPath: "Activities")
        ref.observe(.value, with: { snapshot in
            //print(snapshot.value ?? "false")
        })
        
        ref.observe(.value, with: { snapshot in
            var newItems: [eventItem] = []
            for item in snapshot.children {
                let event = eventItem(snapshot: item as! DataSnapshot)
                newItems.append(event)
            }
            self.eventItems = newItems
            self.tableView.reloadData()
        })

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Table Functions
    
    // Override to show how many lists there should be
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // Override to show how many notes are in the list
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventItems.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toItemInfo", sender: indexPath)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "toItemInfo") {
            var vc = segue.destination as! ItemViewController
            let indexPath = sender as! NSIndexPath
            vc.iden = eventItems[indexPath.row].ID
        }
    }
    
    // Override to show what each cell should have in it based on the note in the list
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "MainTableViewCell"
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! MainTableViewCell
        
        // Fetches the appropriate note for the data source layout.
        let item = eventItems[indexPath.row]
        cell.itemNameLabel.text = item.name
        cell.itemAddressLabel.text = item.address

        return cell
    }
}
