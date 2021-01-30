//
//  MainViewController.swift
//  PryanikyTest
//
//  Created by Дарья on 30.01.2021.
//

import UIKit

class MainViewController: UIViewController {
    
    var viewModel: MainViewModelType?
    var tableView: UITableView!
    var backButton: UIBarButtonItem!

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = MainViewModel()
        createTableView()
        loadData()
        setupSearchBar()
    }
    
    //MARK: - View Logic
    
    private func loadData(){
        viewModel?.getData { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
    
    @objc func backButtonAction(){
        viewModel?.backButtonAction{ [weak self] in
            DispatchQueue.main.async {
                self?.backButton.isEnabled = false
                self?.tableView.reloadData()
            }
        }
    }
}

//MARK: - Setup UI

extension MainViewController {
    
    private func createTableView() {
        tableView = UITableView(frame: view.bounds)
        view.addSubview(tableView)
        tableView.register(MainCell.self, forCellReuseIdentifier: MainCell.reuseId)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 100
    }
    
    private func setupSearchBar() {
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.tintColor = .orange
        navigationItem.title = "Пряники"
        
        backButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(backButtonAction))
        backButton.isEnabled = false
        navigationItem.rightBarButtonItem = backButton
    }
}

//MARK: - UITableViewDelegate, UITableViewDataSource

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.numberOfRows() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MainCell.reuseId, for: indexPath) as? MainCell
        guard let tableViewCell = cell, let viewModel = viewModel else { return UITableViewCell() }
        
        let cellViewModel = viewModel.cellViewModel(forIndexPath: indexPath)
        tableViewCell.viewModel = cellViewModel

        return tableViewCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let viewModel = viewModel else {return}
        viewModel.didSelectedRow(forIndexPath: indexPath)
        DispatchQueue.main.async {
            self.backButton.isEnabled = true
            self.tableView.reloadData()
        }
    }
}


