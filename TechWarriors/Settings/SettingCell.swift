//
//  SettingCell.swift
//  TechWarriors
//
//  Created by Mishra, Pooja (Cognizant) on 04/07/19.
//  Copyright © 2019 Mishra, Pooja (Cognizant). All rights reserved.
//

import UIKit

class SettingCell: UITableViewCell {

    @IBOutlet weak var titleLbl : UILabel!
    @IBOutlet weak var settingSwitch : UISwitch!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setup(title: String, isOn: Bool, showSwitch: Bool) {
        titleLbl.text = title
        settingSwitch.isHidden = !showSwitch
        if showSwitch {
            settingSwitch.isOn = isOn
        }
    }
    
}
