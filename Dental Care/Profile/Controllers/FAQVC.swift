//
//  FAQVC.swift
//  Dental Care
//
//  Created by Sanju Mohamed Sageer on 11/11/2022.
//

import UIKit

class FAQVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
   
    
    var FAQanswered:Int?
    @IBOutlet weak var faqtv: UITableView!
    @IBOutlet weak var backImage: UIImageView!
    var delegate:profiledelegate?
    var quaestionar = ["Why is it important to choose a Pediatric Dentist?","When will my child begin to get primary (baby) / permanent teeth?","Why do I need to take care of baby (primary) teeth?","What is Baby Bottle Tooth Decay?"]
    var answerar = ["Pediatric dentists care for children of all ages. From first tooth to adolescence, they help your child develop a healthy smile until they’re ready to move on to a general dentist. Pediatric dentists have had 2-3 years of special training to care for young children and adolescents.","Your child’s first tooth will typically erupt between 6 and 12 months, although it is common to occur earlier. Usually, the two bottom front teeth – the central incisors – erupt first, followed by four upper front teeth – called the central and lateral incisors. Your child should have their first full set of teeth by their third birthday. \n Permanent teeth start to appear around age 6, beginning with the first molars and lower central incisors. The age of 8, is generally when the bottom 4 primary teeth (the lower central and lateral incisors) and the top 4 primary teeth (the upper central and lateral incisors) begin to fall out and permanent teeth take their place. The rest of the permanent teeth will start to come in around age 10. Permanent teeth can continue to erupt until approximately age 21. Adults have 32 permanent teeth including the third molars (called wisdom teeth)","Baby teeth may be temporary, but they serve a very important role in the development and health of your child. They help your child to chew promoting proper nutrition. They also assist the child to speak in a normal manner.","One of the most common forms of early childhood caries is “baby bottle tooth decay,” which is caused by the continuous exposure of a baby’s teeth to sugary drinks. Baby bottle tooth decay primarily affects the upper front teeth, but other teeth may also be affected."]
    override func viewDidLoad() {
        super.viewDidLoad()
        if DCLanguageManager.sharedInstance.getLanguage() == "en" {
            backImage.image = UIImage(named: "Group 106")
        }else {
            backImage.image = UIImage(named: "right-arrow(1)")
        }
    }
   
    @IBAction func backButtonAction(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
        delegate?.tabbar()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        quaestionar.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "faqTVC") as! faqTVC
        if FAQanswered == indexPath.row {
       
        cell.answelabel.text = answerar[indexPath.row]
        cell.questionlabel.text = quaestionar[indexPath.row]
            cell.indicationImage.image = UIImage(named: "upload")
            cell.indicationImage.tintColor = UIColor.white
       
    }
        else {
            cell.answelabel.text = ""
            cell.questionlabel.text = quaestionar[indexPath.row]
            cell.indicationImage.image = UIImage(named: "down-arrow")
            cell.indicationImage.tintColor = UIColor.white
        
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        FAQanswered = indexPath.row
        faqtv.reloadData()
    }
   

}
class faqTVC:UITableViewCell {
  
   
    @IBOutlet weak var answelabel: UILabel!
    @IBOutlet weak var questionlabel: UILabel!
    @IBOutlet weak var indicationImage: UIImageView!
}
