//
//  WeatherReport.swift
//  Hitesh_iOS_Assignment
//
//  Created by Hitesh Veshnav on 22/02/19.
//  Copyright © 2019 Hitesh Veshnav. All rights reserved.
//

import Foundation
import ObjectMapper

/*
 Modele for weather report
 */
class WeatherReport: Mappable {
    
    // WeatherReport details
    /*
     value: indicate value
     year: indicate year
     month: indicate month
     */
    var value: Double?
    var year: Int?
    var month: Int?
    
    /*
     object mpping 
     */
    
    required init?(map: Map) {
        mapping(map: map)
    }
    func mapping(map: Map) {
        value <- map[key_value]
        year <- map[key_year]
        month <- map[key_month]
    }
}
