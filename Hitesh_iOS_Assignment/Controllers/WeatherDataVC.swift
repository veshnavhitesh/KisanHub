//
//  WeatherDataVC.swift
//  Hitesh_iOS_Assignment
//
//  Created by Hitesh Veshnav on 22/02/19.
//  Copyright © 2019 Hitesh Veshnav. All rights reserved.
//

import UIKit
import ObjectMapper

class WeatherDataVC: BaseVC {
    
    // MARK: - IBOutlets
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tblView: UITableView!
    
    // MARK: - vars
    /*
     Indicate current location selection
     */
    var selectedLocation: Locations!
    /*
     Indicate all weather reports
     */
    var arryAllRports: [WeatherReport]?
    /*
     Indicate current metric selection
     */
    var selectedMetric: Metric? {
        didSet {
            self.checkDataAlreadyParsed()
        }
    }
    /*
     Indicate current year selection
     */
    var selectedYear: Int? {
        didSet {
            filterDataAccordingToYearsAndMatric(selectedYear!)
        }
    }
    /*
     Indicate array of years based on location and metric selection
     */
    var arryYears: [Int]? {
        didSet {
            collectionView.reloadData()
        }
    }
    /*
     Indicate filtered array of perticular year based on location and metric selection
     */
    var arryFilteredRports: [WeatherReport]? {
        didSet {
            tblView.reloadData()
        }
    }
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        defaultSetup()
    }
    
    //MARK: - Custom methods
    func defaultSetup() {
        selectedMetric = .Tmax
        tblView.tableFooterView = UIView()
    }
    /*
     screll collection view's cell center
     */
    func scrollCollectionCell(_ row: Int) {
        collectionView.scrollToItem(at: IndexPath(row: row, section: 0), at: UICollectionView.ScrollPosition.centeredHorizontally, animated: true)
        collectionView.reloadData()
    }
    
    // MARK: - Check for data avaliability
    /*
     check data is already parsed or not
     */
    func checkDataAlreadyParsed() {
        if USERDEFAULT.value(forKey: selectedMetric!.returnMetric() + "-" + selectedLocation.returnLocation()) == nil {
            self.getWeatherData()
        }else {
            if let response = USERDEFAULT.value(forKey: selectedMetric!.returnMetric() + "-" + selectedLocation.returnLocation()) as? [[String : Any]] {
                self.arryAllRports = Mapper<WeatherReport>().mapArray(JSONArray: response)
                if let years = self.arryAllRports?.map({ $0.year }) as? [Int] {
                    self.arryYears = Array(NSOrderedSet(array: years)) as? [Int]
                    self.selectedYear = self.arryYears?.first
                }
            }
        }
    }
    /*
     Filter array for perticular year based on location and metric selection
     */
    func filterDataAccordingToYearsAndMatric(_ year: Int) {
        arryFilteredRports = self.arryAllRports?.filter({ (report) -> Bool in
            report.year! == year
        })
    }
    
    // MARK: - IBActions
    @IBAction func metricSegmentAction(_ sender: UISegmentedControl) {
        selectedMetric = Metric(rawValue: sender.selectedSegmentIndex)
        scrollCollectionCell(0)
    }
}

// MARK: - Api Call
extension WeatherDataVC {
    // Get Weather Data
    /*
     Call api for get weather based on selected location and metrix
     */
    func getWeatherData() {
        
        if !isInternet() { // check isInternet
            Util.showAlertWithOneButtonTitle(strTitle: app_name, strMessage: Util.returnLocalizableStringValue("error_internet_issue"), strBtnTitle: Util.returnLocalizableStringValue("Ok"), buttonHandler: { (action) in
            }, viewController: self)
            return
        }
        
        showSpinner() // show loader
        
        let strSelection = selectedMetric!.returnMetric() + "-" + selectedLocation.returnLocation()
        let apiName = strSelection + ".json"
        ApiManager.instance.callApi(url: BASE_URL + apiName, method: .get, param: ["":""], fromVC: self) { (response, status, error) in
            
            self.hideSpinner() // hide loader
            
            if status == 200 {
                guard response is ArrayDictionary else {
                    print("response not in arry dict)")
                    return
                }
                self.arryAllRports = Mapper<WeatherReport>().mapArray(JSONArray: response as! [[String : Any]])
                if let years = self.arryAllRports?.map({ $0.year }) as? [Int] {
                    self.arryYears = Array(NSOrderedSet(array: years)) as? [Int]
                    self.selectedYear = self.arryYears?.first
                }
                USERDEFAULT.set(self.arryAllRports?.toJSON(), forKey: strSelection)
                USERDEFAULT.synchronize()
            }
            else {
                Util.showAlertWithOneButtonTitle(strTitle: app_name, strMessage: error, strBtnTitle: Util.returnLocalizableStringValue("Ok"), buttonHandler: { (action) in
                }, viewController: self)
            }
        }
    }
}

// MARK: - UITableViewDelegate/UITableViewDataSource
extension WeatherDataVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arryFilteredRports?.count ?? 0
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 43.0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: MonthCell = tableView.dequeueReusableCell(withIdentifier: MonthCell.reuseIdentifier) as! MonthCell
        if let report = arryFilteredRports?[indexPath.row] {
            cell.setContentsForMonthCell(report, selectedMetric ?? .Tmax)
        }
        return cell
    }
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return nil
    }
}

// MARK: - UICollectionViewDelegate/UICollectionDataSource
extension WeatherDataVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.arryYears?.count ?? 0
    }
    func collectionView( _ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: YearCell = collectionView.dequeueReusableCell(withReuseIdentifier: YearCell.reuseIdentifier, for: indexPath) as! YearCell
        cell.alpha =  0.6
        if let year = self.arryYears?[indexPath.row] {
            cell.lblYear.text = String(year)
            cell.alpha = selectedYear == year ? 1 : 0.6
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let year = self.arryYears?[indexPath.row] {
            self.selectedYear = year
            scrollCollectionCell(indexPath.row)
        }
    }
}
