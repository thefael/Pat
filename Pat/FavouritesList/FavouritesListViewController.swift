import UIKit

class FavouritesListViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!

    let favourites = Favourites.shared
    let dataSource = ObjectDataSource<String, FavouriteCell>()
    var favouritesList = [String]() {
        didSet {
            DispatchQueue.main.async {
                self.dataSource.genericList = self.favouritesList
                self.tableView.reloadData()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        dataSource.configureCell = { item, cell in
            cell.textLabel?.text = item
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        favouritesList = favourites.getFavList()
    }

    func configureTableView() {
        tableView.register(FavouriteCell.self, forCellReuseIdentifier: "ReusableCell")
        tableView.dataSource = dataSource
        tableView.rowHeight = 100
    }
}
