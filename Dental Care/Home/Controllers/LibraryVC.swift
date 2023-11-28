//
//  LibraryVC.swift
//  Dental Care
//
//  Created by Sanju Mohamed Sageer on 26/10/2022.
//

import UIKit
import Kingfisher

class LibraryVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
  
    var libraryodel:librarymodel!
    var articles:articlesmodel!
    var reload:Int?
    var image:UIImage?
    var images:String?
    @IBOutlet weak var libraryTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        libraryget()
        // Do any additional setup after loading the view.
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if reload == 1 {
        return libraryodel.articles.count
        }
        else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "librarycell") as! librarycell
        if reload ==  1 {
             images = image_baseURL + (libraryodel.articles[indexPath.row].image.first ?? "")
        cell.authorName.text = libraryodel.articles[indexPath.row].author.authorName
        cell.articleName.text = libraryodel.articles[indexPath.row].name
            cell.articleImage.kf.setImage(with: URL(string:images ?? "" ))
        }
       return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UIStoryboard.init(name: "Home", bundle: Bundle.main).instantiateViewController(withIdentifier: "ArticleDetailVC") as! ArticleDetailVC
        vc.image = images
        vc.name = libraryodel.articles[indexPath.row].name
        vc.nameauthor = libraryodel.articles[indexPath.row].author.authorName
        vc.created = libraryodel.articles[indexPath.row].created
        //vc.imageAuthor = libraryodel.articles[indexPath.row].author.authorImage
        vc.discription = libraryodel.articles[indexPath.row].description
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
 

}
class librarycell:UITableViewCell  {
    @IBOutlet weak var articleImage: UIImageView!
    @IBOutlet weak var authorName: UILabel!
    @IBOutlet weak var articleName: UILabel!
}
