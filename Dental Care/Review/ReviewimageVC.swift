//
//  ReviewimageVC.swift
//  Dental Care
//
//  Created by Sanju Mohamed Sageer on 19/01/2023.
//

import UIKit
import Kingfisher

class ReviewimageVC: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    var imageArray:[String] = []
    var imageconverted:String?
    var index:Int?
    var scanimagearray:[UIImage] = []
     var delegate:myscanimagesdelegate?
    var isfromreview:Bool?
    var isfrommyscan:Bool?
    var isfromfacescanalone:Bool?
    var isfacescan:Bool?
    var neeedrotation:Bool? = true
    var rotationcount = 0
    @IBOutlet weak var imageCV: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1)
        { [self] in
            imageCV.scrollToItem(at: NSIndexPath(item: index ?? 0, section: 0) as IndexPath, at: [], animated: false)
            
        }
     }

    @IBAction func backButtonAction(_ sender: UIButton) {
        delegate?.removeimages()
        navigationController?.popViewController(animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isfromreview == true {
            return scanimagearray.count
        }else if  isfrommyscan == true {
            return imageArray.count
        }else {
            return scanimagearray.count
        }
      
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ReviewImageCVC", for: indexPath) as! ReviewImageCVC
        if isfromreview == true {
           // cell.reviewImage.image = scanimagearray[indexPath.row]
            if isfacescan == true {
                cell.reviewImage.image = scanimagearray[indexPath.row]
                if neeedrotation == true {
                    cell.reviewImage.transform = cell.reviewImage.transform.rotated(by: .pi/2)
                    rotationcount += 1
                    if rotationcount == 3 {
                        neeedrotation = false
                    }
                }
            }else {
                if neeedrotation == true {
                    cell.reviewImage.transform = cell.reviewImage.transform.rotated(by: .pi/2)
                    rotationcount += 1
                    if rotationcount == 3 {
                        neeedrotation = false
                    }
                }else {
                    cell.reviewImage.image = scanimagearray[indexPath.row]
                }
            }
        }else if isfrommyscan == true {
            imageconverted = image_baseURL + imageArray[indexPath.row]
            cell.reviewImage.kf.setImage(with: URL(string:imageconverted!))
           
        }
        else {
            if isfacescan == true {
                cell.reviewImage.image = scanimagearray[indexPath.row]
                if neeedrotation == true {
                    cell.reviewImage.transform = cell.reviewImage.transform.rotated(by: .pi/2)
                    rotationcount += 1
                    if rotationcount == 3 {
                        neeedrotation = false
                    }
                }
              //  cell.reviewImage.transform = cell.reviewImage.transform.rotated(by: .pi/2)
            }else {
                cell.reviewImage.image = scanimagearray[indexPath.row]
            }
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = collectionView.frame.size.height
        let width = collectionView.frame.size.width
        return CGSize(width: width, height: height)
    }
}
class ReviewImageCVC:UICollectionViewCell {
    
    @IBOutlet weak var reviewImage: UIImageView!
}
