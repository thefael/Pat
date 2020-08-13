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
        if let list = favourites.defaults.object(forKey: "favouritesListKey") as? [String] {
            favourites.updateFavouritesList(with: list)
            tableView.reloadData()
        }
        configureTableView()
        dataSource.configureCell = { item, cell in
            cell.textLabel?.text = item
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("apareceu")
        favouritesList = favourites.getFavList()
    }

    func configureTableView() {
        tableView.register(FavouriteCell.self, forCellReuseIdentifier: "ReusableCell")
        tableView.dataSource = dataSource
        tableView.rowHeight = 100
    }
}
