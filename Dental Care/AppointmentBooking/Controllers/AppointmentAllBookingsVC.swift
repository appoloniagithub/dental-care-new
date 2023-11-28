//
//  AppointmentAllBookingsVC.swift
//  Dental Care
//
//  Created by Sanju Mohamed Sageer on 06/04/2023.
//

//import UIKit
//protocol TableViewDelegate: AnyObject {
//    func reloadTableView()
//}
//class AppointmentAllBookingsVC: UIViewController,UITableViewDelegate,UITableViewDataSource,TableViewDelegate {
//    func reloadTableView() {
//        reloadData()
//    }
//    
//    var statustext:String? = "All Booking"
//    @IBOutlet weak var appointmentTable: UITableView!
//    
//    var appointmentgetmodel:appointmentListModel?
//    var delegate:profiledelegate?
//    weak var tabledelegate: TableViewDelegate?
//   
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        getallappointment()
//    }
//   
////    override func viewDidAppear(_ animated: Bool) {
////        if statustext == "All Booking" {
////            appointmentTable.reloadData()
////        }else if statustext == "pending" {
////            appointmentTable.reloadData()
////        }else if statustext == "approved" {
////            appointmentTable.reloadData()
////        }else if statustext == "finished" {
////            appointmentTable.reloadData()
////        }
////    }
//    
//    @IBAction func backButtonAction(_ sender: UIButton) {
//        navigationController?.popViewController(animated: true)
//        delegate?.tabbar()
//    }
//    func reloadData() {
//        
//        appointmentTable.reloadData()
//
//        
//       }
//    func doSomething() {
//        tabledelegate!.reloadTableView()
//       
//       }
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 2
//    }
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if section == 0 {
//           return 1
//        }else {
//           
//            return  appointmentgetmodel?.allBookings.count ?? 0
//        }
//       
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        if indexPath.section == 0 {
//            let cell = tableView.dequeueReusableCell(withIdentifier: "appointmentStatusListTVC") as! appointmentStatusListTVC
//             return cell
//        }else {
//            let cell = tableView.dequeueReusableCell(withIdentifier: "AppointmentListTVC") as! AppointmentListTVC
//            if statustext == "All Booking" {
//                cell.appointmentModeLabel.text = appointmentgetmodel?.allBookings[indexPath.row].consultationType
//                cell.serviceTypeLabel.text = appointmentgetmodel?.allBookings[indexPath.row].serviceName
//                cell.clinicNameLabel.text = appointmentgetmodel?.allBookings[indexPath.row].clinicName
//                if appointmentgetmodel?.allBookings[indexPath.row].status == "Pending" {
//                    cell.statusLabel.text = appointmentgetmodel?.allBookings[indexPath.row].status
//                    cell.statusLabel.textColor = UIColor.red
//                }else {
//                    cell.statusLabel.text = appointmentgetmodel?.allBookings[indexPath.row].status
//                    cell.statusLabel.textColor = UIColor.green
//                    
//                }
//            }else if statustext == "pending" {
//                cell.appointmentModeLabel.text = appointmentgetmodel?.pendingbooking[indexPath.row].consultationType
//                cell.serviceTypeLabel.text = appointmentgetmodel?.pendingbooking[indexPath.row].serviceName
//                cell.clinicNameLabel.text = appointmentgetmodel?.pendingbooking[indexPath.row].clinicName
//                
//            }else if statustext == "approved" {
//                cell.appointmentModeLabel.text = appointmentgetmodel?.confirmedbooking[indexPath.row].consultationType
//                cell.serviceTypeLabel.text = appointmentgetmodel?.confirmedbooking[indexPath.row].serviceName
//                cell.clinicNameLabel.text = appointmentgetmodel?.confirmedbooking[indexPath.row].clinicName
//            }
//            //        cell.appointmentModeLabel.text = appointmentgetmodel?.allBookings[indexPath.row].consultationType
//            //        cell.serviceTypeLabel.text = appointmentgetmodel?.allBookings[indexPath.row].serviceName
//            //        cell.clinicNameLabel.text = appointmentgetmodel?.allBookings[indexPath.row].clinicName
//            //        if appointmentgetmodel?.allBookings[indexPath.row].status == "Pending" {
//            //            cell.statusLabel.text = appointmentgetmodel?.allBookings[indexPath.row].status
//            //            cell.statusLabel.textColor = UIColor.red
//            //        }else {
//            //            cell.statusLabel.text = appointmentgetmodel?.allBookings[indexPath.row].status
//            //            cell.statusLabel.textColor = UIColor.green
//            //
//            //        }
//            
//            return cell
//        }
//    }
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        if indexPath.section == 1 {
//            let vc = UIStoryboard.init(name: "AppointmentStory", bundle:      Bundle.main).instantiateViewController(withIdentifier: "AppointmentBookingDetailVC")   as! AppointmentBookingDetailVC
//            vc.bookingId = appointmentgetmodel?.allBookings[indexPath.row]._id
//     //        vc.scantype = .teethScanwithHelp
//    //        vc.onlyTeethScan = true
//            tabBarController?.tabBar.isHidden = true
//            navigationController?.navigationBar.isHidden = true
//            navigationController?.pushViewController(vc, animated: true)
//        }
//       
//    }
//   
//}
//class appointmentStatusListTVC:UITableViewCell,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout, TableViewDelegate {
//    func reloadTableView() {
//        allbookingvc.reloadData()
//    }
//    func doSomething() {
//        allbookingvc.doSomething()
//        }
//   
//    let vc = UIStoryboard.init(name: "AppointmentStory", bundle:      Bundle.main).instantiateViewController(withIdentifier: "AppointmentAllBookingsVC") as? AppointmentAllBookingsVC
//    var allbookingvc = AppointmentAllBookingsVC()
// 
//    func setTableViewController(_ tableViewController: AppointmentAllBookingsVC) {
//           self.allbookingvc = tableViewController
//        self.allbookingvc.tabledelegate = self
//       }
//    var statusar = ["All Booking","pending","approved","finished"]
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return statusar.count
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AppointmentstatustypeCVC", for: indexPath) as! AppointmentstatustypeCVC
//        cell.statusLabel.text = statusar[indexPath.row]
//        
//          return cell
//    }
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        allbookingvc.statustext = statusar[indexPath.row]
//       // allbookingvc.viewController = vc
//        let tableview = vc?.appointmentTable
//        
//        allbookingvc.reloadTableView()
//      
//        
//       
//    }
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//       
//        let height = collectionView.frame.size.height
//        let width = collectionView.frame.size.width/3
//        return CGSize(width: width,height: 30)
//    }
//    
//   
//}
//
//
//
//
//
//class AppointmentstatustypeCVC:UICollectionViewCell {
//    
//    
//    @IBOutlet weak var statusLabel: UILabel!
//}
