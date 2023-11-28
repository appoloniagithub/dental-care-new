//
//  AppConstants.swift
//  Appolonia
//
//  Created by Sanju Mohamed Sageer on 24/08/2022.
//

import Foundation
import ARKit
enum faceScaningState {
    case straight
    case right
   // case left
    case completed
   // case middle
    var instructionText:String {
        switch self {
        case .straight:
            return "Please look into the camera"
      //  case .left:
          //  return "Please turn your face left and hold your position"
        case .right:
            return "Please turn your face right and hold your position"
        case .completed:
            return "Please click on Start Teeth Scan when ready"
            
       // case .middle:
         //   return  "Please look into the camera"
        }
    }
    var facealoneinstructiontext:String {
        switch self {
        case .straight:
            return "Please look into the camera"
       // case .left:
        //    return "Please turn your face left"
        case .right:
            return "Please turn your face right"
        case .completed:
            return "Please review the Scan and submit it to doctor"
       // case .middle:
         //   return "Please look into the camera"
        }
    }
    var arabicfaceinstruction:String {
        switch self {
        case .straight:
            return "يرجى النظر في الكاميرا"
        //case .left:
         //   return "من فضلك أدر وجهك إلى اليسار"
        case .right:
            return "من فضلك أدر وجهك إلى اليمين"
        case .completed:
            return "يرجى النقر فوق بدء فحص الأسنان عندما تكون جاهزًا"
     //   case .middle:
         //   return "يرجى النظر في الكاميرا"
        }
    }
    var minimumCommand:String {
        switch self {
        case .straight:
            return "Please move your phone away from face"
       // case .left:
           // return "Turn left to Scan"
        case .right:
            return "Turn Right to Scan "
        case .completed:
           return ""
            
      //  case .middle:
         //   return "Please move your phone away from face"
        }
        
    }
    var arabicfaceminimumcommand:String {
        switch self {
        case .straight:
            return "يرجى تحريك هاتفك بعيدًا عن الوجه"
       // case .left:
       //     return "اتجه يسارا للمسح"
        case .right:
            return "إستدر لليمين للمسح"
        case .completed:
            return ""
      //  case .middle:
          //  return "يرجى تحريك هاتفك بعيدًا عن الوجه"
        }
    }
    var maximumCommand:String {
        switch self {
        case .straight:
            return "Please move your phone closer to your face"
       // case .left:
       //     return "Turn left to Scan"
        case .right:
            return "Turn Right to Scan "
        case .completed:
           return ""
            
      //  case .middle:
        //    return "Please move your phone closer to your face"
        }
        
    }
    var maximumfacearabiccommand:String {
        switch self {
        case .straight:
            return "يرجى تحريك هاتفك بالقرب من وجهك"
      //  case .left:
           // return "اتجه يسارا للمسح"
        case .right:
            return "إستدر لليمين للمسح"
        case .completed:
           return  ""
      //  case .middle:
           // return "يرجى تحريك هاتفك بالقرب من وجهك"
        }
    }
//    var progressStartAngle: CGFloat {
//        switch self {
//        case .straight:
//            return 0.0
//        case .left:
//            return .pi/2
//        case .right:
//            return .pi
//        case .completed:
//            return  .pi * 2
//        case .middle:
//            return .pi
//        }
//    }
//    var progressEndAngle: CGFloat {
//        switch self {
//        case .straight:
//            return .pi/2
//        case .left:
//            return    .pi
//        case .right:
//            return .pi * 2
//        case .completed:
//            return(.pi * 5)/2
//        case .middle:
//            return  (.pi * 3)/2
//        }
//    }

