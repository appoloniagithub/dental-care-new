//
//  ArticleDetailVC.swift
//  Dental Care
//
//  Created by Sanju Mohamed Sageer on 31/10/2022.
//

import UIKit

class ArticleDetailVC: UIViewController {
    var discription:String?
    var nameauthor:String?
    var image:String?
    var created:String?
    var name:String?
    var date:String?
    var imageAuthor:String?
    @IBOutlet weak var backImage: UIImageView!
    @IBOutlet weak var authorimage: UIImageView!
    @IBOutlet weak var headerlabel: UILabel!
    @IBOutlet weak var createdatLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var dateCreated: UILabel!
    @IBOutlet weak var authorName: UILabel!
    @IBOutlet weak var articleName: UILabel!
    @IBOutlet weak var articleImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        descriptionLabel.text = discription
        authorName.text = nameauthor
        articleImage.kf.setImage(with: URL(string: image ?? ""))
        authorimage.kf.setImage(with:URL(string:UserDefaults.standard.string(forKey: "proimage") ?? ""))
       // articleName.text = name
        dateCreated.text = formatDate(date: created ?? "")
        headerlabel.text = name
        authorimage.layer.cornerRadius = authorimage.frame.size.width/2
        authorimage.clipsToBounds = true
        if DCLanguageManager.sharedInstance.getLanguage() == "en" {
            backImage.image = UIImage(named: "Group 106")
        }else {
            backImage.image = UIImage(named: "right-arrow(1)")
        }
    }
    
    @IBAction func backButtonAction(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
