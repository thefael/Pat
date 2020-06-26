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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataFetcher.fetchData { (breedList, error) in
            if let error = error {
                print(error)
            } else if let breedList = breedList {
                print(breedList)
            }
        }
        
        // Do any additional setup after loading the view.
    }
}

//MARK: - UITableViewDataSource
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Returns the number of rows in section. Retrieve this value from
        // the API to know how many races of dogs there are.
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Returns a configured cell using data retrieved from the API.
        return UITableViewCell()
    }
}
