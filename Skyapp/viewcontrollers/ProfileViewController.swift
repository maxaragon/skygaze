//
//  ProfileViewController.swift
//  Skyapp
//
//  Created by Riyad Faek Anabtawi Rojas on 20/10/22.
//

import UIKit

class ProfileViewController: UIViewController,UITextFieldDelegate {

    @IBOutlet private var nameTextField: UITextField!
    @IBOutlet private var emailTextField: UITextField!
    @IBOutlet private var updateInformationButton: UIButton!
    @IBOutlet private var seeFormerReportsButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.updateInformationButton.layer.cornerRadius = 10
        self.updateInformationButton.layer.borderColor = UIColor.white.cgColor
        self.updateInformationButton.layer.borderWidth = 1
        self.updateInformationButton.layer.masksToBounds = true
        
        self.seeFormerReportsButton.layer.cornerRadius = 10
        self.seeFormerReportsButton.layer.borderColor = UIColor.white.cgColor
        self.seeFormerReportsButton.layer.borderWidth = 1
        self.seeFormerReportsButton.layer.masksToBounds = true
        
        self.getUserData()
        
       

        // Do any additional setup after loading the view.
    }
    
    func getUserData(){
        
        Services.getUserInfo((UserDefaults.standard.object(forKey: "user_id") as! NSNumber)) { res in
            
            let user = res as! User
            if(user.email != nil){
                self.emailTextField.text = user.email!
            }
            
            if(user.name != nil){
                self.nameTextField.text = user.name!
            }
           
        } orErrorHandler: { err in
            
        }

    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {   //delegate method
       textField.resignFirstResponder()
       return true
    }
    
    @IBAction func updateInfo() {
       
        
        Services.updateUserInfo((UserDefaults.standard.object(forKey: "user_id") as! NSNumber), andName: self.nameTextField.text!, andEmail: self.emailTextField.text!) { res in
            
            self.emailTextField.resignFirstResponder()
            self.nameTextField.resignFirstResponder()
            let alertController = UIAlertController(title: "Atention", message: "Personal information updated correctly", preferredStyle: UIAlertController.Style.alert)
    
            let saveAction = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: { alert -> Void in
                
                self.getUserData()
               
              })
       
        
              alertController.addAction(saveAction)
      
              
            self.present(alertController, animated: true, completion: nil)
            
       
        } orErrorHandler: { err in
            
        }

        
    }
    
    @IBAction func seeReports() {
        self.performSegue(withIdentifier: "reports", sender: self)
        
    }
    
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
