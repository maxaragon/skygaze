//
//  CameraCompassViewController.swift
//  skygazeapp
//
//  Created by Riyad Anabtawi on 14/10/22.
//

import UIKit
import AVFoundation
import SwiftUI
import CoreLocation


extension UIView {
    func addConstrained(subview: UIView) {
        addSubview(subview)
        subview.translatesAutoresizingMaskIntoConstraints = false
        subview.topAnchor.constraint(equalTo: topAnchor).isActive = true
        subview.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        subview.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        subview.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
}


class CameraCompassViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, AVCapturePhotoCaptureDelegate, AVCaptureMetadataOutputObjectsDelegate,CLLocationManagerDelegate,ReportViewControllerDelegate {

    var selected_string64:String!
  
    var lm:CLLocationManager!
    var currentLocation: CLLocation!
 

    var selected_image:UIImage!
    @IBOutlet private var previewView: UIView!
    @IBOutlet private var compassView: UIView!
    var input:AVCaptureDeviceInput!
    @IBOutlet private var addressLabel: UILabel!
    @IBOutlet private var latLabel: UILabel!
    @IBOutlet private var longLabel: UILabel!
    @IBOutlet private var altitudeLabel: UILabel!
    @IBOutlet private var timeLabel: UILabel!
    @IBOutlet private var dateLabel: UILabel!
    var compass_data:String!
    //Above the viewDidLoad method, where you create variables you want to be accessible anywhere in the ViewController file, create the following Instance Variables.
    
    var captureSession: AVCaptureSession!
    var stillImageOutput: AVCapturePhotoOutput!
    var videoPreviewLayer: AVCaptureVideoPreviewLayer!
    
    
    //Loc Manager to give us compass data
    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        
        
        
        
