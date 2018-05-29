//
//  CreateAccountViewController.swift
//  Hooville
//
//  Created by Amanda Nguyen on 4/24/18.
//  Copyright © 2018 Amanda Nguyen. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class CreateAccountViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var EmailTextField: UITextField!
    
    @IBOutlet weak var UsernameTextField: UITextField!
    
    @IBOutlet weak var PasswordTextField: UITextField!
    
    @IBAction func createAccountAction(_ sender: Any) {
        if EmailTextField.text == "" {
            let alertController = UIAlertController(title: "Error", message: "Please enter your email and password", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            present(alertController, animated: true, completion: nil)
            
        } else {
            Auth.auth().createUser(withEmail: EmailTextField.text!, password: PasswordTextField.text!) { (user, error) in
                
                if error == nil {
                    print("You have successfully signed up")
                    
                    //Adds username to database
                    let childRef = Database.database().reference(withPath: "Users")
                    let userData = ["Username": self.UsernameTextField.text]
                    childRef.child(user!.uid).setValue(userData)
                    
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "MainTable")
                    self.present(vc!, animated: true, completion: nil)
                    
                } else {
                    let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                    
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(defaultAction)
                    
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.EmailTextField.resignFirstResponder()
        self.PasswordTextField.resignFirstResponder()
        self.UsernameTextField.resignFirstResponder()
        return true
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        EmailTextField.delegate = self
        UsernameTextField.delegate = self
        PasswordTextField.delegate = self
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
