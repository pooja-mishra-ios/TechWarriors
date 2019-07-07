//
//  SettingsViewController.swift
//  TechWarriors
//
//  Created by Mishra, Pooja (Cognizant) on 04/07/19.
//  Copyright © 2019 Mishra, Pooja (Cognizant). All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView : UITableView!

    let cellIdentifier = "SettingCell"
    let footerHeight : CGFloat = 100
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib.init(nibName: "SettingCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
    }
    
    // MARK: - UITableView
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return footerHeight
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footer = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: footerHeight))
        
        let logoutBtn = UIButton(type: .custom)
        logoutBtn.frame = CGRect(x: 20, y: (footerHeight-40)/2, width: (tableView.frame.width - 40), height: 40)
        logoutBtn.setTitle("LOG OUT", for: .normal)
        logoutBtn.titleLabel?.font = regularFont18
        logoutBtn.layer.borderWidth = 1
        logoutBtn.layer.borderColor = mainColor.cgColor
        logoutBtn.setTitleColor(mainColor, for: .normal)
        logoutBtn.addTarget(self, action: #selector(logout), for: .touchUpInside)
        footer.addSubview(logoutBtn)
        
        return footer
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : SettingCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! SettingCell
        if indexPath.row == 0 {
            cell.setup(title: "Passcode Lock", isOn: false, showSwitch: true)
        }
        return cell
    }
    
    @objc func logout() {
        Preferences.shared().removePreference(key: loginKey)
        Utilily.showLogin()
    }
    
}
