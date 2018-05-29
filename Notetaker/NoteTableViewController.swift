//
//  NoteTableViewController.swift
//  Note Taker
//
//  Created by sherriff on 9/15/16.
//  Copyright © 2016 Mark Sherriff. All rights reserved.
//

import UIKit

class NoteTableViewController: UITableViewController {
    
    //MARK: Properties - Notes
    
   
    var notes = [Note]()
    
    func loadSampleNotes() {
        let note1 = Note(name: "My Awesomeness", date: Date(), noteText: "Here is some stuff!")
        notes += [note1]
        let note2 = Note(name: "More Notes!", date: Date(), noteText: "Here is some stuff!")
        notes += [note2]
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
        
        loadSampleNotes()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: TableView Functions

    // Override to show how many lists there should be
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    // Override to show how many notes are in the list
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }

    // Override to show what each cell should have in it based on the note in the list
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "NoteTableViewCell"
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! NoteTableViewCell
        
        // Fetches the appropriate note for the data source layout.
        let note = notes[indexPath.row]

        cell.noteNameLabel.text = note.name
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        let convertedDate = dateFormatter.string(from: note.date)
        cell.dateLabel.text = convertedDate

        return cell
    }
    
    // Override to support tapping on an element in the table view.
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let index = indexPath[1]
        let currentNote = notes[index]
        let alertController = UIAlertController(title: currentNote.name, message: currentNote.noteText + "\nsaved at: " + currentNote.date.description, preferredStyle: .alert)
        
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
            
            
        }
        done.backgroundColor = .green
        
        let edit = UITableViewRowAction(style: .normal, title: "Edit") { action, index in
            
            
        }
        edit.backgroundColor = .orange
        
        
        return [done, edit]
    }

    

    
    // MARK: Segue

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    
   
}
