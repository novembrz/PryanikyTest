//
//  ViewController.swift
//  PryanikyTest
//
//  Created by Дарья on 30.01.2021.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .orange
        
        NetworkService.fetchData { (model) in
            print(model.view)
        }
    }


}

