//
//  ChatViewController.swift
//  Dental Care
//
//  Created by Sanju Mohamed Sageer on 31/10/2022.
//

import UIKit
import Kingfisher
import IQKeyboardManagerSwift
protocol tabbardelegate {
    func tabbar()
}
protocol reloadview {
    func reload()
}
class ChatViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate,reloadview {
    
    
    
    
    
    
    
    @IBOutlet weak var MessageTF: UITextField!
    @IBOutlet weak var ChatTV: UITableView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var proimage: UIImageView!
    var messages:[String:AnyObject] = [:]
     var delegate: tabbardelegate?
    var conversationid:String?
    var proName:String?
    var filedata:Data?
    var Image:String?
    var imagePicker = UIImagePickerController()
    var senderid:String?
    var isdoctor:Int?
    var chat = 0
    var pickedImages: UIImage?
    var chatm:chatmodel?
    var cham:[String:AnyObject]?
    var reloaddelegate:reloadview?
    var messagemodel:messagedatamodels?
    var bottomhit = 1
    var reloaddata:Bool = false
    var messagesmodel:MessagesModel?
    var iffromscans:Bool?
    var chardrmodel:chatdoctormodel?
    var drchatmodel:doctordatachatmodel?
    var indexpaths:IndexPath?
    var index:Int = 0
   
    @IBOutlet weak var backImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
       
        //self.ChatTV.scrollToBottom(animated: false)
        imagePicker.delegate = self
        proimage.layer.cornerRadius = proimage.frame.size.height / 2
        proimage.clipsToBounds = true
        proimage.layer.masksToBounds = true
        tabBarController?.tabBar.isHidden = true
        reloaddelegate = self
        SocketIOManager.sharedInstance.connectToServerWithusername(username:UserDefaults.standard.string(forKey: "userid") ?? "" )
        
        if DCLanguageManager.sharedInstance.getLanguage() == "en" {
            backImage.image = UIImage(named: "Group 106")
        }else {
            backImage.image = UIImage(named: "right-arrow(1)")
        }
        if iffromscans == true {
            proimage.kf.setImage(with: URL(string: UserDefaults.standard.string(forKey: "doctorimage") ?? ""))
            name.text = UserDefaults.standard.string(forKey: "doctor")
            getConversation()
        }else {
            proimage.kf.setImage(with: URL(string: Image ?? ""))
            name.text = proName
            getConversation()
        }
        
      //  IQKeyboardManager.shared.enable = false
      // IQKeyboardManager.shared.keyboardDistanceFromTextField = 0
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1)
        { [self] in
            
          //   ChatTV.scrollToItem(at: NSIndexPath(item: index ?? 0, section: 0) as IndexPath, at: [], animated: false)
         //   let indexs =   (chatm?.messages.count ?? 0)  - 1
          //  ChatTV.scrollToRow(at: IndexPath(index: indexs) , at: .bottom, animated: true)
        }
     }
    override func viewDidAppear(_ animated: Bool) {
//       // let meparam = ["senderId":UserDefaults.standard.string(forKey: "userid")!,"receiverId":senderid!]
//        SocketIOManager.sharedInstance.socket?.on("receive-message") { (data:Any, socketAck) -> Void in
//            print(data)
//            var messageDictionary:chatmodel?
//            messageDictionary = chatmodel(Fromdata: data as! [String : Any])
//         //   messageInfo.
        SocketIOManager.sharedInstance.getChatMessage { [self] messageInfo in
            print("message is\(messageInfo)")
            //chatm?.messages = messages
            chatm?.messages.append(messageInfo)
            print(chatm?.messages)
            ChatTV.reloadData()
          //  ChatTV.scroll(to: .bottom, animated: true)
            ChatTV.reloadData()
            let indexPath = IndexPath(row: ChatTV.numberOfRows(inSection: 0)-1, section: 0)
               ChatTV.scrollToRow(at: indexPath, at: .bottom, animated: true)
           // ChatTV?.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
//            let topIndex = IndexPath(row: 0, section: 0)
//            ChatTV.scrollToRow(at: topIndex, at: .top, animated: true)
//            var iPath = NSIndexPath(row: self.ChatTV.numberOfRowsInSection(0)-1,
//                                    sectionnumberOfRows(inSection: : self.ChatTV.numberOfSections-1)
//            self.ChatTV.scrollToRowAtIndexPath(iPath as IndexPath,
//                                                  atScrollPosition: UITableViewScrollPosition.Bottom,
//                                                  animated: true)
            
        }
         //   self.ChatTV.reloadData()
    }
        
        
