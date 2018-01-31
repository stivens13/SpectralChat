//
//  SignUpVC.swift
//  SpeactralChatProto
//
//  Created by Nikita Voloshenko on 12/20/17.
//  Copyright © 2017 Nikita Voloshenko. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import SwiftKeychainWrapper

class SignUpVC: UIViewController {
    
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var passwordRepeatTF: UITextField!
    var currentUser: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func signUp(_ sender: Any) {
        
        if email.text == "" && passwordTF.text == "" {
            let alert = UIAlertController(title: "Error", message: "Please enter valid account credentials", preferredStyle: .alert)
            let action = UIAlertAction(title: "ok", style: .cancel, handler: nil)
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
            //if not empty, then check the credentials
        } else if passwordTF.text != passwordRepeatTF.text! {
            
            let alert = UIAlertController(title: "Error", message: "Wah, passwords do not match, try again", preferredStyle: .alert)
            let action = UIAlertAction(title: "ok", style: .cancel, handler: nil)
            alert.addAction(action)
            present(alert, animated: true, completion: nil)

        } else {
            
            Auth.auth().createUser(withEmail: email.text!, password: passwordTF.text!) {
                (user,error) in
                if error == nil {
                    let email = self.email.text!
                    print("SignUp Successful")
                    
                    guard let uid = user?.uid else {
                        return
                    }
                    let user = User(uid: (Auth.auth().currentUser?.uid)!,username: (Auth.auth().currentUser?.email)!)
                    User.setCurrent(user)
                    let ref = Database.database().reference(fromURL: "https://ios-spectral.firebaseio.com/")
                    
                    let values = ["email": email,
                                  "name": self.userName.text!]
                    //store the user information under a unique id that is assigned by firebase.
                    let usersReference = ref.child("users").child(uid)
                    usersReference.updateChildValues(values, withCompletionBlock: {(err, ref) in
                        if err != nil {
                            print(err!)
                            return
                        }
                        
                        print("success")
                    })
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "Messages")
                    self.present(vc!,animated:true, completion: nil)
                } else {
                    let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                    let action = UIAlertAction(title: "Success", style: .cancel, handler: nil)
                    alert.addAction(action)
                    self.present(alert,animated: true, completion: nil)
                }
                
            }
            
        }
        
        
        
        
        
//        if usernameTF.text == "" && passwordTF.text == "" {
//            let alert = UIAlertController(title: "Error", message: "Please enter valid account credentials", preferredStyle: .alert)
//            let action = UIAlertAction(title: "ok", style: .cancel, handler: nil)
//            alert.addAction(action)
//            present(alert, animated: true, completion: nil)
//            //if not empty, then check the credentials
//        } else if passwordTF.text != passwordRepeatTF.text! {
//
//            let alert = UIAlertController(title: "Error", message: "Wah, passwords do not match, try again", preferredStyle: .alert)
//            let action = UIAlertAction(title: "ok", style: .cancel, handler: nil)
//            alert.addAction(action)
//            present(alert, animated: true, completion: nil)
//
//        } else {
//            //FIRAuth has been renamed to Auth
//
//            var ref: DatabaseReference!
//            ref = Database.database().reference()
//
//            Auth.auth().createUser(withEmail: usernameTF.text!, password: passwordTF.text!) {
//                (user,error) in
//                if error == nil {
//                    print("SignUp Successful")
//                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "Messages")
//                    self.present(vc!,animated:true, completion: nil)
//                    //                    var uid = user?.uid
//                    ref.child("users/\(user?.uid)/email").setValue(self.usernameTF)
//                    ref.child("users/\(user?.uid)/conversations/default").setValue("default")
//                } else {
//                    let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
//                    let action = UIAlertAction(title: "Accept", style: .cancel, handler: nil)
//                    alert.addAction(action)
//                    self.present(alert,animated: true, completion: nil)
//                }
//
//            }
        
            //            currentUser = KeychainWrapper.standard.string(forKey: "uid")
            
            
            
            
//        }
        
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
