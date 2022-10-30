//
//  File.swift
//  Jokes
//
//  Created by Aklesh on 30/10/22.
//

import Foundation
import UIKit

class JokesViewController: UITableViewController {
    
    var viewModel:JokesViewModelProtocol!
    
    public init(viewModel: JokesViewModelProtocol){
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Jokes"
        // You must register the cell with a reuse identifier
        tableView.register(JokeTableViewCell.self, forCellReuseIdentifier: JokeTableViewCell.nameOfClass)
        // Change the row height if you want
        tableView.estimatedRowHeight = 60.0
        tableView.rowHeight = UITableView.automaticDimension
        // This will remove any empty cells that are below your data filled cells
        tableView.tableFooterView = UIView()
       // tableView.separatorStyle = .none
        bindViewModel()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        print("viewWillDisappear called")
        viewModel.saveJokes()
    }
    
    deinit {
        print("deinit called")

    }
    
    func bindViewModel() {
        viewModel.jokesFetched = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
             }
        }
        viewModel.fetchJokesFromDefault()
        viewModel.startFetchingJokes()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {

        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return viewModel.jokesArray.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = tableView.dequeueReusableCell(withIdentifier: JokeTableViewCell.nameOfClass) as! JokeTableViewCell
        let cell = tableView.dequeueReusableCell(withIdentifier: JokeTableViewCell.nameOfClass, for: indexPath) as! JokeTableViewCell
        let joke = viewModel.jokesArray[indexPath.row]
        cell.jokeLabel.text = joke.trimmingCharacters(in: .whitespacesAndNewlines)
        cell.selectionStyle = .none
        return cell
    }
}
