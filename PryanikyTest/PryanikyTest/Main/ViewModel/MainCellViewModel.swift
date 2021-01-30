//
//  CellViewModel.swift
//  PryanikyTest
//
//  Created by Дарья on 30.01.2021.
//

import Foundation

protocol MainCellViewModelType: class {
    var text: String { get }
    var imgString: String? { get }
}

class MainCellViewModel: MainCellViewModelType {
    var text: String
    var imgString: String?
    
    init(text: String, imgString: String?) {
        self.text = text
        self.imgString = imgString
    }
}
