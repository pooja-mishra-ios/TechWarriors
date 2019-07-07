//
//  OptionsViewController.swift
//  TechWarriors
//
//  Created by Mishra, Pooja (Cognizant) on 06/07/19.
//  Copyright © 2019 Mishra, Pooja (Cognizant). All rights reserved.
//

import UIKit

protocol OptionsViewControllerDelegate: class {
    func didSelectOption(controller: OptionsViewController, option: String)
}

class OptionsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView : UITableView!
    
    weak var delegate: OptionsViewControllerDelegate?
    
    let optionArr = ["ALL", "IN", "OUT"]
    let cellIdentifier = "OptionCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
    }
    
    // MARK: - UITableView
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return optionArr.count
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 1
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footer = UIView(frame: CGRect(x: 100, y: 0, width: tableView.frame.width, height: 1))
        return footer
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        cell.textLabel?.text = optionArr[indexPath.row]
        cell.textLabel?.font = regularFont14
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let del = delegate {
            del.didSelectOption(controller: self, option: optionArr[indexPath.row])
        }
        dismiss(animated: true, completion: nil)
    }
}
