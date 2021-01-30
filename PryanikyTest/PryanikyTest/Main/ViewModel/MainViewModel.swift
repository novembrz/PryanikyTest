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
    func didSelectedRow(forIndexPath indexPath: IndexPath)
}

class MainViewModel: MainViewModelType {
    
    var dataArray: [DataArray] = []
    var variants: [Variants] = []
    
    var dataText: String?
    var imgString: String?
    
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
        if !variants.isEmpty {
            return variants.count
        } else if dataText != nil {
            return 1
        }else {
            return dataArray.count
        }
    }
    
    func cellViewModel(forIndexPath indexPath: IndexPath) -> MainCellViewModelType? {
        if !variants.isEmpty {
            let variant = variants[indexPath.row]
            return MainCellViewModel(text: variant.text, imgString: nil)
        } else if let text = dataText, let imgString = imgString {
            return MainCellViewModel(text: text, imgString: imgString)
        } else if let text = dataText{
            return MainCellViewModel(text: text, imgString: nil)
        } else {
            let data = dataArray[indexPath.row]
            return MainCellViewModel(text: data.name, imgString: nil)
        }
    }
    
    func didSelectedRow(forIndexPath indexPath: IndexPath) {
        
        let data = dataArray[indexPath.row]
        
        if variants.isEmpty {
            DispatchQueue.main.async {
                if let variants = data.data.variants {
                    self.variants.append(contentsOf: variants)
                } else if let text = data.data.text, let imgString = data.data.url{
                    self.dataText = text
                    self.imgString = imgString
                } else if let text = data.data.text {
                    self.dataText = text
                }
            }
        }
    }
    
}
