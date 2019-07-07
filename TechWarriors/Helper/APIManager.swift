//
//  APIManager.swift
//  TechWarriors
//
//  Created by Mishra, Pooja (Cognizant) on 17/06/19.
//  Copyright © 2019 Mishra, Pooja (Cognizant). All rights reserved.
//

import UIKit

protocol APIManagerDelegate : class {
    func responseReceived(response : URLResponse?, data : Data?, error : Error?)
}

class APIManager: NSObject {

    // MARK: - Properties
    weak var delegate : APIManagerDelegate?
    
    // MARK: - Singleton
    private static var sharedAPIManager: APIManager = {
        let apiManager = APIManager()
        return apiManager
    }()
    
    class func shared() -> APIManager {
        return sharedAPIManager
    }
    
    // MARK: - Fetch Data
    func fetchData(urlString : String) {
        let url = URL(string: baseURL+urlString)
        if let url = url {
            let loginString = String(format: "%@:%@", APIKey, APISecret)
            let loginData = loginString.data(using: String.Encoding.utf8)!
            let base64LoginString = loginData.base64EncodedString()
            // create the request
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.setValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")
            let session = URLSession(configuration: .default)
            let dataTask = session.dataTask(with: request) { (data, response, error) in
                self.delegate?.responseReceived(response: response, data: data, error: error)
            }
            dataTask.resume()
        } else {
            self.delegate?.responseReceived(response: nil, data: nil, error: nil)
        }
    }
    
}
