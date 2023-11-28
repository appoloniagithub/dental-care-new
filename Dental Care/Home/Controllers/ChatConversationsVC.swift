//
//  ChatConversationsVC.swift
//  Dental Care
//
//  Created by Sanju Mohamed Sageer on 26/10/2022.
//

import UIKit
import Kingfisher
import AlamofireImage

class ChatConversationsVC: UIViewController,UITableViewDelegate,UITableViewDataSource{
   
    
  
    
   
    var chatmodel:ChatModel?
    var chatload = 0
   

    @IBOutlet weak var chatlistTV: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        chatlistapi()
        SocketIOManager.sharedInstance.connectToServerWithusername(username:UserDefaults.standard.string(forKey: "userid") ?? "" )
        SocketIOManager.sharedInstance.joinroom(room: "Supraja")
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        chatlistapi()
        SocketIOManager.sharedInstance.joinroom(room: "Supraja")
    }
    override func viewDidAppear(_ animated: Bool) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2)
        { [self] in
            chatlistTV.reloadData()
        }
    }

func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        return chatmodel?.conversations.count ?? 0
 
}

func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "ChatConversationTVC") as! ChatConversationTVC
    if chatload == 1{
        let lastmessage = chatmodel?.conversations[indexPath.row].lastMessage
//      let lastmessagefound =  String(lastmessage?.suffix(3))
        let lastmessagefound = String(lastmessage!.suffix(3))
//        let indexmessage = lastmessage?.index(lastmessage!.endIndex , offsetBy: -3)
//        let subStr = lastmessage![index...]
        if chatmodel?.conversations[indexPath.row].chatCount == 0 {
            cell.countView.isHidden = true
            cell.countLabel.isHidden = true
        }else {
            cell.countView.isHidden = false
            cell.countLabel.isHidden = false
            cell.countView.layer.cornerRadius = cell.countView.frame.size.width/2
            cell.countView.clipsToBounds = true
            cell.countLabel.text = "\(chatmodel?.conversations[indexPath.row].chatCount ?? 1)"
        }
        if lastmessagefound == "jpg" || lastmessagefound == "png"  {
            cell.messageLabel.text = "image"
        }else {
            cell.messageLabel.text = chatmodel?.conversations[indexPath.row].lastMessage
        }
       
        cell.personNameLabel.text = chatmodel?.conversations[indexPath.row].lastName
       
//        if chatmodel.conversations[indexPath.row].otherMemberData?.name == "Appolonia Customer Care" {
//            cell.messageLabel.text = "Admin"
//        }else {
//            cell.messageLabel.text = "Orthodontist"
//        }
//
        let lastimage = image_baseURL + (chatmodel?.conversations[indexPath.row].lastImage ?? "")
        cell.chatTime.text =  formatDateandtime(date: chatmodel?.conversations[indexPath.row].updatedAt ?? "")
   //     cell.proimage.kf.setImage(with: URL(string: lastimage ?? ""))
        cell.proimage.kf.indicatorType = .activity
        cell.proimage.layer.cornerRadius = cell.proimage.frame.size.width / 2
        cell.proimage.clipsToBounds = true
        cell.proimage.layer.masksToBounds = true
        cell.proimage.kf.setImage(with: URL(string: lastimage))
       
        
        
        
        
        
     //  cell.proimage.setCustomImage( URL(string: lastimage) )
       // cell.proimage.loadImageUsingCacheWithURLString(chatmodel?.conversations[indexPath.row].otherMemberData?.image ?? "", placeHolder: UIImage(named:"Ellipse 14"))
        
//        if var strUrl = chatmodel.conversations[indexPath.row].otherMemberData.image {
//
//            strUrl = strUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
//            cell.proimage.kf.setImage(with: URL(string: strUrl))
//
//        }
    }

    return cell
}
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UIStoryboard.init(name: "Home", bundle: Bundle.main).instantiateViewController(withIdentifier: "ChatViewController") as! ChatViewController
       
        vc.conversationid = chatmodel?.conversations[indexPath.row].conversationId
        vc.Image = chatmodel?.conversations[indexPath.row].otherMemberData?.image.first
        vc.proName = chatmodel?.conversations[indexPath.row].lastName
        vc.senderid = chatmodel?.conversations[indexPath.row].lastReceiverId
        vc.isdoctor = indexPath.row
        
        

      
       // vc.senderid = chatmodel.conversations[indexPath.row]
        
          navigationController?.navigationBar.isHidden = true
          navigationController?.pushViewController(vc, animated: false)
    }
   
    

}
class ChatConversationTVC:UITableViewCell {
    @IBOutlet weak var personNameLabel: UILabel!
    @IBOutlet weak var messageLabel:UILabel!
    @IBOutlet weak var chatTime:UILabel!
    @IBOutlet weak var countView: UIView!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var proimage: UIImageView!
}
extension UIImageView {

    func setCustomImage(_ imgURLString: String?) {
        guard let imageURLString = imgURLString else {
            self.image = UIImage(named: "default.png")
            return
        }
        DispatchQueue.global().async { [weak self] in
            
            
            let data = try? Data(contentsOf: URL(string: imageURLString)!)
            DispatchQueue.main.async {
                self?.image = data != nil ? UIImage(data: data!) : UIImage(named: "default.png")
            }
        }
    }
}
//let imageCache = NSCache<NSString, UIImage>()
//
//extension UIImageView {
//
//    func loadImageUsingCacheWithURLString(_ URLString: String, placeHolder: UIImage?) {
//
//        self.image = nil
//        if let cachedImage = imageCache.object(forKey: NSString(string: URLString)) {
//            self.image = cachedImage
//            return
//        }
//
//        if let url = URL(string: URLString) {
//            URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
//
//                //print("RESPONSE FROM API: \(response)")
//                if error != nil {
//                    print("ERROR LOADING IMAGES FROM URL: \(String(describing: error))")
//                    DispatchQueue.main.async { [weak self] in
//                        self?.image = placeHolder
//                    }
//                    return
//                }
//                DispatchQueue.main.async { [weak self] in
//                    if let data = data {
//                        if let downloadedImage = UIImage(data: data) {
//                            imageCache.setObject(downloadedImage, forKey: NSString(string: URLString))
//                            self?.image = downloadedImage
//                        }
//                    }
//                }
//            }).resume()
//        }
//    }
//}
