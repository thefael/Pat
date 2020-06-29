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
    var breedList = [Breed]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
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

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ConfigureTableView.numberOfItemsIn(breedList)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReusableCell", for: indexPath)
        let item = ConfigureTableView.itemToPopulateCell(use: breedList, toPopulate: cell, at: indexPath)
        cell.textLabel?.text = item.name
        return cell
    }
}
