//
//  ChatCells.swift
//  Dental Care
//
//  Created by Sanju Mohamed Sageer on 31/10/2022.
//

import Foundation
import UIKit
class ChatSenderTVC:UITableViewCell {
    
    @IBOutlet weak var senderLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
}
class ChatRecieverTVC:UITableViewCell {
    
    @IBOutlet weak var recieverLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
}
class ChatsenderimageTVC:UITableViewCell {
    @IBOutlet weak var senderimage: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!
}
class ChatRecieeverImageTVC:UITableViewCell {
    @IBOutlet weak var recieverImage: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!
}
