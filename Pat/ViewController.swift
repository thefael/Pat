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
    var breedList: [Breed]? {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    func loadBreedList() {
        dataFetcher.fetchData { (breedList, error) in
            if let error = error {
                print("Error trying to fetch data. \(error)")
            } else if let breedList = breedList {
                self.breedList = breedList
            }
        }
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        loadBreedList()
        guard let list = breedList else { return 0 }
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReusableCell", for: indexPath)
        guard let list = breedList else { return UITableViewCell() }
        cell.textLabel?.text = list[indexPath.item].name
        return cell
    }
}
