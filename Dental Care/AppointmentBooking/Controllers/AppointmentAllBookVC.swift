//
//  AppointmentAllBookVC.swift
//  Dental Care
//
//  Created by Sanju Mohamed Sageer on 01/05/2023.
//

import UIKit
import Kingfisher
protocol appointmentdelegate {
    func reloadtable()
}
class AppointmentAllBookVC: UIViewController,UITableViewDelegate,UITableViewDataSource,appointmentdelegate,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource {
   
    
    var bookingId:String?
    var appointmentgetmodel:appointmentListModel?
    var indexPath:IndexPath?
    var tabbarStatusAR = ["Pending","Confirmed","Cancelled","Completed"]
    var selectedView:Int? = 0
    @IBOutlet weak var appointmentTable: UITableView!
    @IBOutlet weak var statusCV: UICollectionView!
    var delegate:profiledelegate?
    var tabbarstatus:String? = "Pending"
    var isintime:Bool?
    override func viewDidLoad() {
        super.viewDidLoad()
        getallappointment()
     //   getremotetiming()
        
      
    }
 
   
    
    @IBAction func videoButtonAction(_ sender: UIButton) {
        let index = IndexPath(row: (sender as AnyObject).tag, section: 0)
        let vc = UIStoryboard.init(name: "AppointmentStory", bundle:      Bundle.main).instantiateViewController(withIdentifier: "VideoCallVC")   as! VideoCallVC
        vc.roomid = appointmentgetmodel?.allBookings[index.row ].roomId
       // vc.delegate = self
        // vc.scantype = .teethScanwithHelp
        // vc.onlyTeethScan = true
            tabBarController?.tabBar.isHidden = true
            navigationController?.navigationBar.isHidden = true
            navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func rescheduleButtonAction(_ sender: Any) {
        let indexPath = IndexPath(row: (sender as AnyObject).tag, section: 0)
        bookingId = appointmentgetmodel?.allBookings[indexPath.row]._id
        // Use the indexPath as needed
        print("Button tapped in cell at indexPath: \(indexPath)")
        let alertController = UIAlertController(title: "Reschedule", message: "Do you wish to reschedule your Appointment?", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Yes", style: UIAlertAction.Style.default) {
            UIAlertAction in
            NSLog("OK Pressed")
           //self.rescheduleappointment()
            let vc = UIStoryboard.init(name: "AppointmentStory", bundle:      Bundle.main).instantiateViewController(withIdentifier: "AppontmentDeptSelectionVC")   as! AppontmentDeptSelectionVC
          
    //        vc.scantype = .teethScanwithHelp
    //        vc.onlyTeethScan = true
            vc.isfromreschedule = true
            vc.bookingid = self.bookingId
            self.tabBarController?.tabBar.isHidden = true
            self.navigationController?.navigationBar.isHidden = true
            self.navigationController?.pushViewController(vc, animated: true)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel) {
            UIAlertAction in
            NSLog("Cancel Pressed")
        }

        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
    @IBAction func cancelButtonAction(_ sender: UIButton) {
        bookingId = appointmentgetmodel?.allBookings[indexPath?.row ?? 0]._id
        cancelalert()
    }
    
    @IBAction func backButtonAction(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
        delegate?.tabbar()
    }
    @IBAction func bookAppointments(_ sender: UIButton) {
        let vc = UIStoryboard.init(name: "AppointmentStory", bundle:      Bundle.main).instantiateViewController(withIdentifier: "AppontmentDeptSelectionVC")   as! AppontmentDeptSelectionVC
      
//        vc.scantype = .teethScanwithHelp
//        vc.onlyTeethScan = true
        tabBarController?.tabBar.isHidden = true
        navigationController?.navigationBar.isHidden = true
        navigationController?.pushViewController(vc, animated: true)
        
        
    }
    
    func convertedtime(bookingtime:Date) {
        
        
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.timeZone = TimeZone(identifier: "Asia/Dubai")
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC+04:00")
        let currentDate = Date()
        let gsttime = Calendar.current.date(byAdding: .hour, value: 4, to: currentDate)!
    let    propertime  = Calendar.current.date(byAdding: .hour, value: 4, to: bookingtime)
        let onehrtime = dateFormatter.string(from: bookingtime)
        // Get the date and time one hour before
        let oneHourBefore = Calendar.current.date(byAdding: .hour, value: -1, to: gsttime)!
       
        
     // let date = dateFormatter.date(from: onehrtime)
        // Get the date and time one hour after
        let oneHourAfter = Calendar.current.date(byAdding: .hour, value: 1, to: gsttime)!
       // let current =  Date().description(with: .current)
       

        
        // Check the condition
        if #available(iOS 15, *) {
            if propertime! > oneHourBefore && propertime! < oneHourAfter {
                // Condition is true
                print("Current time is within one hour before and after.")
                let cell: AppointmentListTVC = self.appointmentTable.dequeueReusableCell(withIdentifier: "AppointmentListTVC") as! AppointmentListTVC
                cell.images.isHidden = false
                cell.videobutton.isHidden =  false
                isintime = true
                
                
            } else {
                // Condition is false
                let cell: AppointmentListTVC = self.appointmentTable.dequeueReusableCell(withIdentifier: "AppointmentListTVC") as! AppointmentListTVC
                cell.images.isHidden = true
                cell.videobutton.isHidden =  true
                isintime = false
                print("Current time is not within one hour before and after.")
            }
        } else {
            // Fallback on earlier versions
        }
    }
        func dateformatter(bookingtime:String) {
            let dateString = "2023-06-26T06:00:00.709Z"

            // Create a date formatter with the given format
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"

            // Convert the string to a Date object
            guard let date = dateFormatter.date(from: dateString) else {
                print("Invalid date string")
                return
            }
            let dateFormatter2 = DateFormatter()
            dateFormatter2.dateFormat = "yyyy-MM-dd"

            // Format the date to the desired format
            let formattedDate = dateFormatter2.string(from: date)
            print("Formatted Date: \(formattedDate)")

            // Create a date formatter for the desired time format
            let dateFormatter3 = DateFormatter()
            dateFormatter3.dateFormat = "HH:mm:ss"

            // Format the date to the desired format
            let formattedTime = dateFormatter3.string(from: date)
            print("Formatted Time: \(formattedTime)")
            let converteddate = DateFormatter()
            
            converteddate.dateFormat = "HH:mm:ss"
            let datestring =  formattedDate + formattedTime
            let date1 =  converteddate.date(from: datestring)
         //   convertedtime(bookingtime: date1!)
        }

    func UTCToLocal(date:String, fromFormat: String, toFormat: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = fromFormat
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")

        let dt = dateFormatter.date(from: date)
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = toFormat

    return dateFormatter.string(from: dt!)
    }
    func reloadtable() {
        getallappointment()
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }else {
            if tabbarstatus == "All Booking" {
                return  appointmentgetmodel?.allBookings.count ?? 0
            }    else  if tabbarstatus == "Pending" {
                return  appointmentgetmodel?.pendingbooking.count ?? 0
            }else  if tabbarstatus == "Confirmed" {
                return  appointmentgetmodel?.confirmedbooking.count ?? 0
            }else if tabbarstatus == "Cancelled"
            {
                return appointmentgetmodel?.cancelledbooking.count ?? 0
            }else{
                return  appointmentgetmodel?.finshedbooking.count ?? 0
            }
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         
     //   dateformatter(bookingtime: appointmentgetmodel?.allBookings[indexPath.row].time ?? "")
        
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "AppointmentemptyTVC") as! AppointmentemptyTVC
            if tabbarstatus == "Pending" {
                if appointmentgetmodel?.pendingbooking.isEmpty == true {
                    cell.statusLabel.text = "No pending Booking"
                }else {
                    cell.statusLabel.isHidden = true
                }
                
            }else if tabbarstatus == "Confirmed" {
                if appointmentgetmodel?.confirmedbooking.isEmpty == true {
                    cell.statusLabel.text = "No Confirmed Booking"
                }else  {
                    cell.statusLabel.isHidden = true
                }
            } else if tabbarstatus == "Cancelled" {
                if appointmentgetmodel?.cancelledbooking.isEmpty == true {
                    cell.statusLabel.text = "No cancelled Booking"
                }else {
                    cell.statusLabel.isHidden = true
                }
            }else if tabbarstatus == "Completed" {
                if appointmentgetmodel?.finshedbooking.isEmpty == true {
                    cell.statusLabel.text = "No completed Booking"
                }else {
                    cell.statusLabel.isHidden = true
                }
               
            }

            return cell
        }else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "AppointmentListTVC") as! AppointmentListTVC
            cell.reschedulebutton.tag = indexPath.row
            // cell.videobutton.tag =
            cell.reschedulebutton.addTarget(self, action: #selector(rescheduleButtonAction(_:)), for: .touchUpInside)
            cell.cancelbutton.tag = indexPath.row
            cell.cancelbutton.addTarget(self, action: #selector(cancelButtonAction(_:)), for: .touchUpInside)
            cell.videobutton.tag = indexPath.row
            
            //cell.videobutton.tag = appointmentgetmodel?.allBookings[indexPath.row].roomId
            cell.videobutton.addTarget(self, action: #selector(videoButtonAction(_:)), for: .touchUpInside)
            cell.drimage.layer.cornerRadius = cell.drimage.frame.size.width/2
            cell.drimage.clipsToBounds = true
            //        if tabbarstatus == "All Booking" {
            //            let drimage = image_baseURL + (appointmentgetmodel?.allBookings[indexPath.row].image ?? "")
            //            if  appointmentgetmodel?.allBookings[indexPath.row].status == "Pending" || appointmentgetmodel?.allBookings[indexPath.row].status == "Reschedule" {
            //                cell.DrnameLabel.text = "Not Assigned"
            //                cell.drimage.kf.setImage(with: URL(string: appointmentgetmodel?.allBookings[indexPath.row].image ?? ""))
            //                cell.stausLabel.text = appointmentgetmodel?.allBookings[indexPath.row].status
            //                cell.stausView.borderColor = UIColor.orange
            //                cell.stausLabel.textColor = UIColor.orange
            //
            //
            //               cell.deptLabel.text = appointmentgetmodel?.allBookings[indexPath.row].serviceName
            //
            //                cell.clinicNameLabel.text = appointmentgetmodel?.allBookings[indexPath.row].clinicName
            ////                if appointmentgetmodel?.allBookings[indexPath.row].consultationType ==  "Remote" {
            ////                    cell.images.isHidden = false
            ////                    cell.videobutton.isHidden = false
            ////                }else {
            //                    cell.images.isHidden = true
            //
            //                    cell.videobutton.isHidden = true
            //             //   }
            ////                cell.consultationTypeLabel.text = appointmentgetmodel?.allBookings[indexPath.row].consultationType
            //
            //            }else if appointmentgetmodel?.allBookings[indexPath.row].status == "Confirmed"
            //            {
            //                //let formateddate = formatDateandtime(date: (appointmentgetmodel?.allBookings[indexPath.row].time)! )
            //
            //
            ////                let dateFormatter = DateFormatter()
            ////                dateFormatter.dateFormat = "yyyy-MM-dd h:mm a"
            ////
            ////                let dateString = appointmentgetmodel?.allBookings[indexPath.row].date
            ////                let timeString = appointmentgetmodel?.allBookings[indexPath.row].time
            //              //  let wholedate = String(describing: dateString ?? "")  + String(describing: timeString ?? "")
            //
            ////                if let date = dateFormatter.date(from: "\(dateString ?? "") \(timeString ?? "")") {
            ////                    let formattedDateTime = dateFormatter.string(from: date)
            ////                    print(formattedDateTime)
            ////                    convertedtime(bookingtime: date)
            ////                    // Output: "2023-07-19 4:00 PM"
            ////                } else {
            ////                    print("Invalid date or time format")
            ////                }
            ////
            ////                let dateFormatter = DateFormatter()
            ////                dateFormatter.dateFormat = "yyyy-MM-dd h:mm a"
            ////
            ////                let dateString = appointmentgetmodel?.allBookings[indexPath.row].date
            ////                let timeString = appointmentgetmodel?.allBookings[indexPath.row].time
            ////
            ////                if let date = dateFormatter.date(from: "\(dateString ?? "") \(timeString ?? "")") {
            ////                    let formattedDateTime = dateFormatter.string(from: date)
            ////                    print(formattedDateTime) // Output: "2023-07-11 12:15 AM"
            ////                } else {
            ////                    print("Invalid date or time format")
            ////                }
            //
            //
            //
            //
            //            //    /##############################################
            //                let dateFormatter = DateFormatter()
            //                dateFormatter.locale = Locale(identifier: "en_US_POSIX")
            //
            //                dateFormatter.locale = Locale(identifier: "en_AE")
            //               // dateFormatter.locale = Locale(identifier: "en_US_POSIX")
            //                dateFormatter.dateFormat = "yyyy-MM-dd h:mm a"
            //                dateFormatter.timeZone = TimeZone(identifier: "Asia/Dubai")
            //                //dateFormatter.timeZone = TimeZone(abbreviation: "UTC+04:00")
            //                dateFormatter.timeZone = NSTimeZone(name: "GST") as TimeZone?
            //              //  dateFormatter.timeZone = NSTimeZone(name: "") as! TimeZone
            //
            //                let dateString = appointmentgetmodel?.allBookings[indexPath.row].date
            //                let timeString = appointmentgetmodel?.allBookings[indexPath.row].time
            //
            //                if let date1 = dateFormatter.date(from: "\(dateString ?? "") \(timeString ?? "")") {
            //                    let formattedDateTime = dateFormatter.string(from: date1)
            //                    print(formattedDateTime) // Output: "2023-07-11 12:15 AM"
            //                    convertedtime(bookingtime: date1)
            //
            ////                    if let date3 =  formatDateandtime(date: formattedDateTime) {
            ////
            ////                    }else{
            ////
            ////                    }
            //                    //let date2 = dateFormatter.date(from: formattedDateTime)!
            //
            //
            //                     //   convertedtime(bookingtime: date2)
            //
            //
            //
            //                        //#########################
            ////                        let dateAsString = appointmentgetmodel?.allBookings[indexPath.row].date ?? ""
            ////                        let timestring = appointmentgetmodel?.allBookings[indexPath.row].time ?? ""
            ////                        let dateFormatter = DateFormatter()
            ////                        dateFormatter.dateFormat = "yyyy-MM-dd hh:mm a"
            ////                        dateFormatter.timeZone = TimeZone(abbreviation: "GMT+00:00")//Add this
            ////                        let date = dateFormatter.date(from: "\(dateAsString )\(timestring )")
            ////                        print(date!)
            ////                        convertedtime(bookingtime: date!)
            //
            //
            //
            //
            //                } else {
            //                    print("Invalid date or time format")
            //                }
            ////############################################################
            //
            ////                let converteddate = DateFormatter()
            ////                converteddate.timeZone = TimeZone.current
            ////               // converteddate.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
            ////                converteddate.dateFormat = "hh:mm a"
            ////                let date1 =  converteddate.date(from: appointmentgetmodel?.allBookings[indexPath.row].time ?? "")
            //
            //
            //                cell.DrnameLabel.text =  appointmentgetmodel?.allBookings[indexPath.row].doctorName
            //                cell.deptLabel.text = appointmentgetmodel?.allBookings[indexPath.row].serviceName
            //                cell.stausLabel.text = appointmentgetmodel?.allBookings[indexPath.row].status
            //                cell.clinicNameLabel.text = appointmentgetmodel?.allBookings[indexPath.row].clinicName
            //                cell.stausView.borderColor = UIColor.green
            //                cell.stausLabel.textColor = UIColor.green
            //                cell.timeLabel.text = "Time: \(appointmentgetmodel?.allBookings[indexPath.row].time ?? "")"
            //                cell.dateLabel.text = "Date: \(appointmentgetmodel?.allBookings[indexPath.row].date ?? "")"
            //             //   cell.consultationTypeLabel.text = appointmentgetmodel?.allBookings[indexPath.row].consultationType
            //                cell.drimage.kf.setImage(with: URL(string: drimage ))
            //                if appointmentgetmodel?.allBookings[indexPath.row].consultationType ==  "Remote" {
            //                    if isintime == true {
            //                        cell.images.isHidden = false
            //                    }else {
            //                        cell.images.isHidden = true
            //                        cell.videobutton.isHidden = true
            //                    }
            //
            //                }else {
            //                    cell.images.isHidden = true
            //
            //
            //                    cell.videobutton.isHidden = true
            //                }
            //            }else if appointmentgetmodel?.allBookings[indexPath.row].status == "Completed" {
            //                let drimage = image_baseURL + (appointmentgetmodel?.allBookings[indexPath.row].image ?? "")
            //                cell.drimage.kf.setImage(with: URL(string: drimage ))
            //                cell.DrnameLabel.text =  appointmentgetmodel?.allBookings[indexPath.row].doctorName
            //                cell.deptLabel.text = appointmentgetmodel?.allBookings[indexPath.row].serviceName
            //                cell.stausLabel.text = appointmentgetmodel?.allBookings[indexPath.row].status
            //                cell.clinicNameLabel.text = appointmentgetmodel?.allBookings[indexPath.row].clinicName
            //                cell.stausView.borderColor = UIColor.green
            //                cell.stausLabel.textColor = UIColor.green
            //                cell.timeLabel.text = "Time: \(appointmentgetmodel?.allBookings[indexPath.row].time ?? "")"
            //                cell.dateLabel.text = "Date: \(appointmentgetmodel?.allBookings[indexPath.row].date ?? "")"
            //                cell.images.isHidden = true
            //                cell.timeLabel.text = appointmentgetmodel?.allBookings[indexPath.row].time
            //                cell.dateLabel.text = appointmentgetmodel?.allBookings[indexPath.row].date
            //                cell.videobutton.isHidden = true
            //                cell.reschedulebutton.isHidden = true
            //                cell.rescheduleLabel.textColor = UIColor.white
            //                cell.rescheduleAppointmentView.borderWidth = 0
            //                cell.rescheduleAppointmentView.backgroundColor = UIColor.lightGray
            //                cell.cancelAppointmentView.backgroundColor  = UIColor.lightGray
            //                cell.cancelbutton.isHidden = true
            //
            //
            //            }
            //            }
            
            if tabbarstatus == "Pending" {
                // let drimage = image_baseURL + (appointmentgetmodel?.pendingbooking[indexPath.row].image ?? "")
                
                cell.deptLabel.text = appointmentgetmodel?.pendingbooking[indexPath.row].serviceName
                cell.stausLabel.text = appointmentgetmodel?.pendingbooking[indexPath.row].status
                cell.clinicNameLabel.text = appointmentgetmodel?.pendingbooking[indexPath.row].clinicName
                cell.stausView.borderColor = UIColor.orange
                cell.stausLabel.textColor = UIColor.orange
                //  cell.consultationTypeLabel.text = appointmentgetmodel?.pendingbooking[indexPath.row].consultationType
                
                
                cell.images.isHidden = true
                
                cell.videobutton.isHidden = true
                //  cell.timeLabel.isHidden = true
                cell.dateLabel.isHidden = true
                if appointmentgetmodel?.pendingbooking[indexPath.row].status == "Reschedule" {
                    // let drimage = image_baseURL + (appointmentgetmodel?.pendingbooking[indexPath.row].image ?? "")
                    cell.drimage.kf.setImage(with: URL(string: appointmentgetmodel?.pendingbooking[indexPath.row].image ?? ""))
                    cell.DrnameLabel.text =  "Doctor"
                    cell.timeLabel.text = "\(appointmentgetmodel?.pendingbooking[indexPath.row].pdate ?? "")  \(appointmentgetmodel?.pendingbooking[indexPath.row].ptime ?? "") "
                }else {
                    cell.drimage.kf.setImage(with: URL(string: appointmentgetmodel?.pendingbooking[indexPath.row].image ?? ""))
                    cell.DrnameLabel.text =  "Doctor"
                    cell.timeLabel.text = "\(appointmentgetmodel?.pendingbooking[indexPath.row].pdate ?? "")  \(appointmentgetmodel?.pendingbooking[indexPath.row].ptime ?? "") "
                    
                }
            }
            else if tabbarstatus == "Confirmed" {
                cell.timeLabel.isHidden = false
                let drimage = image_baseURL + (appointmentgetmodel?.confirmedbooking[indexPath.row].image ?? "")
                
                
                
                let dateFormatter = DateFormatter()
                dateFormatter.locale = Locale(identifier: "en_US_POSIX")
                
                dateFormatter.locale = Locale(identifier: "en_AE")
                // dateFormatter.locale = Locale(identifier: "en_US_POSIX")
                dateFormatter.dateFormat = "yyyy-MM-dd h:mm a"
                dateFormatter.timeZone = TimeZone(identifier: "Asia/Dubai")
                //dateFormatter.timeZone = TimeZone(abbreviation: "UTC+04:00")
                dateFormatter.timeZone = NSTimeZone(name: "GST") as TimeZone?
                //  dateFormatter.timeZone = NSTimeZone(name: "") as! TimeZone
                
                let dateString = appointmentgetmodel?.allBookings[indexPath.row].date
                let timeString = appointmentgetmodel?.allBookings[indexPath.row].time
                
                if let date1 = dateFormatter.date(from: "\(dateString ?? "") \(timeString ?? "")") {
                    let formattedDateTime = dateFormatter.string(from: date1)
                    print(formattedDateTime) // Output: "2023-07-11 12:15 AM"
                    convertedtime(bookingtime: date1)
                }
                cell.DrnameLabel.text = appointmentgetmodel?.confirmedbooking [indexPath.row].doctorName
                cell.deptLabel.text = appointmentgetmodel?.confirmedbooking[indexPath.row].serviceName
                cell.stausLabel.text = appointmentgetmodel?.confirmedbooking[indexPath.row].status
                cell.clinicNameLabel.text = appointmentgetmodel?.confirmedbooking[indexPath.row].clinicName
                cell.stausView.borderColor = UIColor.green
                cell.stausLabel.textColor = UIColor.green
                //  cell.consultationTypeLabel.text = appointmentgetmodel?.confirmedbooking[indexPath.row].consultationType
                cell.drimage.kf.setImage(with: URL(string: drimage ))
                cell.timeLabel.text =  "\(appointmentgetmodel?.confirmedbooking[indexPath.row].date ?? "") \(appointmentgetmodel?.confirmedbooking[indexPath.row].time ?? "")"
                cell.dateLabel.isHidden = true
                
                if appointmentgetmodel?.confirmedbooking[indexPath.row].consultationType ==  "Remote" {
                    if isintime == true {
                        cell.images.isHidden = false
                    }else {
                        cell.images.isHidden = true
                        cell.videobutton.isHidden = true
                    }
                    
                }else {
                    cell.images.isHidden = true
                    
                    cell.videobutton.isHidden = true
                }
                
            }else if tabbarstatus == "Completed" {
                cell.timeLabel.isHidden = false
                let drimage = image_baseURL + (appointmentgetmodel?.finshedbooking[indexPath.row].image ?? "")
                cell.DrnameLabel.text = appointmentgetmodel?.finshedbooking [indexPath.row].doctorName
                cell.deptLabel.text = appointmentgetmodel?.finshedbooking[indexPath.row].serviceName
                cell.stausLabel.text = appointmentgetmodel?.finshedbooking[indexPath.row].status
                cell.clinicNameLabel.text = appointmentgetmodel?.finshedbooking[indexPath.row].clinicName
                cell.stausView.borderColor = UIColor.green
                cell.stausLabel.textColor = UIColor.green
                //  cell.consultationTypeLabel.text = appointmentgetmodel?.confirmedbooking[indexPath.row].consultationType
                cell.drimage.kf.setImage(with: URL(string: drimage ?? ""))
                cell.images.isHidden = true
                cell.videobutton.isHidden = true
                cell.timeLabel.text =   "\(appointmentgetmodel?.finshedbooking [indexPath.row].date ?? "") \(appointmentgetmodel?.finshedbooking [indexPath.row].time ?? "")"
                cell.dateLabel.isHidden = true
                
              //  cell.reschedulebutton.isHidden = true
                cell.rescheduleLabel.textColor = UIColor.white
                cell.rescheduleAppointmentView.borderWidth = 0
                cell.rescheduleAppointmentView.backgroundColor = UIColor.lightGray
                cell.cancelAppointmentView.backgroundColor  = UIColor.lightGray
                cell.cancelbutton.isHidden = true
                cell.buttonStackView.isHidden = true
            }else if tabbarstatus == "Cancelled" {
                let drimage = image_baseURL + (appointmentgetmodel?.cancelledbooking [indexPath.row].image ?? "")
                cell.DrnameLabel.text = appointmentgetmodel?.cancelledbooking [indexPath.row].doctorName
                cell.deptLabel.text = appointmentgetmodel?.cancelledbooking[indexPath.row].serviceName
                cell.stausLabel.text = appointmentgetmodel?.cancelledbooking[indexPath.row].status
                cell.clinicNameLabel.text = appointmentgetmodel?.cancelledbooking[indexPath.row].clinicName
                cell.stausView.borderColor = UIColor.green
                cell.stausLabel.textColor = UIColor.green
                //  cell.consultationTypeLabel.text = appointmentgetmodel?.confirmedbooking[indexPath.row].consultationType
                cell.drimage.kf.setImage(with: URL(string: drimage ?? ""))
                cell.images.isHidden = true
                cell.videobutton.isHidden = true
                cell.timeLabel.text =   "\(appointmentgetmodel?.cancelledbooking [indexPath.row].date ?? "") \(appointmentgetmodel?.cancelledbooking [indexPath.row].time ?? "")"
                cell.dateLabel.isHidden = true
             //   cell.reschedulebutton.isHidden = true
                cell.rescheduleLabel.textColor = UIColor.white
                cell.rescheduleAppointmentView.borderWidth = 0
                cell.rescheduleAppointmentView.backgroundColor = UIColor.lightGray
                cell.cancelAppointmentView.backgroundColor  = UIColor.lightGray
                cell.cancelbutton.isHidden = true
                cell.buttonStackView.isHidden = true
                
            }
            return cell
        }
      
    }
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let vc = UIStoryboard.init(name: "AppointmentStory", bundle:      Bundle.main).instantiateViewController(withIdentifier: "AppointmentBookingDetailVC")   as! AppointmentBookingDetailVC
            vc.bookingId = appointmentgetmodel?.allBookings[indexPath.row]._id
            vc.appointmentstatus = appointmentgetmodel?.allBookings[indexPath.row].status
            vc.delegate = self
            // vc.scantype = .teethScanwithHelp
            // vc.onlyTeethScan = true
            tabBarController?.tabBar.isHidden = true
            navigationController?.navigationBar.isHidden = true
            navigationController?.pushViewController(vc, animated: true)
            //        }
        
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      return tabbarStatusAR.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AppointmentStatusBarCVC", for: indexPath) as! AppointmentStatusBarCVC
        cell.statusLabel.text = tabbarStatusAR[indexPath.row]
        if selectedView == indexPath.row {
            cell.StatusSelectionView.isHidden = false
        }else {
            cell.StatusSelectionView.isHidden = true
        }
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
       
        let height = collectionView.frame.size.height
        let width = collectionView.frame.size.width/4
        return CGSize(width: width, height: 50
        )
    }
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        ImageViewCV.backgroundColor = UIColor.red
//        pickedar.remove(at: indexPath.row)
//        ImageViewCV.reloadData()
//    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //let indexPath = IndexPath(row: 0, section: 0)
         let cell = self.appointmentTable.cellForRow(at: indexPath) as? AppointmentemptyTVC
        cell?.statusLabel.isHidden = false
            
        selectedView = indexPath.row
        statusCV.reloadData()
        tabbarstatus = tabbarStatusAR[indexPath.row]
        
        
        appointmentTable.reloadData()
    }

    private func cancelalert() {
        let alertController = UIAlertController(title: "Delete", message: "Do you wish to cancel your appointment", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Yes", style: UIAlertAction.Style.default) {
            UIAlertAction in
            NSLog("OK Pressed")
            self.cancelappointment()
        }

        let cancelAction = UIAlertAction(title: "No", style: UIAlertAction.Style.cancel) {
            UIAlertAction in
            NSLog("Cancel Pressed")
        }

        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }


}
class AppointmentListTVC:UITableViewCell {
    @IBOutlet weak var DrnameLabel: UILabel!
    @IBOutlet weak var  deptLabel: UILabel!
    @IBOutlet weak var stausLabel: UILabel!
    
    @IBOutlet weak var consultationTypeLabel: UILabel!
    
    @IBOutlet weak var buttonStackView: UIStackView!
    @IBOutlet weak var stausView: UIView!
    @IBOutlet weak var cancelAppointmentView: UIView!
    @IBOutlet weak var rescheduleAppointmentView: UIView!
    @IBOutlet weak var reschedulebutton: UIButton!
    @IBOutlet weak var cancelbutton: UIButton!
    @IBOutlet weak var drimage: UIImageView!
    @IBOutlet weak var rescheduleLabel: UILabel!
    @IBOutlet weak var clinicNameLabel: UILabel!
    @IBOutlet weak var videobutton: UIButton!
    @IBOutlet weak var cancelLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var images: UIImageView!
}
class AppointmentStatusBarCVC:UICollectionViewCell {
  
    @IBOutlet weak var statusLabel: UILabel!
    
    @IBOutlet weak var StatusSelectionView: UIView!
    
   
}
class AppointmentemptyTVC:UITableViewCell {
    @IBOutlet weak var statusLabel: UILabel!
}

