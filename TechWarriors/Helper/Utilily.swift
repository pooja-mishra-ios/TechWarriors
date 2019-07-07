//
//  Utilily.swift
//  TechWarriors
//
//  Created by Mishra, Pooja (Cognizant) on 17/06/19.
//  Copyright © 2019 Mishra, Pooja (Cognizant). All rights reserved.
//

import UIKit

class Utilily: NSObject {

    class func showErrorAlert(message : String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Error!", message: message, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: .cancel) { (action:UIAlertAction) in
            }
            alert.addAction(okAction)
            window.rootViewController?.present(alert, animated: true, completion: nil)
        }
    }
    
    class func colorWith(R:Int, G: Int, B:Int) -> UIColor {
        return UIColor(red: CGFloat(R/255), green: CGFloat(G/255), blue: CGFloat(B/255), alpha: 1)
    }
    
    class func showLogin() {
        let storyboard = UIStoryboard.init(name: "Login", bundle: nil)
        let loginController = storyboard.instantiateInitialViewController()
        window.rootViewController = loginController
    }
    
    class func showDashboard() {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let tabbarController = storyboard.instantiateInitialViewController()
        window.rootViewController = tabbarController
    }
    
    class func colorFromHexString (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }

}
