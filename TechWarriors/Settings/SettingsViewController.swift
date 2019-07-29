//
//  SettingsViewController.swift
//  TechWarriors
//
//  Created by Mishra, Pooja (Cognizant) on 04/07/19.
//  Copyright © 2019 Mishra, Pooja (Cognizant). All rights reserved.
//

import UIKit
import CoreLocation

class SettingsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, SettingCellDelegate {

    @IBOutlet weak var tableView : UITableView!

    var settingArr = [[String : Any]]()
    
    let cellIdentifier = "SettingCell"
    let footerHeight : CGFloat = 1
    let headerHeight : CGFloat = 80
    let rowHeight : CGFloat = 80
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib.init(nibName: "SettingCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
        let tableBgView = UIView(frame: tableView.bounds)
        tableBgView.backgroundColor = UIColor.white
        tableView.backgroundView = tableBgView
        setData()
    }
    
    func setData() {
        //notification setting
        var notificationSettings = [[String : Any]]()
        let notifSetting1 = ["title" : "Allow Notifications", "subtitle" : "Allow notifications from admin", "configurable" : NSNumber(value: true), "enabled" : NSNumber(value: Preferences.shared().getPreference(key: notificationKey))] as [String : Any]
        notificationSettings.append(notifSetting1)
        let notifSetting2 = ["title" : "Allow Notifications After Logout", "subtitle" : "You will receive notification after logout", "configurable" : NSNumber(value: true), "enabled" : NSNumber(value: Preferences.shared().getPreference(key: notificationAfterLogoutKey))] as [String : Any]
        notificationSettings.append(notifSetting2)
        let notifSetting3 = ["title" : "Send Notification", "subtitle" : "Send otification to employees", "configurable" : NSNumber(value: false), "enabled" : NSNumber(value: false)] as [String : Any]
        notificationSettings.append(notifSetting3)
        settingArr.append(["Notification" : notificationSettings])
        
        //alarm setting
        var alarmSettings = [[String : Any]]()
        let alarmSetting1 = ["title" : "Enable Alarm", "subtitle" : "Enable alarm in emergency", "configurable" : NSNumber(value: true), "enabled" : NSNumber(value: Preferences.shared().getPreference(key: alarmKey))] as [String : Any]
        alarmSettings.append(alarmSetting1)
        settingArr.append(["Emergency Alarm" : alarmSettings])
        
        //location setting
        var locationSettings = [[String : Any]]()
        let locationSetting1 = ["title" : "Share My Location", "subtitle" : "Allow to share location", "configurable" : NSNumber(value: true), "enabled" : NSNumber(value: Preferences.shared().getPreference(key: locationKey))] as [String : Any]
        locationSettings.append(locationSetting1)
        settingArr.append(["Location" : locationSettings])
        
        //general setting
        var generalSettings = [[String : Any]]()
        let generalSetting1 = ["title" : "Logout", "subtitle" : "", "configurable" : NSNumber(value: false), "enabled" : NSNumber(value: false)] as [String : Any]
        generalSettings.append(generalSetting1)
        settingArr.append(["General" : generalSettings])
    }
    
    // MARK: - UITableView
    func numberOfSections(in tableView: UITableView) -> Int {
        return settingArr.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return headerHeight
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: headerHeight))
        let titleLabel = UILabel(frame: CGRect(x: 20, y: 0, width: header.frame.width-40, height: headerHeight))
        titleLabel.font = regularFont16
        titleLabel.textColor = mainColor
        let mainDict : [String : Any] = settingArr[section] as [String : Any]
        titleLabel.text = mainDict.keys[mainDict.keys.startIndex]
        header.addSubview(titleLabel)
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return footerHeight
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footer = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: footerHeight))
        footer.backgroundColor = (section == tableView.numberOfSections-1) ? UIColor.white : UIColor.lightGray.withAlphaComponent(0.5)
        return footer
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let mainDict : [String : Any] = settingArr[section] as [String : Any]
        let settings : [[String : Any]] = mainDict.values[mainDict.values.startIndex] as! [[String : Any]]
        return settings.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return rowHeight
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : SettingCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! SettingCell
        cell.delegate = self
        let mainDict : [String : Any] = settingArr[indexPath.section] as [String : Any]
        let settings : [[String : Any]] = mainDict.values[mainDict.values.startIndex] as! [[String : Any]]
        let setting = settings[indexPath.row]
        if (indexPath.section == 0) {
            cell.setupWithSwitch(setting: setting)
        } else {
            cell.setupWithCheckbox(setting: setting)
        }
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //logout
        if (indexPath.section == tableView.numberOfSections-1) {
            Preferences.shared().removePreference(key: loginKey)
            Preferences.shared().removePreference(key: notificationKey)
            Preferences.shared().removePreference(key: notificationAfterLogoutKey)
            Preferences.shared().removePreference(key: alarmKey)
            Preferences.shared().removePreference(key: locationKey)
            LocationManager.shared().stop()
            Utilily.showLogin()
        }
    }
    
    // MARK: - SettingCellDelegate
    func settingUpdated(cell: SettingCell, shouldEnable: Bool) {
        if let indexPath = tableView.indexPath(for: cell) {
            if indexPath.section == 0 {
                if indexPath.row == 0 {
                    Preferences.shared().setPreference(value: NSNumber(value: shouldEnable), key: notificationKey)
                } else {
                    Preferences.shared().setPreference(value: NSNumber(value: shouldEnable), key: notificationAfterLogoutKey)
                }
            } else if indexPath.section == 1 {
                Preferences.shared().setPreference(value: NSNumber(value: shouldEnable), key: alarmKey)
            } else if indexPath.section == 2 {
                if shouldEnable {
                    if CLLocationManager.authorizationStatus() == .denied {
                        Utilily.showErrorAlert(message: "Please turn on location to enable this feature")
                    } else {
                        Preferences.shared().setPreference(value: NSNumber(value: false), key: locationKey)
                        LocationManager.shared().start()
                    }
                } else {
                    LocationManager.shared().stop()
                    Preferences.shared().setPreference(value: NSNumber(value: shouldEnable), key: locationKey)
                }
            }
            UserDefaults.standard.synchronize()
        }
    }
}