//    func getChatMessage(completionHandler: @escaping  (_ messageInfo: [String: AnyObject]) -> Void) {
//        SocketIOManager.sharedInstance.socket?.on("receive-message") { (dataArray, socketAck) -> Void in
//            var messageDictionary = [String: AnyObject]()
//            messageDictionary["conversationId"] = dataArray[0] as! String as AnyObject
//            messageDictionary["message"] = dataArray[1] as! String as AnyObject
//            messageDictionary["createdAt"] = dataArray[2] as! String as AnyObject
//            messageDictionary["format"] = dataArray[3] as! String as AnyObject
//            messageDictionary["scanId"] = dataArray[4] as! String as AnyObject
//
//            completionHandler(messageDictionary)
//        }
//    }
    func reload() {
    ChatTV.reloadData()
    }
    @IBAction func backButtonAction(_ sender: UIButton) {
        let vc = UIStoryboard.init(name: "Home", bundle:Bundle.main).instantiateViewController(withIdentifier: "CustomTabBarvc")  as! CustomTabBarvc
        vc.selectedIndex = 1
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.pushViewController(vc, animated: false)
    }
   
    @IBAction func attatchFile(_ sender: Any) {
        
        
        
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary){
            
            
            
            imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary;
            //imag.mediaTypes = [kUTTypeImage];
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
            
        }
    }
    func uploadphoto(message:String?) {
        filedata = try pickedImages!.jpegData(compressionQuality: 1.0)
//        let messageparam = ["conversationId":conversationid! ,
//                         "senderId":UserDefaults.standard.string(forKey: "userid")!,
//                            "receiverId":senderid!,"file":filedata!]  as [String : Any]
//        SocketIOManager.sharedInstance.socket?.emit("upload",messageparam)
        
      
        let messageparam = ["conversationId":conversationid! ,
                                            "senderId":UserDefaults.standard.string(forKey: "userid")!,
                            "message":messagemodel?.message,
       
                                            //"message":filedata,
                            "format":"image", "scanId":"", "receiverId":senderid!,"createdAt":messagemodel?.createdAt]  as [String : Any]
                           SocketIOManager.sharedInstance.socket?.emit("send-message",messageparam)
       
        
    }
    @IBAction func sentMessageButtonAction(_ sender: UIButton) {
        MessageTF.resignFirstResponder()
        if pickedImages != nil {
            
            //sentmessageimage()
            
        }
        else {
            if MessageTF.text?.isEmpty == true {
                BannerNotification.failureBanner(message: "enter Message to Sent")
            }else {
                
                
                
                //                    SocketIOManager.sharedInstance(message: MessageTF.text ?? "", withusername: UserDefaults.standard.string(forKey: "userid") ?? "", senderid: senderid)
                //                 SocketIOManager.sharedInstance.sendMessage( receiverId:  "6351452835155fec28aa67b1")
                // SocketIOManager.sharedInstance.sendMessage([message]: MessageTF.text ?? "", senderId: senderid ?? "", receiverId: UserDefaults.standard.string(forKey: "userid") ?? "")
                //  filedata = try pickedImages!.jpegData(compressionQuality: 1.0)
                
                
                ///////////////
                ///
                if isdoctor == 0 {
                    
                    let messageparam = ["conversationId":conversationid! ,
                                        "senderId":UserDefaults.standard.string(forKey: "userid")!,
                                        "message":MessageTF.text!,
                                        "format":"text", "scanId":"", "receiverId":senderid ?? "","recId": senderid ?? ""]  as [String : Any]
                    SocketIOManager.sharedInstance.socket?.emit("send-message",messageparam)
                    
                    SentMessage()
                    MessageTF.text = nil
                }else {
                    
                    let messageparam = ["conversationId":conversationid! ,
                                        "senderId":UserDefaults.standard.string(forKey: "userid")!,
                                        "message":MessageTF.text!,
                                        "format":"text", "scanId":"", "receiverId":UserDefaults.standard.string(forKey: "doctorID") ?? "","recId": senderid ?? ""]  as [String : Any]
                    SocketIOManager.sharedInstance.socket?.emit("send-message",messageparam)
                    
                    SentMessage()
                    MessageTF.text = nil
                }
                
           
            }
            
        }
    }
//        }
//    }
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            print("image picker delegate")
            if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                pickedImages  = pickedImage
                sentmessageimage()
             //   uploadphoto()