    var audioCommand:String {
        switch self {
        case .straight:
            return "FaStraight"
        //case .left:
       //     return "FaLeftNew"
        case .right:
            return "FaRightNew"
            
        case .completed:
            return  "smileteeth"
      //  case .middle:
           // return "FaMiddle"
        }
    }
    var arfaceaudio:String {
        switch self {
        case .straight:
            return "arfacealonestraight"
       // case .left:
           // return "arfacealoneleft"
        case .right:
           return "arfacealoneright"
        case .completed:
            return "arfacealonecompleted"
    //    case .middle:
        //    return "arfacealonemiddle"
        }
        
    }

    
    var minimumRangez:Float {
        switch self {
            
        case .straight:
            return 0.85
       // case .left:
        //    return 0.88
        case .right:
            return 0.93
        case .completed:
            return 0
      //  case .middle:
       //     return 0.85
        }
    }
    var maximumRangez:Float {
        switch self {
        case .straight:
            return 0.9
     //   case .left:
         //   return 1.5
        case .right:
            return 1.5
        case .completed:
            return 0
     //   case .middle:
        //return 0.9
        }
    }
    var minimumRangeY:Float {
        switch self {
            
        case .straight:
            return  -0.5
       // case .left:
         //   return -0.5
        case .right:
            return -0.41
        case .completed:
            return 0
     //   case .middle:
         //   return -0.5
            
        }
    }
    var maximumRangeY:Float {
        switch self {
        case .straight:
            return 1.1
      //  case .left:
            //return -0.9
        case .right:
            return -0.33
        case .completed:
            return 0
       // case .middle:
                //return 1.1
        }
            
        }
    
    
    var range: (min: Point3D, max: Point3D) {
        switch self {
        
        case .straight:
            return ( Point3D(x: -0.05, y: -0.25, z: 0.83), Point3D(x: 0.05, y: 1, z: 0.9))
      //  case .left:
        //  return (Point3D(x: -0.35, y: -0.4, z: 0.94), Point3D(x: 0.4, y: -0.07, z: 1.5))
            //(Point3D(x: -0.25, y: -0.3, z: 0.95), Point3D(x: 0.35, y: -0.1, z: 1.25))
            //(Point3D(x: -0.5, y: -0.3, z: 0.95), Point3D(x: 0.3, y: -0.03, z: 1.25))
           
        case .right:
            return (Point3D(x: -0.3, y: -0.4, z: 0.95), Point3D(x: 0.4, y: -0.07, z: 1.5))
        case .completed:
            return (Point3D.none, Point3D.none)
      //  case .middle:
          //  return ( Point3D(x: -0.05, y: -0.25, z: 0.83), Point3D(x: 0.05, y: 1, z: 0.95))
        }
    }
    var zrange: (min: Point3D, max: Point3D) {
        switch self {
        case .straight:
            return   (Point3D(x: -1, y: -1, z: 0.85), Point3D(x: 1, y: 1.5, z: 0.9))
      //  case .left:
           // return (Point3D(x: -2, y: -2, z: 0.85), Point3D(x: 2, y: 2, z: 1.5))
        case .right:
            return (Point3D(x: -0.40, y: -0.4, z: 0.93), Point3D(x: 0.24, y: -0.07, z: 1.5))
        case .completed:
            return (Point3D.none, Point3D.none)
     //   case .middle:
       //     return (Point3D(x: -1, y: -1, z: 0.85), Point3D(x: 1, y: 1.5, z: 0.9))
        }

        
    }

   
    func isValid(_ p: Point3D) -> Bool {
        let range = self.range
        let xRange = range.min.x...range.max.x
        let yRange = range.min.y...range.max.y
        let zRange = range.min.z...range.max.z
        return xRange.contains(p.x) && yRange.contains(p.y) && zRange.contains(p.z)
    }
    
    func zisValid(_ p: Point3D) -> Bool {
        let zrange = self.zrange
        let xzRange = zrange.min.x...zrange.max.x
        let yzRange = zrange.min.y...zrange.max.y
        let zzRange = zrange.min.z...zrange.max.z
        return xzRange.contains(p.x) && yzRange.contains(p.y) && zzRange.contains(p.z)
    }
}
enum smiledface {
    case straight
    case smilecompleted
    var instructiontext :String {
        switch self {
        case .straight:
            return "please look at the camera and smile showing the teeth "
        case .smilecompleted:
            return "Please Review the scan and submit it to doctor"
        }
    }
    var smileaudio:String {
        switch self {
        case .straight:
            return "smileteeth"
        case .smilecompleted:
            return "FaCompleted"
        }
    }
}
struct Point3D {
    let x: Float
    let y: Float
    let z: Float
    static let none: Point3D = Point3D(x: 0.0, y: 0.0, z: 0.0)
}

