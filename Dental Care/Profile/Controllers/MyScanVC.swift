//
//  MyScanVC.swift
//  Dental Care
//
//  Created by Sanju Mohamed Sageer on 28/10/2022.
//

import UIKit

class MyScanVC: UIViewController,UITableViewDelegate,UITableViewDataSource {

    var scanmodel:myscanmodel!
    var scanar:scanmodel!
    var scan:Int?
    var isfromreview:Bool?
    var dummyar = [dummyimage,dummyimage,dummyimage]
    var dummyteethar = [dummyimage,dummyimage,dummyimage,dummyimage,dummyimage]
    var delegate:profiledelegate?

    @IBOutlet weak var backImage: UIImageView!
    @IBOutlet weak var noscanImage: UILabel!
    @IBOutlet weak var scanTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
       myscangetget()
       
        if DCLanguageManager.sharedInstance.getLanguage() == "en" {
            backImage.image = UIImage(named: "Group 106")
        }else {
            backImage.image = UIImage(named: "right-arrow(1)")
        }
    }
    
    @IBAction func backButtonAction(_ sender: UIButton) {
        if isfromreview == true {
            let vc = UIStoryboard.init(name: "Home", bundle:      Bundle.main).instantiateViewController(withIdentifier: "CustomTabBarvc")  as! CustomTabBarvc//Tabbar  Drtab Home DoctorSB
            tabBarController?.tabBar.isHidden = true
            self.navigationController?.navigationBar.isHidden = true
            self.navigationController?.pushViewController(vc, animated: false)
        }else {
            navigationController?.popViewController(animated: true)
            delegate?.tabbar()
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return scanmodel?.scans.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyScanTVC") as! MyScanTVC
        if scan == 1 {
            
        
            cell.DrNameLabel.text = scanmodel?.scans[indexPath.row].doctorName
          //  cell.scanDateLabel.text = formatDate(date: scanmodel?.scans[indexPath.row].created ?? "")
            cell.scanDateLabel.text = formatDateandtime(date: scanmodel?.scans[indexPath.row].created ?? "")
    }
        return cell
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UIStoryboard.init(name: "ProfileSB", bundle: Bundle.main).instantiateViewController(withIdentifier: "MyScanImagesVC") as! MyScanImagesVC
        navigationController?.navigationBar.isHidden = true
       // vc.scanar = .joined()
        if scanmodel.scans[indexPath.row].faceScanImages.count == 0 {
            vc.scanar = dummyar + scanmodel.scans[indexPath.row].teethScanImages 
            //vc.scanar.insert(logo , at: 4)
            vc.scanar.insert(scanmodel.scans[indexPath.row].logo ?? "", at: 4)
            
            vc.onlyteethscan = true

        }else if scanmodel.scans[indexPath.row].teethScanImages.count == 0   {
            vc.scanar =  scanmodel.scans[indexPath.row].faceScanImages + dummyteethar
            vc.onlyfacescan = true
          //  vc.scanar.insert(scanmodel.scans[indexPath.row].logo ?? "", at: 4)
            vc.scanar.insert(scanmodel.scans[indexPath.row].logo ?? "", at: 4)
          //  vc.scanar.insert(logo , at: 4)
        }
        else {
        let scan = [scanmodel.scans[indexPath.row].faceScanImages,scanmodel.scans[indexPath.row].teethScanImages]


        vc.scanar = (scan.joined())
            vc.scanar.insert(scanmodel.scans[indexPath.row].logo ?? "", at: 4)
            //vc.scanar.insert(logo , at: 4)
    }
        navigationController?.pushViewController(vc, animated: false)

}

}
class MyScanTVC:UITableViewCell {
    
    @IBOutlet weak var scanDateLabel: UILabel!
    @IBOutlet weak var DrNameLabel: UILabel!
}
class EmptyScanTVC:UITableViewCell {
    
}
