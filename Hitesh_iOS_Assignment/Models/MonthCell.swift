//
//  MonthCell.swift
//  Hitesh_iOS_Assignment
//
//  Created by Hitesh Veshnav on 22/02/19.
//  Copyright © 2019 Hitesh Veshnav. All rights reserved.
//

import UIKit

class MonthCell: UITableViewCell {
    
    // @IBOutlet
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lblMonth: UILabel!
    @IBOutlet weak var lblValue: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    /*
     Set cell content
     */
    func setContentsForMonthCell(_ report: WeatherReport, _ selectedMatric: Metric) {
        lblMonth.text = Util.returnLocalizableStringValue("n/a")
        lblValue.text = Util.returnLocalizableStringValue("n/a")
        
        let image = selectedMatric.returnImageAndUnits().0
        let unit = selectedMatric.returnImageAndUnits().1
        imgView.image = UIImage(named: image)
        
        if let month = report.month {
            lblMonth.text = returnMonthsString(month)
        }
        if let value = report.value {
            lblValue.text = String(value) + unit
        }
    }
}

// MARK:- extension MonthCell
extension MonthCell {
    /*
     return month in string
     */
    func returnMonthsString(_ month: Int) -> String {
        switch month {
        case 1:
            return Util.returnLocalizableStringValue("january")
        case 2:
            return Util.returnLocalizableStringValue("february")
        case 3:
            return Util.returnLocalizableStringValue("march")
        case 4:
            return Util.returnLocalizableStringValue("april")
        case 5:
            return Util.returnLocalizableStringValue("may")
        case 6:
            return Util.returnLocalizableStringValue("june")
        case 7:
            return Util.returnLocalizableStringValue("july")
        case 8:
            return Util.returnLocalizableStringValue("august")
        case 9:
            return Util.returnLocalizableStringValue("september")
        case 10:
            return Util.returnLocalizableStringValue("october")
        case 11:
            return Util.returnLocalizableStringValue("november")
        case 12:
            return Util.returnLocalizableStringValue("december")
        default:
            return Util.returnLocalizableStringValue("n/a")
        }
    }
}
