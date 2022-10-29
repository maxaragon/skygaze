//
//  ReportsListViewController.swift
//  Skyapp
//
//  Created by Riyad Faek Anabtawi Rojas on 18/10/22.
//

import UIKit

class ReportsListViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    @IBOutlet var collectionviewReports: UICollectionView!
    var array_reports:[Report] = []
    
  
    
    @IBAction func dismissController() {
        self.dismiss(animated: true)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        Services.getAllImages { res in
            
            self.array_reports = res as! [Report]
            self.collectionviewReports.reloadData()
            
        } orErrorHandler: { err in
            
        }

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ReportCollectionViewCell
        
        
        cell.displayReport(report: self.array_reports[indexPath.row])
        
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.array_reports.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.size.width, height: 150)
    }
    

}
