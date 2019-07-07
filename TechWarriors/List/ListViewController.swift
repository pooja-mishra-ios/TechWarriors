//
//  ListViewController.swift
//  TechWarriors
//
//  Created by Mishra, Pooja (Cognizant) on 17/06/19.
//  Copyright © 2019 Mishra, Pooja (Cognizant). All rights reserved.
//

import UIKit

class ListViewController: UIViewController, APIManagerDelegate, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, UIPopoverPresentationControllerDelegate, OptionsViewControllerDelegate {
    
    @IBOutlet weak var loader : UIActivityIndicatorView!
    @IBOutlet weak var tableView : UITableView!
    @IBOutlet weak var filterBtn : UIButton!
    
    var employeeList = [[String : Any]]()
    var filteredEmployees = [[String : Any]]()
    
    let cellIdentifier = "EmployeeCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib.init(nibName: "EmployeeCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
        loadData()
    }
    
    @IBAction func filterTapped() {
        let optionsController : OptionsViewController = storyboard?.instantiateViewController(withIdentifier: "OptionsViewController") as! OptionsViewController
        optionsController.delegate = self
        optionsController.modalPresentationStyle = .popover
        let popover = optionsController.popoverPresentationController
        popover?.permittedArrowDirections = .up
        popover?.delegate = self
        popover?.sourceView = filterBtn
        popover?.sourceRect = CGRect(x: filterBtn.frame.width/2, y:filterBtn.frame.height - 10 , width: 0, height: 0)
        present(optionsController, animated: true, completion: nil)
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        
        return UIModalPresentationStyle.none
    }
    
    func loadData() {
        loader.startAnimating()
        let apiManager = APIManager.shared()
        apiManager.delegate = self
        apiManager.fetchData(urlString: listURL)
    }
    
    // MARK: - APIManagerDelegate
    func responseReceived(response: URLResponse?, data: Data?, error: Error?) {
        if error != nil {
            Utilily.showErrorAlert(message: (error?.localizedDescription)!)
        } else {
            guard let data = data else {
                print("Error: No data to decode")
                return
            }
            
            do {
                let dataDict = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                if let dict = dataDict {
                    employeeList = dict["rows"] as! [[String : Any]]
                    filteredEmployees = employeeList
                }
                
            } catch {
                print(error.localizedDescription)
            }
        }
        DispatchQueue.main.async {
            self.loader.stopAnimating()
            self.tableView.reloadData()
        }
    }
    
    // MARK: - UITableView
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 145.0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredEmployees.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let employee = filteredEmployees[indexPath.row]
        let cell : EmployeeCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! EmployeeCell
        cell.setup(employee: employee)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let profileController : ProfileViewController = storyboard?.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
        profileController.employee = filteredEmployees[indexPath.row]
        navigationController?.pushViewController(profileController, animated: true)
    }
    
    // MARK: - UISearchBar
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.count == 0 {
            filteredEmployees = employeeList
            tableView.reloadData()
        } else {
            let predicate = NSPredicate(format: "doc._id CONTAINS[C] %@ OR doc.emp_name CONTAINS[C] %@ OR doc.seat_number CONTAINS[C] %@ OR doc.odc_number CONTAINS[C] %@ OR doc.odc_number CONTAINS[C] %@",  searchText, searchText, searchText, searchText, searchText);
            filteredEmployees = employeeList.filter { predicate.evaluate(with: $0)};
            tableView.reloadData()
        }
    }
    
    // MARK: - OptionsViewControllerDelegate
    func didSelectOption(controller: OptionsViewController, option: String) {
        if option == "ALL" {
            filteredEmployees = employeeList
            tableView.reloadData()
        } else {
            let predicate = NSPredicate(format: "doc.emp_in_building == %@",  option == "IN" ? NSNumber(value: true) : NSNumber(value: false));
            filteredEmployees = employeeList.filter { predicate.evaluate(with: $0)};
            tableView.reloadData()
        }
    }
}
