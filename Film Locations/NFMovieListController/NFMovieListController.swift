//
//  NFMovieListController.swift
//  Film Locations
//
//  Created by Bilgehan Işıklı on 9.11.2019.
//  Copyright © 2019 Bilgehan Işıklı. All rights reserved.
//

import UIKit

class NFMovieListController: UITableViewController {
    
    private let viewModel: NFMovieListControllerModel
    
    init(_ model: NFMovieListControllerModel = NFMovieListControllerModel()) {
        self.viewModel = model
        super.init(style: .plain)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Something")
        bind()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func bind() {
        viewModel.onFetchStatusChanged = { [unowned self] fetchStatus in
            switch fetchStatus {
            case .started:
                //show activity indicator
                break
            case .ended:
                //hide indicator
                break
            case .error(let error):
                //inform user about error
                print("Error! : \(error)")
                break
            case .success:
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.send(.fetchMovies)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.movies.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Something", for: indexPath)
        cell.textLabel?.text = viewModel.movies[indexPath.row].title
        return cell
    }
    
}
