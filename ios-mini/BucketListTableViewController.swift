//
//  BucketListTableViewController.swift
//  Bucket List
//
//  Created by sherriff on 9/15/16.
//  Copyright © 2016 Mark Sherriff. All rights reserved.
//

import UIKit

class BucketListTableViewController: UITableViewController {
    
    //MARK: Properties - Notes
    var nameText:String = ""
    var longText:String = ""
    var latText:String = ""
    var descText:String = ""
    var dateText:Date = Date()
    
    var bucketItems = [BucketItem]()
    
    func loadSampleItems() {
        //let item1 = BucketItem(name: "My Awesomeness", date: Date(), noteText: "Here is some stuff!")
        //bucketItems += [item1]
        //let item2 = BucketItem(name: "More Notes!", date: Date(), noteText: "Here is some stuff!")
        //bucketItems += [item2]
        
        let bucketitem1 = BucketItem(name: "Go hiking", date: Date(), description: "hike", longitude: "10", latitude: "10", complete: false)
        bucketItems += [bucketitem1]
        let bucketitem2 = BucketItem(name: "Go biking", date: Date(), description: "bike", longitude: "15", latitude: "15", complete: false)
        bucketItems += [bucketitem2]
        let bucketitem3 = BucketItem(name: "Go spiking", date: Date(), description: "spike", longitude: "20", latitude: "20", complete: false)
        bucketItems += [bucketitem3]
    }
    
    @IBAction func saveText(segue: UIStoryboardSegue) {
        
        if let sourceVC = segue.source as? AddItemViewController,
            let nameText = sourceVC.nameTextField.text,
            let latText = sourceVC.latitudeTextField.text,
            let longText = sourceVC.longitudeTextField.text,
            let descText = sourceVC.descriptionTextField.text,
            let dateText = sourceVC.dateField {
            
            let b = BucketItem(name: nameText, date: dateText.date, description: descText, longitude: longText, latitude: latText, complete: false)
            bucketItems += [b]
            self.tableView.beginUpdates()
            self.tableView.insertRows(at: [IndexPath.init(row: self.bucketItems.count-1, section: 0)], with: .automatic)
            self.tableView.endUpdates()
        }
    }
    
    @IBAction func editText(segue: UIStoryboardSegue){
        if let sourceVC = segue.source as? EditItemViewController,
            let index = sourceVC.cellIndex as? Int,
            let nameText = sourceVC.nameTextField.text,
            let latText = sourceVC.latitudeTextField.text,
            let longText = sourceVC.longitudeTextField.text,
            let descText = sourceVC.descriptionTextField.text,
            let dateText = sourceVC.dateField {
            bucketItems[index].setName(n: nameText)
            bucketItems[index].setLatitude(l: latText)
            bucketItems[index].setLongitude(l: longText)
            bucketItems[index].setDescription(d: descText)
            bucketItems[index].setDate(d: dateText.date)
            let indexPath = IndexPath(item: index, section: 0)
            self.orderTable()
            tableView.reloadRows(at: [indexPath], with: .top)
        }
    }
    
    //MARK: Button Actions

    @IBAction func addButton(_ sender: UIBarButtonItem) {
        let alertController = UIAlertController(title: "Code for you to write!", message: "You can add code here to open a new ViewController to add a new note!", preferredStyle: .alert)
        
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(defaultAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    
    //MARK: Basic ViewController Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadSampleItems()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: TableView Functions

    
    func orderTable() {
        bucketItems.sort(by: {$0.date < $1.date})
        bucketItems.sort(by: {!$0.complete && $1.complete})
        tableView.reloadData()
    }
    
    // Override to show how many lists there should be
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    // Override to show how many notes are in the list
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bucketItems.count
    }

    // Override to show what each cell should have in it based on the note in the list
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "NoteTableViewCell"
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! BucketListTableViewCell
        
        // Fetches the appropriate note for the data source layout.
        let item = bucketItems[indexPath.row]

        cell.itemNameLabel.text = item.name
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        let convertedDate = dateFormatter.string(from: item.date)
        cell.dateLabel.text = convertedDate
        
        if item.complete {
            cell.backgroundColor = UIColor.lightGray
        }
        else{
            cell.backgroundColor = UIColor.white
        }
        
        return cell
    }
    
    // Override to support tapping on an element in the table view.
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let index = indexPath[1]
        let currentItem = bucketItems[index]
        let alertController = UIAlertController(title: currentItem.name, message: currentItem.description + "\nsaved at: " + currentItem.date.description + String(currentItem.complete), preferredStyle: .alert)
        
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(defaultAction)
        
        present(alertController, animated: true, completion: nil)
        
    }
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
//    // Override to support editing the table view if you wanted just a delete button
//    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
//        
//        if editingStyle == .delete {
//            // Delete the row from the data source
//            notes.remove(at: indexPath.row)
//            // Delete the row from the view
//            tableView.deleteRows(at: [indexPath], with: .fade)
//        } else if editingStyle == .insert {
//            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
//        }    
//    }
    
    // Lets you add various buttons when you swipe
    override func tableView(_ tableView: UITableView, editActionsForRowAt: IndexPath) -> [UITableViewRowAction]? {
        let done = UITableViewRowAction(style: .normal, title: "Done") { action, index in
            let temp = self.bucketItems[index.row]
            let currentStatus = temp.complete
            temp.complete = !currentStatus
            self.orderTable()
            
            /*
             cell?.backgroundColor = UIColor.lightGray
             if(temp){
             cell?.backgroundColor = UIColor.lightGray
             }
             else{
             cell?.backgroundColor = UIColor.white
             */
        }
        done.backgroundColor = .green
        
        let edit = UITableViewRowAction(style: .normal, title: "Edit") { action, index in
            let cell = tableView.cellForRow(at: index)
            cell?.tag = index.row
            self.performSegue(withIdentifier: "EditItemSegue", sender: cell)
            
        }
        edit.backgroundColor = .orange
        
        
        return [done, edit]
    }

    

    
    // MARK: Segue

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if (segue.identifier == "EditItemSegue"){
            guard let cell = sender as? UITableViewCell else {
                return
            }
            let destinationVC = segue.destination as! UINavigationController
            let targetController = destinationVC.topViewController as! EditItemViewController
            
            targetController.nameText = bucketItems[cell.tag].name
            targetController.longitudeText = bucketItems[cell.tag].longitude
            targetController.latitudeText = bucketItems[cell.tag].latitude
            targetController.descriptionText = bucketItems[cell.tag].description
            targetController.dateText = bucketItems[cell.tag].date
            targetController.cellIndex = cell.tag
        }
    }
    
   
}
