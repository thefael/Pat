//
//  DogsViewController.swift
//  Pat
//
//  Created by Rafael Rodrigues on 07/07/20.
//  Copyright © 2020 Rafael Rodrigues. All rights reserved.
//

import UIKit

class DogsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    let dataFetcher = DataFetcher()
    let dataSource = ObjectDataSource<DogImage, UITableViewCell>()
    var dogImageList = [DogImage]() {
        didSet {
            DispatchQueue.main.async {
                self.dataSource.genericList = self.dogImageList
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = dataSource
        loadDogList()
    }

    func loadDogList() {
        dataFetcher.fetchData(path: URL.makeDogURL(with: "corgi")) { (result: Result<[String], Error>) in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let imageURLArray):
                self.dogImageList = imageURLArray.map { imageURLString in
                    DogImage(imageURLString)
                }
            }
        }
    }
}
