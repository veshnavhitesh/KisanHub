//
//  YearCell.swift
//  Hitesh_iOS_Assignment
//
//  Created by Hitesh Veshnav on 22/02/19.
//  Copyright © 2019 Hitesh Veshnav. All rights reserved.
//

import UIKit

class YearCell: UICollectionViewCell {
    
    // @IBOutlet
    @IBOutlet weak var lblYear: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.layer.cornerRadius = self.frame.size.height/2
    }
    
    /*
     Set cell content
     */
    func setContentsForYearCell(_ title: String) {
        lblYear.text = title
    }
}
