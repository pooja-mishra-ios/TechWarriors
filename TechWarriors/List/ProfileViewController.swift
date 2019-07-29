//
//  ProfileViewController.swift
//  TechWarriors
//
//  Created by Mishra, Pooja (Cognizant) on 06/07/19.
//  Copyright © 2019 Mishra, Pooja (Cognizant). All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView : UITableView!
    
    var employee : [String : Any]?
    
    let photoCellIdentifier = "PhotoCell"
    let detailCellIdentifier = "EmployeeDetailCell"
    let locationCellIdentifier = "LocationCell"
    let photoCellHeight: CGFloat = 160
    let detailCellHeight: CGFloat = 200
    let locationHeaderHeight: CGFloat = 50
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib.init(nibName: "PhotoCell", bundle: nil), forCellReuseIdentifier: photoCellIdentifier)
        tableView.register(UINib.init(nibName: "EmployeeDetailCell", bundle: nil), forCellReuseIdentifier: detailCellIdentifier)
        tableView.register(UINib.init(nibName: "LocationCell", bundle: nil), forCellReuseIdentifier: locationCellIdentifier)
        showData()
    }
    
    func showData() {
        if let emp = employee, let doc : [String : Any] = emp["doc"] as? [String : Any] {
            self.navigationItem.title = doc["emp_name"] as? String
        }
    }
    
    // MARK: - UITableView
    func numberOfSections(in tableView: UITableView) -> Int {
        return employee != nil ? 3 : 0
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 2 ? locationHeaderHeight : 0.1
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let height : CGFloat = section == 2 ? locationHeaderHeight : 0.1
        let header = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: height))
        header.backgroundColor = UIColor.black.withAlphaComponent(0.1)
        if (section == 2) {
            let titleLbl = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: locationHeaderHeight))
            titleLbl.text = "Last Shared Location On Map"
            titleLbl.font = regularFont18
            titleLbl.textAlignment = .center
            titleLbl.textColor = Utilily.colorFromHexString(hex: "000064")
            header.backgroundColor = UIColor.black.withAlphaComponent(0.10)
            header.addSubview(titleLbl)
        }
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return photoCellHeight
        } else if indexPath.section == 1 {
            return detailCellHeight
        } else {
            return tableView.frame.height - (photoCellHeight + detailCellHeight + locationHeaderHeight)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let emp = employee, let doc : [String : Any] = emp["doc"] as? [String : Any] {
            if indexPath.section == 0 {
                let cell : PhotoCell = tableView.dequeueReusableCell(withIdentifier: photoCellIdentifier, for: indexPath) as! PhotoCell
                cell.setup(url: doc["image"] as? String)
                return cell
            } else if (indexPath.section == 1) {
                let cell : EmployeeDetailCell = tableView.dequeueReusableCell(withIdentifier: detailCellIdentifier, for: indexPath) as! EmployeeDetailCell
                cell.setup(employee: emp)
                return cell
            } else {
                let cell : LocationCell = tableView.dequeueReusableCell(withIdentifier: locationCellIdentifier, for: indexPath) as! LocationCell
                if let latitude = doc["emp_latest_latitude"] as? String, let longitude = doc["emp_latest_logitude"] as? String {
                    cell.setup(latitude: latitude, longitude: longitude)
                }
                return cell
            }
        } else {
            return tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        }
    }
}
