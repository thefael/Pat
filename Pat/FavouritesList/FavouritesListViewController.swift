import UIKit

class FavouritesListViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    let dataSource = ObjectDataSource<[UIImage], FavouriteCell>()
    var favouritesList = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
    }

    func configureTableView() {
        tableView.register(FavouriteCell.self, forCellReuseIdentifier: "ReusableCell")
        tableView.dataSource = dataSource
        tableView.rowHeight = 100
    }
}
