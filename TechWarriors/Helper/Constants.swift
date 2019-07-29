//
//  Constants.swift
//  TechWarriors
//
//  Created by Mishra, Pooja (Cognizant) on 17/06/19.
//  Copyright © 2019 Mishra, Pooja (Cognizant). All rights reserved.
//

import UIKit

//URLs
let baseURL = "https://3f2905d2-a6ef-4c47-abc0-694a7727f116-bluemix.cloudant.com/callforcode/"
let listURL = "_all_docs?include_docs=true"
let APIKey = "3f2905d2-a6ef-4c47-abc0-694a7727f116-bluemix"
let APISecret = "92fc94c83611a166320c02d7f716cab693eeaada4d341c2fd2aa18d4b63d5534"
//Global properties
let delegate : AppDelegate = UIApplication.shared.delegate as! AppDelegate
let window : UIWindow = delegate.window!
//Global Variables
let mainColor = Utilily.colorFromHexString(hex: "CA0009")
let musturdColor = Utilily.colorFromHexString(hex: "F19F00")
let regularFont14 = UIFont(name: "Museo-500", size: 14)
let regularFont16 = UIFont(name: "Museo-500", size: 16)
let regularFont18 = UIFont(name: "Museo-500", size: 18)
let regularFont20 = UIFont(name: "Museo-500", size: 20)
let loginKey = "loggedIn"
let notificationKey = "notification"
let notificationAfterLogoutKey = "notification_after_logout"
let alarmKey = "alarm"
let locationKey = "location"
