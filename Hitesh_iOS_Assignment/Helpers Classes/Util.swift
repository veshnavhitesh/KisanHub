//
//  Util.swift
//  Hitesh_iOS_Assignment
//
//  Created by Hitesh Veshnav on 21/02/19.
//  Copyright © 2019 Hitesh Veshnav. All rights reserved.
//

import UIKit
import Foundation

// MARK: - typealias
/*
 Alertaction handler
 */
typealias alertAction = (UIAlertAction) -> ()

class Util: NSObject {
    /*
     return NSLocalizedString string
     */
    static func returnLocalizableStringValue(_ key: String) -> String {
        return NSLocalizedString(key, comment: "")
    }
    
    // MARK: - Show Alert
    /*
     Show alert with title, message button string text and action handler
     */
    static func showAlertWithOneButtonTitle(strTitle: String, strMessage: String, strBtnTitle: String, buttonHandler: @escaping alertAction, viewController: UIViewController) {
        
        let controller = UIAlertController(title: strTitle, message: strMessage, preferredStyle: .alert)
        
        let action = UIAlertAction(title: strBtnTitle, style: .default, handler: buttonHandler)
        
        controller.addAction(action)
        
        viewController.present(controller, animated: true, completion: nil)
    }
}

/*
 reuseIdentifier for collection view cell and table view cell using extension
 */

// MARK: - extension UITableViewCell
extension UITableViewCell {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

// MARK: - extension UICollectionViewCell
extension UICollectionViewCell {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

