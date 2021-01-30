//
//  DetailViewController.swift
//  PryanikyTest
//
//  Created by Дарья on 30.01.2021.
//

import UIKit

class DetailViewController: UIViewController {
    
    var viewModel: DetailViewModelType?

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel = DetailViewModel()
    }
    
}
