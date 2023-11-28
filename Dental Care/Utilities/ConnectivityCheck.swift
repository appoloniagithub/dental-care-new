//
//  ConnectivityCheck.swift
//  Appolonia
//
//  Created by Sanju Mohamed Sageer on 09/09/2022.
//

import Foundation
import Alamofire
class Connectivity {
     class func isConnectedToInternet() ->Bool {
          return NetworkReachabilityManager()!.isReachable
     }
}
