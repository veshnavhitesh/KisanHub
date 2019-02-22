//
//  BaseVC.swift
//  Hitesh_iOS_Assignment
//
//  Created by Hitesh Veshnav on 21/02/19.
//  Copyright © 2019 Hitesh Veshnav. All rights reserved.
//

import UIKit
import SystemConfiguration

class BaseVC: UIViewController {
    
    // MARK: - @vars
    /*
     For custom activity indicator
     */
    lazy internal var activityIndicator : CustomActivityIndicatorView = {
        let image: UIImage = UIImage(named: "spinnerIcon")!
        return CustomActivityIndicatorView(image: image)
    }()
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    
    // MARK: - Custom methods
    /*
     Show activity indicator
     */
    func showSpinner() { // show loader
        UIApplication.shared.beginIgnoringInteractionEvents()
        activityIndicator.startAnimating()
        activityIndicator.center = view.center
        view.addSubview(activityIndicator)
        UIView.animate(withDuration: 0.2) { () -> Void in
            self.activityIndicator.alpha = 1.0
        }
    }
    /*
     Hide custom activity indicator
     */
    func hideSpinner() { // hide loader
        UIApplication.shared.endIgnoringInteractionEvents()
        activityIndicator.stopAnimating()
        activityIndicator.center = view.center
        UIView.animate(withDuration: 0.2, animations: { () -> Void in
            self.activityIndicator.alpha = 0.0
        }) { (isFinish) -> Void in
            self.activityIndicator.removeFromSuperview()
        }
    }
    
    /*
      Check internet
     */
    func isInternet() -> Bool
    {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
            return false
        }
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        return (isReachable && !needsConnection)
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
