//
//  ReportViewController.swift
//  skygazeapp
//
//  Created by Riyad Anabtawi on 14/10/22.
//

import UIKit
protocol ReportViewControllerDelegate{
   func callPicAgain()

}

class ReportViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {

    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! IconCollectionViewCell
        
        
        cell.showIcon(icon: self.array_icons[indexPath.row])
        
        return cell
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.array_icons.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.iconsCollectionView.frame.size.width/4, height: self.iconsCollectionView.frame.size.height-10)
    }
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
      
        
        self.selected_icon = self.array_icons[indexPath.row]
    }
    
    @IBOutlet private var scrollview: UIScrollView!
    @IBOutlet private var widthConstant: NSLayoutConstraint!
    @IBOutlet private var heightConstant: NSLayoutConstraint!
    @IBOutlet private var labelSunny: UILabel!
    @IBOutlet private var sendButton: UIButton!
    var delegate: ReportViewControllerDelegate?
    var compass_data:String!
    var selectedIcon:String!
    var selectedd_image:UIImage!
    var selectedBase64String:String!
    @IBOutlet private var labelfewClouds: UILabel!
    @IBOutlet private var labelCloudy: UILabel!
    var selected_icon:Weathericon!
    var selected_comment:String! = ""
    @IBOutlet private var selectedPicViewHeight: NSLayoutConstraint!
    @IBOutlet private var selectedImagesssHeight: NSLayoutConstraint!
    @IBOutlet private var selectedImageView: UIImageView!
    @IBOutlet private var selectedComment: UILabel!
    @IBOutlet private var iconsCollectionView: UICollectionView!
    var array_icons:[Weathericon] = []
  
    
    override func viewDidAppear(_ animated: Bool) {
        UIView.animate(withDuration: 0.4, delay: 0.2) {
            self.selectedPicViewHeight.constant = 500
            self.selectedImagesssHeight.constant = 300
            self.view.layoutIfNeeded()
            self.selectedImageView.image = self.selectedd_image
            if UserDefaults.standard.objectIsForced(forKey: "selected_comment"){
                self.selectedComment.text = UserDefaults.standard.objectIsForced(forKey: "selected_comment") as! String
                
            }else{
                
                self.selectedComment.text = "No comment entered yet"
                
            }
            
        }
        
        Services.getWeathericonsWithHandler { res in
            
            self.array_icons = res as! [Weathericon]
            
            let last_weathericon = Weathericon()
            last_weathericon.name = "Other"
            last_weathericon.icon_id = 0
            last_weathericon.icon_url = ""
            
            self.array_icons.append(last_weathericon)
            
            self.iconsCollectionView.reloadData()
        } orErrorHandler: { err in
            
        }

    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        self.sendButton.layer.cornerRadius = 10
        self.sendButton.layer.borderColor = UIColor.white.cgColor
        self.sendButton.layer.borderWidth = 1
        self.sendButton.layer.masksToBounds = true
        
        self.selectedPicViewHeight.constant = 0
        self.selectedImagesssHeight.constant = 0
        self.view.layoutIfNeeded()
        
        self.widthConstant.constant = self.view.frame.size.width;
        self.heightConstant.constant = self.view.frame.size.height + 300
        self.view.layoutIfNeeded()
        // Do any additional setup after loading the view.
    }
    
   
    

    
    
    //Action to go to cameraView
    @IBAction func takePicture() {
        
        
    
        self.dismiss(animated: true, completion: {
            self.delegate!.callPicAgain()
             })
        
    }
    
    
    //Action to write a comment
    @IBAction func writeComment() {
     
        
        let alertController = UIAlertController(title: "Write a Comment", message: "", preferredStyle: UIAlertController.Style.alert)
        alertController.addTextField { (textField : UITextField!) -> Void in
              textField.placeholder = "Enter your comment"
          }
        let saveAction = UIAlertAction(title: "Save", style: UIAlertAction.Style.default, handler: { alert -> Void in
              let firstTextField = alertController.textFields![0] as UITextField
            
            self.selected_comment = firstTextField.text
            self.selectedComment.text = self.selected_comment
            
           
          })
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: {
              (action : UIAlertAction!) -> Void in })
    
          alertController.addAction(saveAction)
          alertController.addAction(cancelAction)
          
        self.present(alertController, animated: true, completion: nil)
        
        
    }

    
    
    @IBAction func sendReportTI() {
        
        let user_id = UserDefaults.standard.object(forKey: "user_id")as! NSNumber
        if(self.selected_icon != nil){
            
            if (self.selected_icon.icon_id == 0 && self.selected_comment == ""){
                
                let alert = UIAlertController(title: "Atention", message: "As you selected other icon, comment is mandatory", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                
                }))
                
          
                self.present(alert, animated: true, completion: nil)
                
            }else{
                
                Services.uploadImage(byUser: user_id, andLatitude: "\(UserDefaults.standard.object(forKey: "latitude")!)", andLogitude: "\(UserDefaults.standard.object(forKey: "longitude")!)", andBase64String: self.selectedBase64String, andCompasData: self.compass_data, andAltitude: "\(UserDefaults.standard.object(forKey: "altitude")!)m", andAddress: (UserDefaults.standard.object(forKey: "full_address_string") as! String), andIcon: self.selected_icon.icon_id, andComment: self.selected_comment) { response in
                    
                    let alert = UIAlertController(title: "Atention", message: "Report uploaded correctly", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                        self.dismiss(animated: true, completion: {
                            self.delegate!.callPicAgain()
                            self.tabBarController?.selectedIndex = 1
                             })
                    }))
                    
              
                    self.present(alert, animated: true, completion: nil)
                    
                
                    
                } orErrorHandler: { err in
                    
                    
                    
                }

                
            }
            
           
            
        }else{
            let alert = UIAlertController(title: "Atention", message: "You must select an icon first", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
               
            }))
            
      
            self.present(alert, animated: true, completion: nil)
            
        }
      
        
        
        
    }
    
    
    

}
