//
//  EditItemViewController.swift
//  Bucket List
//
//  Created by Amanda Nguyen on 2/18/18.
//  Copyright © 2018 kimnguyen. All rights reserved.
//

import UIKit

class EditItemViewController: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var longitudeTextField: UITextField!
    
    @IBOutlet weak var latitudeTextField: UITextField!
    
    @IBOutlet weak var descriptionTextField: UITextField!
    
    @IBOutlet weak var dateField: UIDatePicker!
    
    var nameText:String = ""
    var longitudeText:String = ""
    var latitudeText:String = ""
    var descriptionText:String = ""
    var dateText:Date = Date()
    var cellIndex:Int = 0
    
    @IBAction func cancelEdit(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        longitudeTextField.delegate = self
        latitudeTextField.delegate = self
        nameTextField.text = nameText
        longitudeTextField.text = longitudeText
        latitudeTextField.text = latitudeText
        descriptionTextField.text = descriptionText
        dateField.date = dateText
        
        // Do any additional setup after loading the view.
    }

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
