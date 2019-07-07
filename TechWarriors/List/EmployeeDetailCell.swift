//
//  EmployeeDetailCell.swift
//  TechWarriors
//
//  Created by Mishra, Pooja (Cognizant) on 07/07/19.
//  Copyright © 2019 Mishra, Pooja (Cognizant). All rights reserved.
//

import UIKit

class EmployeeDetailCell: UITableViewCell {

    @IBOutlet weak var empidLbl : UILabel!
    @IBOutlet weak var nameLbl : UILabel!
    @IBOutlet weak var phoneLbl : UILabel!
    @IBOutlet weak var emergencyContactLbl : UILabel!
    @IBOutlet weak var locationLbl : UILabel!
    @IBOutlet weak var statusLbl : UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setup(employee : [String : Any]) {
        if let doc : [String : Any] = employee["doc"] as? [String : Any] {
            empidLbl.text = doc["_id"] as? String
            nameLbl.text = doc["emp_name"] as? String
            phoneLbl.text = doc["emp_phone"] as? String
            emergencyContactLbl.text = doc["emergency_contact"] as? String
            let seatNumber = doc["seat_number"] as? String
            let ODCNumber = doc["odc_number"] as? String
            let ODCFloor = doc["odc_floor"] as? String
            locationLbl.text =  "Location - " + seatNumber! + ", ODC - " + ODCNumber! + ", Floor - " + ODCFloor!
            let empInBuilding : Bool = doc["emp_in_building"] as? Bool ?? true
            let status = empInBuilding ? "IN" : "OUT"
            let statusStr = "Status - " + status
            let attStr = NSMutableAttributedString(string: statusStr)
            let underscore_range = (statusStr as NSString).range(of: "-")
            let status_range = (statusStr as NSString).range(of: status)
            attStr.addAttributes([NSAttributedString.Key.foregroundColor:musturdColor], range: underscore_range)
            attStr.addAttributes([NSAttributedString.Key.foregroundColor:empInBuilding ? UIColor.green : mainColor], range: status_range)
            statusLbl.attributedText = attStr
        } else {
            empidLbl.text = ""
            nameLbl.text = ""
            locationLbl.text = ""
            statusLbl.text = ""
        }
        
    }
}
