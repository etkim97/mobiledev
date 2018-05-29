//
//  AddItemViewController.swift
//  Hooville
//
//  Created by Elliott Kim on 4/15/18.
//  Copyright © 2018 Amanda Nguyen. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import MobileCoreServices
import FirebaseStorage

class AddItemViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {

    @IBOutlet weak var EventNameTextField: UITextField!
    @IBOutlet weak var EventName: UITextField!
    @IBOutlet weak var CityTextField: UITextField!
    @IBOutlet weak var AddressTextField: UITextField!
    @IBOutlet weak var StateTextField: UITextField!
    @IBOutlet weak var ZipCodeTextField: UITextField!
    @IBOutlet weak var DescriptionTextView: UITextView!
    
    @IBAction func Create(_ sender: Any) {
        
        if self.EventNameTextField.text == "" || self.AddressTextField.text == "" || self.DescriptionTextView.text == ""{
            
            //Alert to tell the user that there was an error because they didn't fill anything in the textfields because they didn't fill anything in
            
            let alertController = UIAlertController(title: "Required Fields", message: "Please enter an event name, address, and description.", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            self.present(alertController, animated: true, completion: nil)
            
        }else{
            let childRef = Database.database().reference(withPath: "Activities")
            let key = childRef.childByAutoId().key
            let event = ["ID":key,
                         "Name":EventNameTextField.text! as String,
                         "Address":AddressTextField.text! as String,
                         "City":CityTextField.text! as String,
                         "State":StateTextField.text! as String,
                         //"Zip Code":ZipCodeTextField.text! as! BinaryInteger,
                "Description":DescriptionTextView.text! as String
            ]
            childRef.child(key).setValue(event)
            
            
            let storageRef = Storage.storage().reference().child("\(key).jpg")
            if(imageView.image != nil){
                if let uploadData = UIImageJPEGRepresentation(imageView.image!, 0.5) {
                    //            storageRef.putData(uploadData, metadata: nil, completion: nil)
                    
                    storageRef.putData(uploadData).observe(.success) { (snapshot) in
                        // When the image has successfully uploaded, we get it's download URL
                        storageRef.downloadURL { url, error in
                            if let error = error {
                                // Handle any errors
                            } else {
                                childRef.child(key).child("url").setValue(url?.absoluteString)
                            }
                        }
                    }
                }
            }
        }
    }
    
    @IBOutlet weak var imageView: UIImageView!
    var newMedia: Bool?
    
    @IBAction func useCamera(_ sender: AnyObject) {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .camera
        imagePicker.delegate =  self
        self.present(imagePicker, animated: true, completion: nil)
        newMedia = true
    }
    
    @IBAction func useImageLibrary(_ sender: AnyObject) {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate =  self
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        var chosenimage = info[UIImagePickerControllerOriginalImage] as! UIImage
        imageView.image = chosenimage
        dismiss(animated:true, completion: nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.EventNameTextField.resignFirstResponder()
        self.CityTextField.resignFirstResponder()
        self.AddressTextField.resignFirstResponder()
        self.StateTextField.resignFirstResponder()
        self.ZipCodeTextField.resignFirstResponder()
        self.DescriptionTextView.resignFirstResponder()
        self.EventName.resignFirstResponder()
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        EventNameTextField.delegate = self
        CityTextField.delegate = self
        AddressTextField.delegate = self
        StateTextField.delegate = self
        ZipCodeTextField.delegate = self
        //DescriptionTextView.delegate = self
        EventName.delegate = self
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
