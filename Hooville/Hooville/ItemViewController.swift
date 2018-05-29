//
//  ItemViewController.swift
//  Hooville
//
//  Created by Amanda Nguyen on 4/25/18.
//  Copyright © 2018 Amanda Nguyen. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseStorage

class ItemViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    
    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var IDtext:UILabel!
    var iden = " "
    var reviewItems = [review]()
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self

        let ref = Database.database().reference(withPath: "Activities")
        //print("here")
        //print(iden)
        let ref2 = ref.child(iden)
        ref2.observe(.value, with: { snapshot in
            if let dict = snapshot.value as? [String:Any] {
                //print(snapshot.value)
                //Do not cast print it directly may be score is Int not string
                self.titleLabel.text = ((dict["Name"] ?? "Title") as! String)
                self.descLabel.text = ((dict["Description"] ?? "This is the desc.") as! String)
                self.addressLabel.text = ((dict["Address"] ?? "Address") as! String)
            }
        })
        
        ref2.child("url").observe(.value, with: { (snapshot) in
            if let downloadURL = snapshot.value as? String{
                let storageRef = Storage.storage().reference(forURL: downloadURL)
                // Create a storage reference from the URL
                // Download the data, assuming a max size of 1MB (you can change this as necessary)
                storageRef.getData(maxSize: 3 * 1024 * 1024) { (data, error) -> Void in
                // Create a UIImage, add it to the array
                let pic = UIImage(data: data!)
                self.itemImage.image = pic
                print("photo")
                }
            }
        })
        
        let childref = ref.child(iden).child("Reviews")
        childref.observe(.value, with: { snapshot in
            var newItems: [review] = []
            for item in snapshot.children {
                print(snapshot.value ?? "false")
                //let event = eventItem(snapshot: item as! DataSnapshot)
                let rev = review(snapshot: item as! DataSnapshot)
                newItems.append(rev)
            }
            self.reviewItems = newItems
            self.tableView.reloadData()
        })
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "submit") {
            var vc = segue.destination as! WriteReviewViewController
            vc.eventID = iden
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reviewItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReviewsViewCell", for: indexPath) as! ItemTableViewCell

        let item = reviewItems[indexPath.row]
        cell.userLabel.text = item.username
        cell.reviewLabel.text = item.review
        
        return cell
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
