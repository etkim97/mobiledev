//
//  AddItemViewController.swift
//  Bucket List
//
//  Created by Amanda Nguyen on 2/17/18.
//  Copyright © 2018 kimnguyen. All rights reserved.
//

import UIKit

class AddItemViewController: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var longitudeTextField: UITextField!
    @IBOutlet weak var latitudeTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var dateField: UIDatePicker!
    
    @IBAction func cancelAdd(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    /*func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        let allowedCharacters = CharacterSet.decimalDigits
        let characterSet = CharacterSet(charactersIn: string)
        return allowedCharacters.isSuperset(of: characterSet)
    }*/
    //http://www.go4.ninja/2015/04/Swift-iOS-UITextField-Numbers-Only.html
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let inverseSet = NSCharacterSet(charactersIn:"0123456789").inverted
        
        let components = string.components(separatedBy: inverseSet)
        
        let filtered = components.joined(separator: "")
        
        if filtered == string {
            return true
        } else {
            if string == "." {
                let countdots = textField.text!.components(separatedBy:".").count - 1
                if countdots == 0 {
                    return true
                }else{
                    if countdots > 0 && string == "." {
                        return false
                    } else {
                        return true
                    }
                }
            }else{
                return false
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "unwindAddItem") {
            
            let destVC = segue.destination as! UINavigationController
            let targVC = destVC.topViewController as! BucketListTableViewController
            
            targVC.nameText = nameTextField.text!
            targVC.longText = longitudeTextField.text!
            targVC.latText = latitudeTextField.text!
            targVC.descText = descriptionTextField.text!
            targVC.dateText = dateField.date
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        longitudeTextField.delegate = self
        latitudeTextField.delegate = self

        // Do any additional setup after loading the view.
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
