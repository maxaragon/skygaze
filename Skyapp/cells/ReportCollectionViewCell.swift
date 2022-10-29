//
//  ReportCollectionViewCell.swift
//  skygazeapp
//
//  Created by Riyad Anabtawi on 14/10/22.
//

import UIKit
import SDWebImage
class ReportCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet private var imagesView: UIImageView!

    @IBOutlet private var addressLabel: UILabel!
    @IBOutlet private var latlongLabel: UILabel!
    @IBOutlet private var altitudeLabel: UILabel!
    @IBOutlet private var compassLabel: UILabel!
    @IBOutlet private var timestampLabel: UILabel!
    
    
    
  func displayReport(report:Report){
        
      self.imagesView.sd_setImage(with: URL(string: "https:" + report.picture_url))
      

      
      
      if report.address != nil{
          
          self.addressLabel.text = report.address!
      }else{
          
          self.addressLabel.text = "No Data Available"
      }
      
      if(report.compass_value != nil){
          
          self.compassLabel.text = "Compass: \(report.compass_value!)"
          
          
      }else{
         
          self.compassLabel.text = "Compass: No Data Available"
      }
      
      let r1 = report.latitude.floatValue
      let r2 = report.longitude.floatValue
     
      self.latlongLabel.text = "Lat: \(round(r1 * 10000) / 10000.0)" + "\n" + "Long: \(round(r2 * 10000) / 10000.0)"
      if report.altitude != nil{
          let r = report.altitude.floatValue
          
          
          self.altitudeLabel.text = "Altitude: \(round(r * 100) / 100.0)m"
          
      }else{
          self.altitudeLabel.text = "Altitude: 0m"
          
      }
        
    
      self.timestampLabel.text = report.created_at!
      
    }
    
}
