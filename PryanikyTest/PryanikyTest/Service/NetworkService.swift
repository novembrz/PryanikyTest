//
//  NetworkService.swift
//  PryanikyTest
//
//  Created by Дарья on 30.01.2021.
//

import Foundation
import Alamofire

protocol NetworkServiceProtocol {
    static func fetchData(completion: @escaping (JSONModel) -> Void)
}

class NetworkService: NetworkServiceProtocol {
    
    static func fetchData(completion: @escaping (JSONModel) -> Void) {
        
        AF.request("https://pryaniky.com/static/json/sample.json").responseJSON { (response) in
            guard let data = response.data else {return}
            do {
                let json = try JSONDecoder().decode(JSONModel.self, from: data)
                completion(json)
            } catch let error as NSError{
                print(error.localizedDescription)
            }
        }
    }
}
