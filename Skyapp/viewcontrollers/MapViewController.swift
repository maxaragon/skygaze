//
//  MapViewController.swift
//  skygazeapp
//
//  Created by Riyad Anabtawi on 14/10/22.
//

import UIKit
import MapKit
import SDWebImage
extension String {
    var floatValue: Float {
        return (self as NSString).floatValue
    }
}
class MyPointAnnotation: MKPointAnnotation {
    var imageName: String = ""
    var imageReport: String = ""
    var imnageComment: String = ""
}

class MapViewController: UIViewController,MKMapViewDelegate,CLLocationManagerDelegate {
    var selectedAnnotation:MyPointAnnotation!
    //outlet object for map view
    @IBOutlet private var mapView: MKMapView!
    @IBOutlet private var infoViewReport: UIView!
    @IBOutlet private var infoReportImage: UIImageView!
    @IBOutlet private var infoReportComment: UILabel!
    //Variable for location manager, where we will get the lat and long
    var locationManager: CLLocationManager?
    var currentLocation: CLLocation!
    
    override func viewDidAppear(_ anmated: Bool) {
        //initialize location manager, will ask for user permission to start updating location
        

        
        if(locationManager == nil){
            
            locationManager = CLLocationManager()
            locationManager?.delegate = self
        }
        locationManager?.distanceFilter = kCLDistanceFilterNone
        locationManager?.desiredAccuracy = kCLLocationAccuracyBest
        locationManager?.requestAlwaysAuthorization()
 
        if
           CLLocationManager.authorizationStatus() == .authorizedWhenInUse ||
           CLLocationManager.authorizationStatus() ==  .authorizedAlways
        {
            currentLocation = locationManager?.location
        }
        
        locationManager?.startUpdatingHeading()
        locationManager?.startUpdatingLocation()
       
        
        
        Services.getAllImages { [self] res in
            
            let arrayImages = res as! [Report]
          
            for dict in arrayImages {
                
                let annotation = MyPointAnnotation()
                annotation.coordinate.latitude = CLLocationDegrees(dict.latitude.floatValue)
                annotation.coordinate.longitude = CLLocationDegrees(dict.longitude.floatValue)
                annotation.title = "Report"
                annotation.subtitle = dict.address
                annotation.imageReport = dict.picture_url
                annotation.imnageComment = dict.comment
                annotation.imageName = dict.icon_url
               
                self.mapView.addAnnotation(annotation)
            }
            
        } orErrorHandler: { err in
            
            
        }

        

    }
    

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            return nil
        }

        let reuseId = "image"
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId)
        

    
        
        
        
        if pinView == nil {
            pinView = MKAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView?.canShowCallout = true
            let annotation = annotation as! MyPointAnnotation
            let imageViewProvisional = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
            imageViewProvisional.sd_setImage(with: NSURL(string: "https:" + annotation.imageName) as URL?) { (image, error, cache, urls) in
                            if (error != nil) {
                                // Failed to load image
                                pinView!.image = UIImage(named: "ico_placeholder")
                            } else {
                                // Successful in loading image
                                pinView!.image = image
                            }
                        }
  

            let rightButton: AnyObject! = UIButton(type: UIButton.ButtonType.detailDisclosure)
            rightButton.addTarget(self, action: #selector(MapViewController.info(sender:)), for:UIControl.Event.touchUpInside)
            pinView?.rightCalloutAccessoryView = rightButton as? UIView
        }
        else {
            pinView?.annotation = annotation
        }

        return pinView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.infoViewReport.alpha = 0
        self.mapView.showsUserLocation = true
        self.mapView.mapType = MKMapType.standard
        self.mapView.delegate = self
        
        
   
        
        
        
        self.infoViewReport.layer.cornerRadius = 10
        self.infoViewReport.layer.masksToBounds = true
        //We add gesture to move point location in map
      //  let tapGesture = UITapGestureRecognizer(target: self, action: #selector(mapViewTapped))
       // mapView.addGestureRecognizer(tapGesture)
        
       
           
      

        // Do any additional setup after loading the view.
    }
    
    //Loc Manager to give us compass data
 
    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        print("lllll\(newHeading.magneticHeading)")
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
                            
                            
                        }
                    }
            })

        }
    
    //MapKit Delegate methods to obtain information from map and drop pin
    func mapView(mapView: MKMapView, annotationView view: MKAnnotationView, didChangeDragState newState: MKAnnotationView.DragState, fromOldState oldState: MKAnnotationView.DragState) {
        if newState == MKAnnotationView.DragState.ending {
            let droppedAt = view.annotation?.coordinate
            print(droppedAt)
        }
    }
    
    
  

    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, didChange newState: MKAnnotationView.DragState, fromOldState oldState: MKAnnotationView.DragState) {
            switch newState {
            case .starting:
                view.dragState = .dragging
            case .ending, .canceling:
                view.dragState = .none
            default: break
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
    
    override func viewDidDisappear(_ animated: Bool) {
        if locationManager != nil{
            locationManager?.stopUpdatingHeading()
            locationManager?.stopUpdatingLocation()
        }
        
    }
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            locationManager!.requestLocation()
        }
        switch status {
        case .notDetermined:
            manager.requestLocation()
        case .authorizedAlways, .authorizedWhenInUse:
            
            // Permission allowed, we update user location
            if self.currentLocation == nil{
                
                currentLocation = locationManager?.location
            }
            let centerLocation = CLLocationCoordinate2D(latitude: self.currentLocation.coordinate.latitude, longitude: self.currentLocation.coordinate.longitude)
            let mapspan = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
            let mapregion = MKCoordinateRegion(center: centerLocation, span: mapspan)
            self.mapView.setRegion(mapregion, animated: true)

           
            
            //Check if user is registered if not register it backend does this
            let uniq_val_device = UIDevice.current.identifierForVendor!.uuidString
            
            Services.registerUser(1, andUnique_va: uniq_val_device, andDeviceToken: uniq_val_device) { response in
                
                
                let user = response as! User
                UserDefaults.standard.setValue(user.user_id, forKey: "user_id")
                UserDefaults.standard.synchronize()
                
                
                //We update user lat long to server
                
             
                Services.updateUserLatLong(user.user_id, andLat: "\(self.currentLocation.coordinate.latitude)", andLongitude: "\(self.currentLocation.coordinate.longitude)") { [self] response in
                    
                    locationManager?.stopUpdatingLocation()
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
    @objc func info(sender: UIButton) {
        if selectedAnnotation != nil{
            self.infoReportComment.text = selectedAnnotation?.imnageComment
            self.infoReportImage.sd_setImage(with: URL(string: "https:\(selectedAnnotation!.imageReport)"))
            
            
            UIView.animate(withDuration: 0.6,
                           animations: {
                self.infoViewReport.alpha = 0
                self.infoViewReport.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
            },
                           completion: { _ in
                UIView.animate(withDuration: 0.6) {
                    self.infoViewReport.alpha = 1
                    self.infoViewReport.transform = CGAffineTransform.identity
                }
            })
        }
       
    }
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        
        self.selectedAnnotation = view.annotation as? MyPointAnnotation
      
    }
    @IBAction func closeDialog() {
        
        UIView.animate(withDuration: 0.4, delay: 0.4) {
            self.infoViewReport.alpha = 0
        }
    }
    
    

}
