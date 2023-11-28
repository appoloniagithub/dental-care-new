//
//  MyScanImagesVC.swift
//  Dental Care
//
//  Created by Sanju Mohamed Sageer on 28/10/2022.
//

import UIKit
import Kingfisher
protocol myscanimagesdelegate {
    func removeimages()
}

class MyScanImagesVC: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,myscanimagesdelegate{
    
    
    var scanar:[String] = []
    var imageconverted:String?
    var indexPath: IndexPath?
    var onlyteethscan:Bool?
    @IBOutlet weak var backImage: UIImageView!
    var onlyfacescan:Bool?
    var forscan:Bool?
    var scanid:String?
    var scanimagear:[String] = []
    var isfromchat:Bool?
    var scanmodel:myscanmodel?
    var scan:Int?
    var scansimagemodel:scanmodel?
    var dummyar =      [dummyimage,dummyimage,dummyimage]
    var dummyteethar = [dummyimage,dummyimage,dummyimage,dummyimage,dummyimage]
    //    var onlyfacescan:Bool?
    //    var onlyteethscan:Bool?
    @IBOutlet weak var scanCv: UICollectionView!
    var index:Int?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if DCLanguageManager.sharedInstance.getLanguage() == "en" {
            backImage.image = UIImage(named: "Group 106")
        }else {
            backImage.image = UIImage(named: "right-arrow(1)")
        }
        if forscan == true {
            scanGet()
        }
        
    }
    @IBAction func backButtonAction(_ sender: UIButton) {
        navigationController?.popViewController(animated: false)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return scanar.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyScanDisplayCVC", for: indexPath) as! MyScanDisplayCVC
        //        if forscan == true {
        //
        //        }else {
        if indexPath.row == 4 {
            //cell.displayImage.image = convertBase64ToImage(imageString: scanar[indexPath.row])
            cell.displayImage.contentMode = .scaleAspectFit
            //            imageconverted = image_baseURL + scanar[indexPath.row]
            //            cell.displayImage.kf.setImage(with: URL(string:imageconverted!))
        }
        //            else {
        //
        if onlyfacescan == true {
            if indexPath.row == 0 {
                imageconverted = image_baseURL + scanar[indexPath.row]
                cell.displayImage.kf.setImage(with: URL(string:imageconverted!))
            }
            else if indexPath.row == 1 {
                imageconverted = image_baseURL + scanar[indexPath.row]
                cell.displayImage.kf.setImage(with: URL(string:imageconverted!))
            }
            else if indexPath.row == 2 {
                imageconverted = image_baseURL + scanar[indexPath.row]
                cell.displayImage.kf.setImage(with: URL(string:imageconverted!))
            }
//            else if indexPath.row == 4 {
//                cell.displayImage.kf.setImage(with: URL(string:scanar[indexPath.row]))
//
//            }else{
             //   cell.displayImage.image = convertBase64ToImage(imageString: scanar[indexPath.row])
            }
       // }
        else if onlyteethscan == true {
            if indexPath.row == 0 {
                imageconverted = image_baseURL + scanar[indexPath.row]
                cell.displayImage.kf.setImage(with: URL(string: imageconverted ?? ""))
            }
            else if indexPath.row == 1 {
                //cell.displayImage.image = convertBase64ToImage(imageString: scanar[indexPath.row])
                imageconverted = image_baseURL + scanar[indexPath.row]
                cell.displayImage.kf.setImage(with: URL(string: imageconverted ?? ""))
                
            }
            else if indexPath.row == 2 {
              //  cell.displayImage.image = convertBase64ToImage(imageString: scanar[indexPath.row])
                
                imageconverted = image_baseURL + scanar[indexPath.row]
                cell.displayImage.kf.setImage(with: URL(string: imageconverted ?? ""))
            }
            else {
                imageconverted = image_baseURL + scanar[indexPath.row]
                cell.displayImage.kf.setImage(with: URL(string:imageconverted!))
            }
        }
        else {
            if indexPath.row == 4 {
                cell.displayImage.kf.setImage(with: URL(string: scanar[indexPath.row]))
                cell.displayImage.contentMode  = .scaleAspectFill
            }else {
                imageconverted = image_baseURL + scanar[indexPath.row]
                cell.displayImage.kf.setImage(with: URL(string:imageconverted!))
                
            }
            
        }
        
        //  }
        
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
       
        let height = collectionView.frame.size.height
        let width = collectionView.frame.size.width/3
        return CGSize(width: width, height: 150)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
//        if indexPath.row == 4 {
//            vc.isbase64 = true
//            vc.scan64 = scanar[indexPath.row]
//            vc.screenshot = self.view.takeScreenshot()
//        }else {
//            vc.scan64 = scanar[indexPath.row]
//            vc.screenshot = self.view.takeScreenshot()
//        }
        if onlyfacescan == true {
            if indexPath.row == 3  {
                print(indexPath.row)
            }else if indexPath.row == 4   {
                print(indexPath.row)
                
            }else if  indexPath.row == 6 {
                print(indexPath.row)
            }else if indexPath.row == 7 {
                print(indexPath.row)
                
            } else if indexPath.row == 8 {
                print(indexPath.row)
                
            }
            else if indexPath.row == 0 {
                let vc = UIStoryboard.init(name: "Review", bundle: Bundle.main).instantiateViewController(withIdentifier: "ReviewimageVC") as! ReviewimageVC
                scanimagear = scanar
                
                scanimagear.remove(at: 3)
                scanimagear.remove(at: 3)
                scanimagear.remove(at: 3)
                scanimagear.remove(at: 3)
                scanimagear.remove(at: 3)
                scanimagear.remove(at: 3)
                vc.imageArray = scanimagear
                vc.isfrommyscan = true
                vc.index = 0
                vc.delegate = self
                navigationController?.navigationBar.isHidden = true
                navigationController?.pushViewController(vc, animated: true)
            }else if indexPath.row == 1{
                let vc = UIStoryboard.init(name: "Review", bundle: Bundle.main).instantiateViewController(withIdentifier: "ReviewimageVC") as! ReviewimageVC
                scanimagear = scanar
                scanimagear.remove(at: 3)
                scanimagear.remove(at: 3)
                scanimagear.remove(at: 3)
                scanimagear.remove(at: 3)
                scanimagear.remove(at: 3)
                scanimagear.remove(at: 3)
                vc.delegate = self
                vc.imageArray = scanar
                vc.isfrommyscan = true
                vc.index = 1
                navigationController?.navigationBar.isHidden = true
                navigationController?.pushViewController(vc, animated: true)
            }
            else if indexPath.row == 2{
                let vc = UIStoryboard.init(name: "Review", bundle: Bundle.main).instantiateViewController(withIdentifier: "ReviewimageVC") as! ReviewimageVC
                scanimagear = scanar
                scanimagear.remove(at: 3)
                scanimagear.remove(at: 3)
                scanimagear.remove(at: 3)
                scanimagear.remove(at: 3)
                scanimagear.remove(at: 3)
                scanimagear.remove(at: 3)
                vc.delegate = self
                vc.imageArray = scanimagear
                vc.isfrommyscan = true
                vc.index = 2
                navigationController?.navigationBar.isHidden = true
                navigationController?.pushViewController(vc, animated: true)
            }
                
                
                // scanar.remove(at: 6)
                //            scanar.remove(at: 7)
                //            scanar.remove(at: 8)
              
                
                
            }
        else  if onlyteethscan == true {
            if indexPath.row == 0 || indexPath.row == 1 || indexPath.row == 2 || indexPath.row == 4  {
                
            }else
                if indexPath.row == 3{
                scanimagear = scanar
                scanimagear.remove(at: 4)
                scanimagear.remove(at: 0)
                scanimagear.remove(at: 0)
                scanimagear.remove(at: 0)
                    let vc = UIStoryboard.init(name: "Review", bundle: Bundle.main).instantiateViewController(withIdentifier: "ReviewimageVC") as! ReviewimageVC
                vc.delegate = self
                    vc.imageArray = scanimagear
                    vc.index = 0
                vc.isfrommyscan = true
                    navigationController?.navigationBar.isHidden = true
                    navigationController?.pushViewController(vc, animated: true)
                }
                else if indexPath.row == 5 {
                    scanimagear = scanar
                    scanimagear.remove(at: 4)
                    scanimagear.remove(at: 0)
                    scanimagear.remove(at: 0)
                    scanimagear.remove(at: 0)
                    let vc = UIStoryboard.init(name: "Review", bundle: Bundle.main).instantiateViewController(withIdentifier: "ReviewimageVC") as! ReviewimageVC
                    vc.delegate = self
                    vc.imageArray = scanimagear
                    vc.index = 1
                    vc.isfrommyscan = true
                    navigationController?.navigationBar.isHidden = true
                    navigationController?.pushViewController(vc, animated: true)
                }
                else if indexPath.row == 6 {
                    scanimagear = scanar
                    scanimagear.remove(at: 4)
                    scanimagear.remove(at: 0)
                    scanimagear.remove(at: 0)
                    scanimagear.remove(at: 0)
                    let vc = UIStoryboard.init(name: "Review", bundle: Bundle.main).instantiateViewController(withIdentifier: "ReviewimageVC") as! ReviewimageVC
                    vc.imageArray = scanimagear
                    vc.delegate = self
                    vc.index = 2
                    vc.isfrommyscan = true
                    navigationController?.navigationBar.isHidden = true
                    navigationController?.pushViewController(vc, animated: true)
                }else  if indexPath.row == 7 {
                    scanimagear = scanar
                    scanimagear.remove(at: 4)
                    scanimagear.remove(at: 0)
                    scanimagear.remove(at: 0)
                    scanimagear.remove(at: 0)
                    let vc = UIStoryboard.init(name: "Review", bundle: Bundle.main).instantiateViewController(withIdentifier: "ReviewimageVC") as! ReviewimageVC
                    vc.imageArray = scanimagear
                    vc.delegate = self
                    vc.index = 3
                    vc.isfrommyscan = true
                    navigationController?.navigationBar.isHidden = true
                    navigationController?.pushViewController(vc, animated: true)
                }
                else if indexPath .row == 8 {
                    scanimagear = scanar
                    scanimagear.remove(at: 4)
                    scanimagear.remove(at: 0)
                    scanimagear.remove(at: 0)
                    scanimagear.remove(at: 0)
                    let vc = UIStoryboard.init(name: "Review", bundle: Bundle.main).instantiateViewController(withIdentifier: "ReviewimageVC") as! ReviewimageVC
                    vc.imageArray = scanimagear
                    vc.delegate = self
                    vc.index = 4
                    vc.isfrommyscan = true
                    navigationController?.navigationBar.isHidden = true
                    navigationController?.pushViewController(vc, animated: true)
                }
               
                
                
            }
        
        else{
            if indexPath.row == 4 {
                
            }else {
                scanimagear = scanar
                let vc = UIStoryboard.init(name: "Review", bundle: Bundle.main).instantiateViewController(withIdentifier: "ReviewimageVC") as! ReviewimageVC
                scanimagear.remove(at: 4)
                vc.imageArray = scanimagear
                vc.delegate = self
                vc.index = indexPath.row
                vc.isfrommyscan = true
                navigationController?.navigationBar.isHidden = true
                navigationController?.pushViewController(vc, animated: true)
            }
        }
        
        
    }
    func removeimages() {
        scanimagear.removeAll()
    }
}


   


class MyScanDisplayCVC:UICollectionViewCell {
    @IBOutlet weak var displayImage: UIImageView!
}
