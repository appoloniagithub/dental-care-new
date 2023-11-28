//
//  RetakeVC.swift
//  Dental Care
//
//  Created by Sanju Mohamed Sageer on 08/03/2023.
//

import UIKit

class RetakeVC: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    var retakeimagear:[UIImage] = []
    var facescanimage:[UIImage] = []
    var facescan64:[String] = []
    var teethimage64:[String] = []
    var teethscanauto:Bool?
    var onlyteethscan:Bool?
    var onlyfacescan:Bool?
    override func viewDidLoad() {
        super.viewDidLoad()

      
    }
    
    @IBAction func backButtonAction(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return retakeimagear.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RetakeCVC", for: indexPath) as! RetakeCVC
        cell.retakeImage.image = retakeimagear[indexPath.row]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
       
       // let height = collectionView.frame.size.height
        let width = collectionView.frame.size.width/3
        return CGSize(width: width, height: 150)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = UIStoryboard.init(name: "Review", bundle: Bundle.main).instantiateViewController(withIdentifier: "RetakeViewImageVC") as! RetakeViewImageVC
        vc.image = retakeimagear[indexPath.row]
        vc.index = indexPath.row
       
        vc.teethimage = retakeimagear
        vc.teeth64image = teethimage64
        vc.facescan64 = facescan64
        vc.facescanimage = facescanimage
        vc.onlyteethscan = onlyteethscan
        if teethscanauto == true {
            vc.teethscan = true
        }else if teethscanauto == false {
            vc.teethscanmanual = true
        }
        navigationController?.pushViewController(vc, animated: true)
    }


    

}
class RetakeCVC:UICollectionViewCell {
    @IBOutlet weak var retakeImage: UIImageView!
}
