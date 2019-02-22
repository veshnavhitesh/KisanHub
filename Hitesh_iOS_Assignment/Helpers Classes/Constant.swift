//
//  Constant.swift
//  Hitesh_iOS_Assignment
//
//  Created by Hitesh Veshnav on 21/02/19.
//  Copyright © 2019 Hitesh Veshnav. All rights reserved.
//

import Foundation

// MARK: - BASE URL
/*
 Indicate application's base request url
 */
let BASE_URL = "https://s3.eu-west-2.amazonaws.com/interview-question-data/metoffice/"

// MARK: - App name
/*
 Indicate application name
 */
let app_name = "Kisan Hub"

// MARK: - User Default
/*
 Globle instance for use defaule
 */
let USERDEFAULT = UserDefaults.standard

//MARK: - Typealias
/*
 Indicate object is array of dictionary
 */
typealias ArrayDictionary = [[String: Any]]

// MARK: - Keys
/*
 All api parse key
 */
let key_value = "value"
let key_year = "year"
let key_month = "month"

// MARK: - enums
/*
 Indicate Locations
 */
enum Locations: Int {
    case UK = 0
    case England
    case Scotland
    case Wales
    /*
     return location string
     */
    func returnLocation() -> String {
        switch self {
        case .UK:
            return "UK"
        case .England:
            return "England"
        case .Scotland:
            return "Scotland"
        case .Wales:
            return "Wales"
        }
    }
}
/*
 Indicate Matric
 */
enum Metric: Int {
    case Tmax = 0
    case Tmin
    case Rainfall
    /*
     return matric string
     */
    func returnMetric() -> String {
        switch self {
        case .Tmax:
            return "Tmax"
        case .Tmin:
            return "Tmin"
        case .Rainfall:
            return "Rainfall"
        }
    }
    /*
     return tuple with image and unit
     */
    func returnImageAndUnits() -> (String, String) {
        switch self {
        case .Tmax:
            return ("sunny", "°C")
        case .Tmin:
            return ("nightCloudy", "°C")
        case .Rainfall:
            return ("rainy", "mm")
        }
    }
}
