//
//  CellViewModel.swift
//  PryanikyTest
//
//  Created by Дарья on 30.01.2021.
//

import Foundation

protocol MainCellViewModelType: class {
    var text: String { get }
}

class MainCellViewModel: MainCellViewModelType {
    var text: String
    
    init(text: String) {
        self.text = text
    }
}