//                let parameters = ["conversationId":conversationid! ,
//                                  "senderId":UserDefaults.standard.string(forKey: "userid")!,
//                                  //"message":MessageTF.text!,
//                "format":"image", "scanId":""] as [String : String]
//                filedata = try pickedImages!.jpegData(compressionQuality: 1.0)
//
//                uploadImage(paramName: parameters, fileName:filedata, image: filedata)
               // sentmessageimage()
               // pickedImages.append(pickedImage)
    //                pickedimage.contentMode = .scaleAspectFill
    //            pickedimage.image = pickedImage
                }

                dismiss(animated: true, completion: nil)
            
        }
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            dismiss(animated: true, completion: nil)
        }
    

        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            if chat == 1 {
            return chatm?.messages.count ?? 0
           
        }
            else{
                return 0
            }
        }
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        index += 1
            if chatm?.messages[indexPath.row].senderId == UserDefaults.standard.string(forKey: "userid") {
                if chatm?.messages[indexPath.row].format == "scanImage" ||  chatm?.messages[indexPath.row].format == "image" {
                    let cell = tableView.dequeueReusableCell(withIdentifier: "ChatsenderimageTVC") as!  ChatsenderimageTVC
                    if  chatm?.messages[indexPath.row].format == "image"{
                        let image = image_baseURL + (chatm?.messages[indexPath.row].message ?? "")
                 
                        cell.senderimage.kf.setImage(with: URL(string: image ))
                        cell.timeLabel.text =  chatm?.messages[indexPath.row].createdAt
                    }else {
                        let image = image_baseURL + (chatm?.messages[indexPath.row].message ?? "")
                        cell.senderimage.kf.setImage(with: URL(string: image ))
                       // cell.senderimage.kf.setImage(with: URL(string: chatm?.messages[indexPath.row].message ?? ""))
                    cell.timeLabel.text =  chatm?.messages[indexPath.row].createdAt
                    }
                    indexpaths = indexPath
                    return cell
                    
                } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ChatSenderTVC") as!  ChatSenderTVC
                if chat == 1{
                cell.senderLabel.text = chatm?.messages[indexPath.row].message
                  cell.timeLabel.text = chatm?.messages[indexPath.row].createdAt
                   // senderid = chatm?.messages[indexPath.row].senderId
                
            }
                return cell
            }
               
                
            }
            else {
                if chatm?.messages[indexPath.row].format == "scanImage" ||  chatm?.messages[indexPath.row].format == "image" {
                    let cell = tableView.dequeueReusableCell(withIdentifier: "ChatRecieeverImageTVC") as!  ChatRecieeverImageTVC
                    let image = image_baseURL + (chatm?.messages[indexPath.row].message ?? "")
                    cell.recieverImage.kf.setImage(with: URL(string: image ))
                   // convertBase64ToImage(imageString: chatm?.messages[indexPath.row].message ?? "")
                    cell.timeLabel.text = chatm?.messages[indexPath.row].createdAt
                    return cell
                }else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "ChatRecieverTVC") as!  ChatRecieverTVC
                if chat == 1
                {
                    cell.recieverLabel.text =  chatm?.messages[indexPath.row].message
                    cell.timeLabel.text = chatm?.messages[indexPath.row].createdAt
                    //senderid = chatm?.messages[indexPath.row].senderId
                }
            
                return cell
            }
            }
          //  ChatTV.scrollToRow(at: indexPath, at: .bottom, animated: true)
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if  chatm?.messages[indexPath.row].format == "image" {
            guard let url = URL(string: chatm?.messages[indexPath.row].message ?? "") else { return }
            UIApplication.shared.open(url)
        }
        else if chatm?.messages[indexPath.row].format == "scanImage" {
            let vc = UIStoryboard.init(name: "ProfileSB", bundle: Bundle.main).instantiateViewController(withIdentifier: "MyScanImagesVC") as! MyScanImagesVC
            navigationController?.navigationBar.isHidden = true
            vc.scanid = chatm?.messages[indexPath.row].scanId
            vc.forscan = true
            navigationController?.pushViewController(vc, animated: true)
        }
    }
//    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        if indexPath.row == (chatm?.messages.count ?? 0) - 1 {
//           loadmessages()
//        }
//    }
//    func loadmessages() {
//        bottomhit += 1
//        getConversation()
//        ChatTV.reloadData()
//        
//    }
}
extension UITableView {
    
    public func reloadData(_ completion: @escaping ()->()) {
        UIView.animate(withDuration: 0, animations: {
            self.reloadData()
        }, completion:{ _ in
            completion()
        })
    }
    
    func scroll(to: scrollsTo, animated: Bool) {
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(300)) {
            let numberOfSections = self.numberOfSections
            let numberOfRows = self.numberOfRows(inSection: numberOfSections-1)
            switch to{
            case .top:
                if numberOfRows > 0 {
                    let indexPath = IndexPath(row: 0, section: 0)
                    self.scrollToRow(at: indexPath, at: .top, animated: animated)
                }
                break
            case .bottom:
                if numberOfRows > 0 {
                    let indexPath = IndexPath(row: numberOfRows-1, section: (numberOfSections-1))
                    self.scrollToRow(at: indexPath, at: .bottom, animated: animated)
                }
                break
            }
        }
    }
    enum scrollsTo {
          case top,bottom
      }
  }

extension UITableView {
    func scrollToBottom(animated: Bool = true) {
        let section = self.numberOfSections
        if section > 0 {
            let row = self.numberOfRows(inSection: section - 1)
            if row > 0 {

                self.scrollToRow(at: IndexPath(row: row-1, section: section-1), at: .bottom, animated: animated)
            }
        }
    }
}


