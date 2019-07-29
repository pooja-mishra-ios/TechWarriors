//
//  SettingCell.swift
//  TechWarriors
//
//  Created by Mishra, Pooja (Cognizant) on 04/07/19.
//  Copyright © 2019 Mishra, Pooja (Cognizant). All rights reserved.
//

import UIKit

protocol SettingCellDelegate : class {
    func settingUpdated(cell: SettingCell, shouldEnable: Bool)
}

class SettingCell: UITableViewCell {

    @IBOutlet weak var titleLbl : UILabel!
    @IBOutlet weak var subtitleLbl : UILabel!
    @IBOutlet weak var settingSwitch : UISwitch!
    @IBOutlet weak var checkbox : UIButton!
    weak var delegate : SettingCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        settingSwitch.layer.cornerRadius = round(settingSwitch.frame.height) / 2
        settingSwitch.transform = CGAffineTransform(scaleX: 0.81, y: 0.81)
        checkbox.imageView?.tintColor = mainColor
    }

    @IBAction func checkboxTapped() {
        checkbox.isSelected = !checkbox.isSelected
        delegate?.settingUpdated(cell: self, shouldEnable: checkbox.isSelected)
    }
    
    @IBAction func switchTapped() {
        delegate?.settingUpdated(cell: self, shouldEnable: settingSwitch.isOn)
    }
    
    func setupWithSwitch(setting: [String : Any]) {
        let isConfigurable : NSNumber = setting["configurable"] as! NSNumber
        let isEnabled : NSNumber = setting["enabled"] as! NSNumber
        titleLbl.text = setting["title"] as? String
        subtitleLbl.text = setting["subtitle"] as? String
        settingSwitch.isHidden = !isConfigurable.boolValue
        settingSwitch.isOn = isEnabled.boolValue
        checkbox.isHidden = true
    }
    
    func setupWithCheckbox(setting: [String : Any]) {
        let isConfigurable : NSNumber = setting["configurable"] as! NSNumber
        let isEnabled : NSNumber = setting["enabled"] as! NSNumber
        titleLbl.text = setting["title"] as? String
        subtitleLbl.text = setting["subtitle"] as? String
        checkbox.isHidden = !isConfigurable.boolValue
        checkbox.isSelected = isEnabled.boolValue
        settingSwitch.isHidden = true
    }
    
}
