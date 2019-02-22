//
//  ApiManager.swift
//  Hitesh_iOS_Assignment
//
//  Created by Hitesh Veshnav on 22/02/19.
//  Copyright © 2019 Hitesh Veshnav. All rights reserved.
//

import Foundation
import Alamofire

// MARK: - typealias
/*
  Completion block called after success or failure of api
 */
typealias apiCompletionBlock = ((_ reponse: [AnyObject], _ statuscode: Int, _ errormsg: String) ->())

class ApiManager: NSObject {
    
    // MARK: - Instance
    /*
      Api manager instance
    */
    static let instance = ApiManager()
    
    // MARK: - APi Call method
    /*
     Call api with params
     url: request url
     method: post, get etc
     parm: parameters
     fromVC: indicate view controller which called this function
     block: completion block
     */
    func callApi(url : String, method : HTTPMethod, param : [String : String], fromVC: UIViewController, block : @escaping apiCompletionBlock){
        
        Alamofire.request(url, method: method, parameters: param, headers: nil).responseJSON { (response) in
            
            switch(response.result) {
                
            case .success(_):
                if let data = response.result.value {
                    print(data)
                    block((data as AnyObject) as! [AnyObject], (response.response?.statusCode)!, "")
                }
                break
                
            case .failure(_):
                block([], 400, response.result.error!.localizedDescription)
                if let data = response.data {
                    let json = String(data: data, encoding: String.Encoding.utf8)
                    print(json ?? "")
                }
                print(response.result.error ?? "")
                
                break
            }
        }
    }
}
