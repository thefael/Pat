//
//  ViewController.swift
//  Pat
//
//  Created by Rafael Rodrigues on 25/06/20.
//  Copyright © 2020 Rafael Rodrigues. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let dataFetcher = DataFetcher()
    let dataSource = ObjectDataSource<Breed, UITableViewCell>()
    var breedList = [Breed]() {
        didSet {
            DispatchQueue.main.async {
                self.dataSource.genericList = self.breedList
                self.tableView.reloadData()
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource.configureCell = {(item, cell) in
            cell.textLabel?.text = item.name
        }
        tableView.dataSource = dataSource
        loadBreedList()
    }
    
    func loadBreedList() {
        dataFetcher.fetchData(path: URL.breeds) { (result: Result<[String], Error>) in
            switch result {
            case .failure(let error):
                print("Error trying to fetch data. \(error)")
            case .success(let breedArray):
                self.breedList = breedArray.map { name in Breed(name: name) }
            }
        }
    }
}