extension simd_float3 {
    var asPoint3D: Point3D {
        return Point3D(x: self.x, y: self.y, z: self.z)
    }
}
enum TeethScaningState {
    case straight
    case left
    case right
    case middle
    case openup
    case opendown
    case completed
    
    
    var instructiontext: String {
        switch self {
        case .straight:
            return "Please hold your phone to scan front teeth"
        case .left:
            return "Now, please hold your face & move your phone to left side"
        case .right:
            return "Now, please hold your face & move your phone to right side "
        case .middle:
            return "Lets take a scan of your upper teeth. Please open your mouth & press start when ready"
        case .openup:
            return "Keep your mouth open & Please move the phone down & slightly tilt it so we can scan upper teeth"
        case .opendown:
            return "Keep your mouth open & Please move the phone up & slightly tilt it so we can scan lower teeth"
        case .completed:
            return "Perfect, its done. You can remove the scope from your mouth & phone now"
        }
        
    }
    var arabicinstructiontext: String {
        switch self {
        case .straight:
            return "يرجى إمساك هاتفك لمسح الأسنان الأمامية"
        case .left:
            return "الآن ، يرجى إمساك وجهك وتحريك هاتفك إلى الجانب الأيسر"
        case .right:
            return "الآن ، يرجى إمساك وجهك وتحريك هاتفك إلى الجانب الأيمن"
        case .middle:
            return "لنقم بإجراء مسح لأسنانك العلوية. يرجى فتح فمك والضغط على ابدأ عندما تكون جاهزًا"
        case .openup:
            return "حافظ على فمك مفتوحًا ويرجى تحريك الهاتف لأسفل وإمالته قليلاً حتى نتمكن من فحص الأسنان العلوية"
        case .opendown:
            return "حافظ على فمك مفتوحًا ويرجى تحريك الهاتف لأعلى وإمالته قليلاً حتى نتمكن من فحص الأسنان السفلية"
        case .completed:
            return "ممتاز ، تم القيام به. يمكنك إزالة النطاق من فمك وهاتفك الآن"
        }
    }
    var timercount:Int {
        switch self {
        case .straight:
            return 2
        case .left:
            return 4
        case .right:
            return 4
        case .middle:
            return 2
        case .openup:
            return 4
        case .opendown:
            return 4
        case .completed:
            return 2
        }
    }
    var stateAudioCommands:String {
        switch self {
        case .straight:
            return "TsStraight"
        case .left:
            return "TsLeft"
        case .right:
            return "TsRight"
        case .middle:
            return   "TsUpper"
        case .openup:
            return "TsUOpen"
        case .opendown:
            return "TsLower"
        case .completed:
            return "TsCompleted"
        }
    }
    var statearAudioCommands:String {
        switch self {
        case .straight:
            return "tsarStraight"
        case .left:
            return "tsarLeft"
        case .right:
            return "tsarRight"
        case .middle:
            return "tsarMiddle"
        case .openup:
            return "tsarOpenup"
        case .opendown:
            return "tsarOpenDown"
        case .completed:
            return "tsarCompleted"
        }
    }
}
enum facetrackingwithhelp {
    case straight
   // case left
    case right
    case smiled
    case completed
    
