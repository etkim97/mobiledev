//
//  WriteReviewViewController.swift
//  Hooville
//
//  Created by Amanda Nguyen on 4/26/18.
//  Copyright © 2018 Amanda Nguyen. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class WriteReviewViewController: UIViewController, UITextViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    var eventID:String = ""
    @IBOutlet weak var reviewTextView: UITextView!
    @IBAction func SubmitReview(_ sender: Any) {
        let ID = UserDefaults.standard.string(forKey: "userID")
        let ref = Database.database().reference()
        var username = "tempuser"
        ref.child("Users").child(ID!).observe(.value, with: { (snapshot) in
            if let dict = snapshot.value as? [String:String] {
                print(dict["Username"])
                username = dict["Username"]! as String
                let review = ["Review":self.reviewTextView.text! as String,
                              "Username":username as String
                ]
                ref.child("Activities").child(self.eventID).child("Reviews").child(username).setValue(review)
            }
        })
        
        
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if (text as NSString).rangeOfCharacter(from: CharacterSet.newlines).location == NSNotFound {
            return true
        }
    
        self.reviewTextView.resignFirstResponder()
        return false
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
