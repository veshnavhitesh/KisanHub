//
//  SelectLocationVC.swift
//  Hitesh_iOS_Assignment
//
//  Created by Hitesh Veshnav on 21/02/19.
//  Copyright © 2019 Hitesh Veshnav. All rights reserved.
//

import UIKit

class SelectLocationVC: UIViewController {
    
    // MARK: - IBOutlet
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var btnChoose: UIButton!
    @IBOutlet weak var btnChooseCenter: NSLayoutConstraint!
    
    // MARK: - vars
    /*
     Indicate all loactions
     */
    var locations: [String] = [] {
        didSet {
            tblView.isHidden = false
            tblView.reloadData()
        }
    }
    /*
     Indicate current selected location
     */
    var selectedLocation: Locations? {
        didSet {
            btnChoose.setTitle("Click here to countinue with " + (selectedLocation?.returnLocation())!, for: .normal)
            tblView.reloadData()
        }
    }
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "navigateToWeatherDataVC" {
            let vc = segue.destination as! WeatherDataVC
            vc.selectedLocation = selectedLocation
        }
    }
    
    // MARK: - IBActions
    @IBAction func chooseLocationAction(_ sender: UIButton) {
        if locations.count <= 0 {
            UIView.animate(withDuration: 1.0, animations: {
                self.btnChoose.setTitle("", for: .normal)
                self.btnChooseCenter.constant = self.tblView.frame.height/2 + self.btnChoose.frame.height/2 + 30
            }) { (successs) in
                self.locations = NSLocalizedString("location_list", comment: "").components(separatedBy: ",")
            }
        }else {
            performSegue(withIdentifier: "navigateToWeatherDataVC", sender: nil)
        }
    }
    
}

// MARK: - UITableViewDelegate/UITableViewDataSource
extension SelectLocationVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locations.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 43.0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
        cell.textLabel?.text = locations[indexPath.row]
        cell.accessoryType = indexPath.row == selectedLocation?.rawValue ? .checkmark : .none
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedLocation = Locations(rawValue: indexPath.row)
    }
}
