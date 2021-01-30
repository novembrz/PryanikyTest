//
//  MainCell.swift
//  PryanikyTest
//
//  Created by Дарья on 30.01.2021.
//

import UIKit

class MainCell: UITableViewCell {
    
    static let reuseId = "cellid"
    
    //MARK: - ConfigureCell
    
    weak var viewModel: MainCellViewModelType? {
        willSet(viewModel) {
            guard let viewModel = viewModel else { return }
            categoryLabel.text = viewModel.text
            
            if let imgString = viewModel.imgString {
                pryanikyImageView.isHidden = false
                activityIndicator.startAnimating()
                activityIndicator.hidesWhenStopped = true
                
                DispatchQueue.global().async {
                    guard let imageURL = URL(string: imgString) else {return}
                    guard let imageData = try? Data(contentsOf: imageURL) else {return}
                    
                    DispatchQueue.main.async {
                        self.pryanikyImageView.image = UIImage(data: imageData)
                        self.activityIndicator.stopAnimating()
                        self.activityIndicator.isHidden = true
                    }
                }
            }
        }
    }
    
    //MARK: - Create UI
    
    var categoryLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        return label
    }()
    
    var pryanikyImageView: UIImageView = {
        var view = UIImageView()
        view.isHidden = true
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    var activityIndicator: UIActivityIndicatorView = {
        var indicator = UIActivityIndicatorView()
        indicator.isHidden = true
        return indicator
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
        pryanikyImageView.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(categoryLabel)
        addSubview(pryanikyImageView)
        pryanikyImageView.addSubview(activityIndicator)
        
        NSLayoutConstraint.activate([
            categoryLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 40),
            categoryLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            categoryLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            categoryLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -40)
        ])
        
        NSLayoutConstraint.activate([
            pryanikyImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            pryanikyImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            pryanikyImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            pryanikyImageView.widthAnchor.constraint(equalTo: pryanikyImageView.heightAnchor)
        ])
        
        NSLayoutConstraint.activate([
            activityIndicator.centerYAnchor.constraint(equalTo: pryanikyImageView.centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: pryanikyImageView.centerXAnchor)
        ])
    }
}

