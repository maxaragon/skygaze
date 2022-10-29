//
//  IconCollectionViewCell.swift
//  Skyapp
//
//  Created by Riyad Faek Anabtawi Rojas on 20/10/22.
//

import UIKit
import SDWebImage
class IconCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet  var imageIconView: UIImageView!
    @IBOutlet  var imageIconLabel: UILabel!
    
    override var isSelected: Bool {
         didSet {
             self.imageIconLabel.alpha = isSelected ? 1 : 0.5
             self.imageIconView.alpha = isSelected ? 1 : 0.5
         }
     
     }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.imageIconView.alpha = 0.5
        self.imageIconLabel.alpha = 0.5
        
        
    }
  
    func showIcon(icon:Weathericon){
        
        
        self.imageIconView.sd_setImage(with: URL(string: "https:" + icon.icon_url!))
        self.imageIconLabel.text = icon.name!
        
    }
}