    var instructiontext:String {
        switch self {
        case .straight:
            return "Please look into the camera and take picture when ready"
     //   case .left:
        //    return "Please ask the patient to turn left and take the picture when ready"
        case .right:
            return "Please ask the patient to turn right and take the picture when ready"
        case .completed:
            return "It's Done. Please click on Start Teeth Scan when ready"
        case .smiled:
            return "Please look at the camera and smile with showing the teeth"
        }
    }
    var facealoneinstructiontext:String {
        switch self {
        case .straight:
            return "Please look into the camera and take picture when ready"
      //  case .left:
       //     return "Please ask the patient to turn left and take the picture when ready"
        case .right:
            return "Please ask the patient to turn right and take the picture when ready"
        case .completed:
            return "Please review the Scan and submit it to doctor"
        case .smiled:
            return "Please look at the camera and smile with showing the teeth"
        }
    }
    var arabicfaceinstructionwithhelp:String {
        switch self {
        case .straight:
            return "يرجى النظر في الكاميرا والتقاط الصور عندما تكون جاهزًا"
        //case .left:
          //  return "يرجى مطالبة المريض بالاستدارة إلى اليسار والتقاط الصورة عندما تكون جاهزًا"
        case .right:
            return "يرجى مطالبة المريض بالانعطاف يمينًا والتقاط الصورة عندما يكون جاهزًا"
        case .completed:
            return "تم التنفيذ. يرجى النقر فوق بدء فحص الأسنان عندما تكون جاهزًا"
        case .smiled:
            return ""
        }
    }
    var audiocommands:String {
        switch self {
        case .straight:
            return "FhStraight"
     //   case .left:
         //   return "FhLeft"
        case .right:
            return "FhRight"
        case .completed:
            return "FaCompleted"
        case .smiled:
            return "FsHelpSmile"
        }
    }
    var arabicaudiocommands:String {
        switch self {
        case .straight:
            return "arfacehelpeStraight"
      //  case .left:
            //return "arfacehelpLeft"
        case .right:
            return "arfacehelpRight"
        case .completed:
            return "arfacehelpCompleted "
        case .smiled:
            return ""
        }
    }
}
enum scanType {
    case faceScanAlone
    case faceScanHelp
    case teethScan
    case smiledface
    case teethScanwithHelp
}
enum teethScanWithHelp {
    case straight
    case left
    case right
    case middle
    case openup
    case opendown
    case completed
    var instructiontext:String {
        switch self {
        case .straight:
            return "Please ask the patient to look straight & bite the teeth. Press Capture button when ready."
        case .left:
            return "Please take the phone to left side of Patient Face and press capture when ready. "
        case .right:
            return "Please take the phone to right side of Patient Face and press capture when ready. "
        case .middle:
            return "Please bring the phone to front side of face and ask patient patient to look straight. Press capture button when ready."
        case .openup:
            return "Please ask the patient to open the mouth and look down so we can capture lower teeth. Press capture button when ready."
        case .opendown:
            return "Please ask the patient to open the mouth and look up so we can capture upper teeth. Press capture button when ready."
        case .completed:
            return "Teeth Scan Completed. Please review scan and submit to doctor."
        }
    }
    var audiocommands:String {
        switch self {
        case .straight:
            return "teethHelpstraight"
        case .left:
            return "teethHelpLeft"
        case .right:
            return "teethHelpRight"
        case .middle:
            return "teethHelpMiddle"
        case .openup:
            return "teethHelpDown"
        case .opendown:
            return "teethHelpUp"
        case .completed:
            return "teethHelpCompleted"
        }
    }
}


//func handleSmile(leftValue: CGFloat, rightValue: CGFloat) {
//   let smileValue = (leftValue + rightValue)/2.0
//   switch smileValue {
//         case _ where smileValue > 0.5:
//          return ""
//      case _ where smileValue > 0.2:
//        
//      default:
//         smileLabel.text = "?"
//   }
//}

//var range:(min:CGFloat,max:CGFloat) {
//    return (x: 0.0, y: 0.0)
//}
//
//func isValid(_ p: CGFloat) -> Bool {
//    let range = range
//    let xRange = range.min.x...range.max.y
//    return xRange.contains(p.x)
//}
//struct CGFloat {
//    let x: Float
//    let y: Float
//
//    static let none: CGFloat = CGFloat(x:0.0, y: 0.0)
//
//}
//enum smile {
//    case straight
//    var range:(min:CGFloat,max:CGFloat) {
//        switch self {
//        case .straight:
//            return range(CGFloat(x: 0.3, y: 0.3))
//        }
//    }
//}