        self.compass_data = "\(round(newHeading.magneticHeading * 100) / 100.0)N"
    }
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    func callStartAll(){
        
        captureSession = AVCaptureSession()
        captureSession.sessionPreset = .medium
        
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm a" // "a" prints "pm" or "am"
        let hourString = formatter.string(from: Date()) // "12 AM"

        
        let formatter2 = DateFormatter()
        formatter2.dateFormat = "dd/MM/yyy" // "a" prints "pm" or "am"
        let dateString = formatter2.string(from: Date()) // "12 AM"

        if((UserDefaults.standard.object(forKey: "full_address_string")) != nil){
            self.addressLabel.text = (UserDefaults.standard.object(forKey: "full_address_string") as! String)
            
        }
        
     
        if (UserDefaults.standard.object(forKey: "altitude") != nil){
            let r = (UserDefaults.standard.object(forKey: "altitude")as!String).floatValue
            self.altitudeLabel.text = "Altitude: \(round(r * 100) / 100.0)m"
        }
  
        
        if (UserDefaults.standard.object(forKey: "latitude") != nil){
            let r11 = (UserDefaults.standard.object(forKey: "latitude")as!String).floatValue
            self.latLabel.text = "Lat: \(round(r11 * 100000) / 100000.0)"
        }
        
        
        if (UserDefaults.standard.object(forKey: "longitude") != nil){
            let r11 = (UserDefaults.standard.object(forKey: "longitude")as!String).floatValue
            self.longLabel.text = "Lat: \(round(r11 * 100000) / 100000.0)"
        }
        

        self.timeLabel.text = hourString
        self.dateLabel.text = dateString

  
        //We now need to make an AVCaptureDeviceInput. The AVCaptureDeviceInput will serve as the "middle man" to attach the input device, backCamera to the session.
        
      //  We will make a new AVCaptureDeviceInput and attempt to associate it with our backCamera input device.
       // There is a chance that the input device might not be available, so we will set up a try catch to handle any potential errors we might encounter. In Objective C, errors will be using the traditional NSError pattern. Still in viewDidAppear
                                                                                                        
        guard let backCamera = AVCaptureDevice.default(for: AVMediaType.video)
                
            else {
                print("Unable to access back camera!")
                return
        }
        
        do {
            self.input = try AVCaptureDeviceInput(device: backCamera)
            //Just like we created an AVCaptureDeviceInput to be the "middle man" to attach the input device, we will use AVCapturePhotoOutput to help us attach the output to the session.
            
            //If there are no errors from our last step and the session is able to accept input and output, the go ahead and add input add output to the Session.
            stillImageOutput = AVCapturePhotoOutput()

            if captureSession.canAddInput(input) && captureSession.canAddOutput(stillImageOutput) {
                captureSession.addInput(input)
                captureSession.addOutput(stillImageOutput)
                setupLivePreview()
            }
            
        }
        catch let error  {
            print("Error Unable to initialize back camera:  \(error.localizedDescription)")
        }
     
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
          print("error:: \(error.localizedDescription)")
     }

   
     func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {

         if locations.first != nil {
             let altitude = locations.first!.altitude
             UserDefaults.standard.setValue("\(altitude)", forKey: "altitude")
             UserDefaults.standard.synchronize()
             print("location:: (location)")
         }

     }
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            lm!.requestLocation()
        }
        switch status {
        case .notDetermined:
            manager.requestLocation()
        case .authorizedAlways, .authorizedWhenInUse:
            
            // Permission allowed, we update user location
            if self.currentLocation == nil{
                
                currentLocation = lm?.location
            }
            let centerLocation = CLLocationCoordinate2D(latitude: self.currentLocation.coordinate.latitude, longitude: self.currentLocation.coordinate.longitude)
         
            
            //Check if user is registered if not register it backend does this
            let uniq_val_device = UIDevice.current.identifierForVendor!.uuidString
            
            Services.registerUser(1, andUnique_va: uniq_val_device, andDeviceToken: uniq_val_device) { response in
                
                
                let user = response as! User
                UserDefaults.standard.setValue(user.user_id, forKey: "user_id")
                UserDefaults.standard.synchronize()
                
                
                //We update user lat long to server
                
             
                Services.updateUserLatLong(user.user_id, andLat: "\(self.currentLocation.coordinate.latitude)", andLongitude: "\(self.currentLocation.coordinate.longitude)") { [self] response in
                    
                    lm?.stopUpdatingLocation()
                } orErrorHandler: { err in
                    
                }
                
                
            } orErrorHandler: { err in
                
            }
            
           


            //Function to reverse geocode the lat and long to find address
            self.getAddressFromLatLon(pdblLatitude: "\(self.currentLocation.coordinate.latitude)", withLongitude: "\(self.currentLocation.coordinate.longitude)")
        default: break
            // Permission denied, do something else
        }
    }
    func getAddressFromLatLon(pdblLatitude: String, withLongitude pdblLongitude: String) {
            var center : CLLocationCoordinate2D = CLLocationCoordinate2D()
            let lat: Double = Double("\(pdblLatitude)")!
            //21.228124
            let lon: Double = Double("\(pdblLongitude)")!
            //72.833770
            let ceo: CLGeocoder = CLGeocoder()
            center.latitude = lat
            center.longitude = lon
       
            let loc: CLLocation = CLLocation(latitude:center.latitude, longitude: center.longitude)
        
        
        
        UserDefaults.standard.setValue("\(center.latitude)", forKey: "latitude")
        UserDefaults.standard.setValue("\(center.longitude)", forKey: "longitude")
        UserDefaults.standard.synchronize()

            ceo.reverseGeocodeLocation(loc, completionHandler:
                {(placemarks, error) in
                    if (error != nil)
                    {
                        print("reverse geodcode fail: \(error!.localizedDescription)")
                    }else{
                        let pm = placemarks! as [CLPlacemark]
                        
                        if pm.count > 0 {
                            let pm = placemarks![0]
                            print(pm.country as Any)
                            print(pm.locality as Any)
                            print(pm.subLocality as Any)
                            print(pm.thoroughfare as Any)
                            print(pm.postalCode as Any)
                            print(pm.subThoroughfare as Any)
                          
                            var addressString : String = ""
                            
                            
                            if pm.thoroughfare != nil {
                                UserDefaults.standard.setValue(pm.thoroughfare!, forKey: "Street")
                                addressString = addressString + pm.thoroughfare! + ", "
                            }
                            if pm.subLocality != nil {
                                UserDefaults.standard.setValue(pm.subLocality!, forKey: "District")
                                addressString = addressString + pm.subLocality! + ", "
                            }
                            
                            if pm.locality != nil {
                                UserDefaults.standard.setValue(pm.locality!, forKey: "Locality")
                                addressString = addressString + pm.locality! + ", "
                            }
                            if pm.administrativeArea != nil {
                                UserDefaults.standard.setValue(pm.administrativeArea!, forKey: "City")
                                addressString = addressString + pm.administrativeArea! + ", "
                            }
                            if pm.postalCode != nil {
                                UserDefaults.standard.setValue(pm.postalCode!, forKey: "Postal")
                                addressString = addressString + pm.postalCode! + " "
                            }
                            
                            //We save Adress full to send when creating report
                            UserDefaults.standard.setValue(addressString, forKey: "full_address_string")
                            
                            UserDefaults.standard.synchronize()
                            self.callStartAll()
                            
                            
                            
                        }
                    }
            })

        }

    
    //Now that the input and output are all hooked up with our session, we just need to get our Live Preview going so we can actually display what the camera sees on the screen in our UIView, previewView.
    
    //Create an AVCaptureVideoPreviewLayer and associate it with our session.
    //Configure the Layer to resize while maintaining it's original aspect.
    //Fix the orientation to portrait
    //Add the preview layer as a sublayer of our previewView
    //Finally, start the session!
    func setupLivePreview() {
        
        videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        
        videoPreviewLayer.videoGravity = .resizeAspect
        videoPreviewLayer.connection?.videoOrientation = .portrait
        previewView.layer.addSublayer(videoPreviewLayer)
        //We need to call -startRunning on the session to start the live view. However -startRunning is a blocking method which means it will block the UI if it's running on the main thread. If the session takes a while to start, users would want the UI to be responsive and cancel out of the camera view.
        
        //Once the live view starts let's set the Preview layer to fit, but we must return to the main thread to do so!
        
        videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession!)
        videoPreviewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
        videoPreviewLayer?.frame = view.layer.bounds
        self.previewView.layer.addSublayer(videoPreviewLayer!)


        
        self.captureSession.startRunning()
    }
    
    //Let's create an IBAction of the Take photo Button and capture a JPEG by calling our instance of AVCapturePhotoOutput or stillImageOut the method func capturePhoto(with:, delegate:) or -capturePhotoWithSettings:delegate:. This method requires us to provide it with a setting and a deleget to deliver the capturedPhoto to. This delegate will be this ViewController so we also need to conform to the protocol AVCapturePhotoCaptureDelegate
    @IBAction func didTakePhoto(_ sender: Any) {
           
           let settings = AVCapturePhotoSettings(format: [AVVideoCodecKey: AVVideoCodecType.jpeg])
           stillImageOutput.capturePhoto(with: settings, delegate: self)
        
       }
    
 
    //The AVCapturePhotoOutput will deliver the captured photo to the assigned delegate which is our current ViewController by a delegate method called photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?). The photo is delivered to us as an AVCapturePhoto which is easy to transform into Data/NSData and than into UIImage.
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        
        guard let imageData = photo.fileDataRepresentation()
            else { return }
        
        let image = UIImage(data: imageData)
        
        UIImageWriteToSavedPhotosAlbum(image!, nil, nil, nil)
       
        //self.captureSession.stopRunning()
        let strBase64 = imageData.base64EncodedString(options: .lineLength64Characters)
        print(strBase64)
        self.selected_image = image
        self.selected_string64 = strBase64
        
        self.performSegue(withIdentifier: "report", sender: self)
        
    }
    //Let's not forget to stop the session when we leave the camera view!
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if lm != nil{
            lm.stopUpdatingHeading()
    
          
        }
      //  self.captureSession.stopRunning()
    }
    
    

    
    override func viewDidAppear(_ animated: Bool) {
        
        //star loc manager to start updating comapss data
                lm = CLLocationManager()
                lm.delegate = self
                lm.startUpdatingLocation()
                lm.startUpdatingHeading()
        
        
               let childView = UIHostingController(rootView: ContentView())
               addChild(childView)
                childView.view.backgroundColor = UIColor.clear
               childView.view.frame = self.compassView.bounds
                self.compassView.addConstrained(subview: childView.view)
               childView.didMove(toParent: self)
        
        self.callStartAll()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func callPicAgain() {
        self.callStartAll()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "report"{
            
            
            let controller = segue.destination as! ReportViewController
            controller.delegate = self
            controller.selectedBase64String = self.selected_string64
            controller.selectedd_image = self.selected_image
            controller.compass_data = self.compass_data
            
          
        }
    }

}
