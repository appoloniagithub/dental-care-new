//
//  DrHomeVC.swift
//  Dental Care
//
//  Created by Sanju Mohamed Sageer on 15/02/2023.
//

import UIKit

class DrHomeVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
   
    

    override func viewDidLoad() {
        super.viewDidLoad()

       
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }else {
          return 2
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier:"DrhomeHeadTVC") as! DrhomeHeadTVC
            return cell
        }else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DrListTVC") as! DrListTVC
            return cell
        }
        
    }
  
}
class DrhomeHeadTVC:UITableViewCell {
    
}
class drhomeScans:UITableViewCell {
    
}
