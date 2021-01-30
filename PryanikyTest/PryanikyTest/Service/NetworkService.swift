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



/*
struct NetworkService {
    
    static func fetchData(completion: @escaping (JSONModel) -> Void) {
        
        let urlString = "https://pryaniky.com/static/json/sample.json"
        guard let url = URL(string: urlString) else { return }
        
        let session = URLSession.shared
        let task = session.dataTask(with: url) { (data, _, error) in
            guard let data = data else {
                print(error!.localizedDescription)
                return
            }
            print(data)
            
            do{
                let decoder = JSONDecoder()
                let json = try decoder.decode(JSONModel.self, from: data)
                completion(json)
                
            }catch let error as NSError{
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
}
 */
