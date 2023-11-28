//
//  FinalReviewVC.swift
//  Dental Care
//
//  Created by Sanju Mohamed Sageer on 27/10/2022.
//

import UIKit
protocol FinalReviewdelegate {
    func viewscanback()
}

class FinalReviewVC: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    var isfromreview:Bool?
    var scanimgarr:[UIImage] = []
    var teethimagearr:[UIImage] = []
    var faceimagearr:[UIImage] = []
    var faceScan64:[String] = []
    var teethScan64:[String] = []
    var isfromfacescan:Bool?
    var isfromteethscan:Bool?
   // var facescan64:[String] = []
    //var teethscan64:[String] = []
    var uploadmodel:submitscanmodel!
    var newchat:newchatmodel!
    var newimagearray:[UIImage] = []
    var onlyTeethScan:Bool?
    var teethimage:String?
    var isallscans:Bool?
    var isfacescanalone:Bool?
    var isfacethscanalone:Bool?
    var isfromviewscan:Bool?
    @IBOutlet weak var backImage: UIImageView!
    var delegate:FinalReviewdelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        if isfromreview == false {
            if isfromfacescan == true {
                buttonStackView.isHidden = true
                homebutton.isEnabled = false
                submitbutton.isEnabled = false
                reviewHeadLabel.text = "Face Scan"
                
            }
            else  if isfromteethscan == true {
                buttonStackView.isHidden = true
                homebutton.isEnabled = false
                submitbutton.isEnabled = false
                reviewHeadLabel.text = "Teeth Scan"
            }}else if isfromviewscan == true {
                buttonStackView.isHidden = false
                homebutton.isEnabled = true
                submitbutton.isEnabled = true
            }
        if DCLanguageManager.sharedInstance.getLanguage() == "en" {
            backImage.image = UIImage(named: "Group 106")
        }else {
            backImage.image = UIImage(named: "right-arrow(1)")
            
        }

    }
   
    @IBOutlet weak var reviewHeadLabel: UILabel!
    @IBOutlet weak var submitbutton: UIButton!
    @IBOutlet weak var homebutton: UIButton!
    @IBOutlet weak var buttonStackView: UIStackView!
    @IBOutlet weak var height: NSLayoutConstraint!
    @IBOutlet weak var buttonstackV: UIStackView!
    @IBAction func backButtonAction(_ sender: UIButton) {
      
//            let vc = UIStoryboard.init(name: "ScanSB", bundle:Bundle.main).instantiateViewController(withIdentifier: "ScanVC")  as! ScanVC//Tabbar  Drtab Home DoctorSB
//            //tabBarController?.tabBar.isHidden = true
//            vc.faceimgarr = faceimagearr
//            vc.teethScanArray = teethimagearr
//            vc.scantype = .teethScan
//            vc.currentTeethState = .completed
//            vc.teethscan64 = teethscan64
//            vc.facescan64 = facescan64
//            vc.isfromreview = true
//            self.navigationController?.navigationBar.isHidden = true
//            self.navigationController?.pushViewController(vc, animated: false)
            delegate?.viewscanback()
            navigationController?.popViewController(animated: true)
            
           
       
      //  navigationController?.popViewController(animated: true)
        
    }
    @IBAction func HomeButtonAction(_ sender: UIButton) {
        let vc = UIStoryboard.init(name: "Home", bundle:      Bundle.main).instantiateViewController(withIdentifier: "CustomTabBarvc")  as! CustomTabBarvc//Tabbar  Drtab Home DoctorSB
        tabBarController?.tabBar.isHidden = true
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.pushViewController(vc, animated: false)
    }
    @IBAction func SubmitButtonAction(_ sender: UIButton) {
        //teethimage = teethscan64
        DispatchQueue.main.async {
            self.uploadscanedimage()
        }
       
        
        
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isfromreview == true {
        return scanimgarr.count
        }
        else {
            if isfromteethscan == true {
                return teethimagearr.count
            }
            else {
              return  faceimagearr.count
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FinalReviewCell", for: indexPath) as! FinalReviewCell
        if isfromreview == true {
            if onlyTeethScan == true {
                cell.ReviewImage.image = scanimgarr[indexPath.row]
                
            }else {
                
        cell.ReviewImage.image = scanimgarr[indexPath.row]
                if indexPath.row == 0 {
                    cell.ReviewImage.transform = cell.ReviewImage.transform.rotated(by: .pi/2)
                }
                else if indexPath.row == 1 {
                    cell.ReviewImage.transform = cell.ReviewImage.transform.rotated(by: .pi/2)
                }
                else if indexPath.row == 2 {
                    cell.ReviewImage.transform = cell.ReviewImage.transform.rotated(by: .pi/2)
                }
               
       
//             else   if indexPath.row == 4 {
//                    cell.ReviewImage.transform = cell.ReviewImage.transform.rotated(by: 3 * (.pi)/2)
//
//                }
            }
            }
        else if isfromviewscan == true {
            if isfromteethscan == true {
                cell.ReviewImage.image = teethimagearr[indexPath.row]
                
            }else {
            cell.ReviewImage.image = faceimagearr[indexPath.row]
                        if indexPath.row == 0 {
                            cell.ReviewImage.transform = cell.ReviewImage.transform.rotated(by: .pi/2)
                        }
                        else if indexPath.row == 1 {
                            cell.ReviewImage.transform = cell.ReviewImage.transform.rotated(by: .pi/2)
                        }
                        else if indexPath.row == 2 {
                            cell.ReviewImage.transform = cell.ReviewImage.transform.rotated(by: .pi/2)
                        }
            }
        }
        else {
            if isfromteethscan == true {
                cell.ReviewImage.image = teethimagearr[indexPath.row]
                cell.ReviewImage.contentMode = .scaleAspectFit
               
               

            }
            else {
                cell.ReviewImage.image = faceimagearr[indexPath.row]
                if indexPath.row == 0 {
                    cell.ReviewImage.transform = cell.ReviewImage.transform.rotated(by: .pi/2)
                }
                else if indexPath.row == 1 {
                    cell.ReviewImage.transform = cell.ReviewImage.transform.rotated(by: .pi/2)
                } else if indexPath.row == 2{
                    cell.ReviewImage.transform = cell.ReviewImage.transform.rotated(by: .pi/2)
                } 
               
            }
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
       
        let height = collectionView.frame.size.height
        let width = collectionView.frame.size.width/3
        return CGSize(width: width, height: 150)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = UIStoryboard.init(name: "Review", bundle: Bundle.main).instantiateViewController(withIdentifier: "ReviewimageVC") as! ReviewimageVC
        //        vc.screenshot = self.view.takeScreenshot()
        vc.isfromreview = isfromreview
        if isfromreview == true {
            
            if isfromteethscan == true {
                
                if indexPath.row == 0 || indexPath.row == 1 || indexPath.row == 2 || indexPath.row == 4  {
                    print("wrong index")
                }else if indexPath.row == 3 {
                    vc.index = 0
                    
                    newimagearray = scanimgarr
                    newimagearray.remove(at: 4)
                    newimagearray.remove(at: 0)
                    newimagearray.remove(at: 0)
                    newimagearray.remove(at: 0)
                    vc.scanimagearray = newimagearray
                }else if indexPath.row == 5 {
                    vc.index = 1
                    
                    newimagearray = scanimgarr
                    newimagearray.remove(at: 4)
                    newimagearray.remove(at: 0)
                    newimagearray.remove(at: 0)
                    newimagearray.remove(at: 0)
                    vc.scanimagearray = newimagearray
                }else if indexPath.row == 6 {
                    vc.index = 2
                    
                    newimagearray = scanimgarr
                    newimagearray.remove(at: 4)
                    newimagearray.remove(at: 0)
                    newimagearray.remove(at: 0)
                    newimagearray.remove(at: 0)
                    vc.scanimagearray = newimagearray
                } else if indexPath.row == 7{
                    vc.index = 3
                    
                    newimagearray = scanimgarr
                    newimagearray.remove(at: 4)
                    newimagearray.remove(at: 0)
                    newimagearray.remove(at: 0)
                    newimagearray.remove(at: 0)
                    vc.scanimagearray = newimagearray
                }else if indexPath.row == 8 {
                    vc.index = 4
                    
                    newimagearray = scanimgarr
                    newimagearray.remove(at: 4)
                    newimagearray.remove(at: 0)
                    newimagearray.remove(at: 0)
                    newimagearray.remove(at: 0)
                    vc.scanimagearray = newimagearray
                }
                
                
            }else if isallscans == true {
                if indexPath.row == 4 {
                    print("wrong index")
                }else {
                    newimagearray = scanimgarr
                    newimagearray.remove(at: 4)
                    vc.index = indexPath.row
                    vc.scanimagearray = newimagearray
                }
                
            }
            else if isfromfacescan == true {
                vc.isfacescan = true
                if indexPath.row == 4 || indexPath.row == 3 || indexPath.row == 5 || indexPath.row == 6 || indexPath.row == 7 || indexPath.row == 8  {
                    print("wrong index")
                }
                if indexPath.row == 0 {
                    vc.index = 0
                    vc.isfacescan = true
                    newimagearray = scanimgarr
                    newimagearray.remove(at: 3)
                    newimagearray.remove(at: 3)
                    newimagearray.remove(at: 3)
                    newimagearray.remove(at: 3)
                    newimagearray.remove(at: 3)
                    newimagearray.remove(at: 3)
                    vc.isfromfacescanalone = isfacescanalone
                    vc.scanimagearray = newimagearray
                   
                }
                else if indexPath.row == 1 {
                    vc.index = 1
                    vc.isfacescan = true
                    newimagearray = scanimgarr
                    newimagearray.remove(at: 3)
                    newimagearray.remove(at: 3)
                    newimagearray.remove(at: 3)
                    newimagearray.remove(at: 3)
                    newimagearray.remove(at: 3)
                    newimagearray.remove(at: 3)
                    vc.isfromfacescanalone = isfacescanalone
                    vc.scanimagearray = newimagearray
                    
                }else if indexPath.row == 2{
                    vc.index = 2
                    vc.isfacescan = true
                    newimagearray = scanimgarr
                    newimagearray.remove(at: 3)
                    newimagearray.remove(at: 3)
                    newimagearray.remove(at: 3)
                    newimagearray.remove(at: 3)
                    newimagearray.remove(at: 3)
                    newimagearray.remove(at: 3)
                    vc.isfromfacescanalone = isfacescanalone
                    vc.scanimagearray = newimagearray
                    
                }
                
            }}
        else if isfromviewscan == true {
            if isfromteethscan == true {
                vc.index = indexPath.row
                newimagearray = teethimagearr
                vc.scanimagearray = newimagearray
            }else {
                newimagearray = faceimagearr
                vc.isfromfacescanalone = isfacescanalone
                vc.scanimagearray = newimagearray
                vc.index = indexPath.row
                vc.isfacescan = true
            }
        }
        else {
            if isfromteethscan == true {
//                if indexPath.row == 0 || indexPath.row == 1 || indexPath.row == 2 || indexPath.row == 4  {
//                    print("wrong index")
//                }else if indexPath.row == 3 {
//                    vc.index = 0
//                    newimagearray = teethimagearr
//                    newimagearray.remove(at: 4)
//                    newimagearray.remove(at: 0)
//                    newimagearray.remove(at: 0)
//                    newimagearray.remove(at: 0)
//                    vc.scanimagearray = newimagearray
//                }else if indexPath.row == 5 {
//                    vc.index = 1
//                    newimagearray = teethimagearr
//                    newimagearray.remove(at: 4)
//                    newimagearray.remove(at: 0)
//                    newimagearray.remove(at: 0)
//                    newimagearray.remove(at: 0)
//                    vc.scanimagearray = newimagearray
//                }else if indexPath.row == 6 {
//                    vc.index = 2
//                    newimagearray = teethimagearr
//                    newimagearray.remove(at: 4)
//                    newimagearray.remove(at: 0)
//                    newimagearray.remove(at: 0)
//                    newimagearray.remove(at: 0)
//                    vc.scanimagearray = newimagearray
//                } else if indexPath.row == 7{
//                    vc.index = 3
//                    newimagearray = teethimagearr
//                    newimagearray.remove(at: 4)
//                    newimagearray.remove(at: 0)
//                    newimagearray.remove(at: 0)
//                    newimagearray.remove(at: 0)
//                    vc.scanimagearray = newimagearray
//                }else if indexPath.row == 8 {
//                    vc.index = 4
//                    newimagearray = teethimagearr
//                    newimagearray.remove(at: 4)
//                    newimagearray.remove(at: 0)
//                    newimagearray.remove(at: 0)
//                    newimagearray.remove(at: 0)
//                    vc.scanimagearray = newimagearray
//                }
                vc.index = indexPath.row
                newimagearray = teethimagearr
                vc.scanimagearray = newimagearray
                
            }
            else if isfromfacescan == true {
               
                newimagearray = faceimagearr
//                newimagearray.remove(at: 3)
//                newimagearray.remove(at: 3)
//                newimagearray.remove(at: 3)
//                newimagearray.remove(at: 3)
//                newimagearray.remove(at: 3)
//                newimagearray.remove(at: 3)
                vc.isfromfacescanalone = isfacescanalone
                vc.scanimagearray = newimagearray
                vc.index = indexPath.row
            }
            else if onlyTeethScan == false {
                
            }
        }
            
            navigationController?.navigationBar.isHidden = true
            navigationController?.pushViewController(vc, animated: true)
        }
        
        
    }


class FinalReviewCell: UICollectionViewCell {
    @IBOutlet weak var ReviewImage: UIImageView!
}
