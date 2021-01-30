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

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = MainViewModel()
        createTableView()
        loadData()
    }
    
    private func loadData(){
        viewModel?.getData { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
    
    private func createTableView(){
        tableView = UITableView(frame: view.bounds)
        view.addSubview(tableView)
        tableView.register(MainCell.self, forCellReuseIdentifier: MainCell.reuseId)
        tableView.delegate = self
        tableView.dataSource = self
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
            self.tableView.reloadData()
        }
    }
}


