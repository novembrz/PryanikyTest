//
//  ViewModel.swift
//  PryanikyTest
//
//  Created by Дарья on 30.01.2021.
//

import Foundation

protocol MainViewModelType {
    func getData(completion: @escaping() -> ())
    func numberOfRows() -> Int?
    func cellViewModel(forIndexPath indexPath: IndexPath) -> MainCellViewModelType?
}

class MainViewModel: MainViewModelType {
    
    var dataArray: [DataArray] = []
    
    func getData(completion: @escaping() -> ()) {
        NetworkService.fetchData { (model) in
            for el in model.data {
                for i in 0...model.view.count - 2 {
                    if model.view[i] == el.name {
                        self.dataArray.append(el)
                        DispatchQueue.main.async {
                            completion()
                        }
                    }
                }
            }
        }
    }
    
    //MARK: - Cells Methods
    
    func numberOfRows() -> Int? {
        return dataArray.count
    }
    
    func cellViewModel(forIndexPath indexPath: IndexPath) -> MainCellViewModelType? {
        let data = dataArray[indexPath.row]
        return MainCellViewModel(text: data.name)
    }
    
}
