//
//  NotificationVC.swift
//  Dental Care
//
//  Created by Sanju Mohamed Sageer on 16/03/2023.
//

import UIKit

class NotificationVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
   
    
    @IBOutlet weak var notiTV: UITableView!
    var notiModel:NotificationModel?
    var notiload:Int?
    var delegate:profiledelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
         notification()
        // Do any additional setup after loading the view.
    }
    @IBAction func backButtonAction(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
        delegate?.tabbar()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
            return notiModel?.allNotifications.count ?? 0
     
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NotificationTVC") as! NotificationTVC
        cell.notificationHeadLabel.text = notiModel?.allNotifications[indexPath.row].title
        cell.notificationTextLabel.text = notiModel?.allNotifications[indexPath.row].body
        cell.timeLabel.text =   formatDateandtime(date:  notiModel?.allNotifications[indexPath.row].created ?? "")
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if notiModel?.allNotifications[indexPath.row].actionName == "Scan" {
            let vc = UIStoryboard.init(name: "ScanSB", bundle: Bundle.main).instantiateViewController(withIdentifier: "ScannSelectionVC") as! ScannSelectionVC
             // vc.delegate = self
              navigationController?.navigationBar.isHidden = true
              tabBarController?.tabBar.isHidden = true
            navigationController?.pushViewController(vc, animated: true)
        }else if notiModel?.allNotifications[indexPath.row].actionName == "Chat" {
            let vc = UIStoryboard.init(name: "Home", bundle: Bundle.main).instantiateViewController(withIdentifier: "ChatConversationsVC") as! ChatConversationsVC
             // vc.delegate = self
              navigationController?.navigationBar.isHidden = true
              tabBarController?.tabBar.isHidden = false
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}
class NotificationTVC:UITableViewCell {
    @IBOutlet weak var notificationHeadLabel: UILabel!
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var notificationTextLabel: UILabel!
}

