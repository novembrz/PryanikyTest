//
//  MainCell.swift
//  PryanikyTest
//
//  Created by Дарья on 30.01.2021.
//

import UIKit

class MainCell: UITableViewCell {
    
    static let reuseId = "cellid"
    
    weak var viewModel: MainCellViewModelType? {
        willSet(viewModel) {
            guard let viewModel = viewModel else { return }
            categoryLabel.text = viewModel.text
        }
    }
    
    //MARK: - Create UI
    
    var categoryLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        return label
    }()
    
    //MARK: - Initialization
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        backgroundColor = .clear
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - Setup Constraints
    private func setupConstraints(){
        categoryLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(categoryLabel)
        
        NSLayoutConstraint.activate([
            categoryLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            categoryLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            categoryLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            categoryLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10)
        ])
    }
}

