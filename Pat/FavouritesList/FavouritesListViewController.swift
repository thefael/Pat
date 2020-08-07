import UIKit

protocol UpdateFavouritesList {
    func updateFavouritesList(sender: UIButton, tableView: UITableView, breedList: [Breed])
}

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

extension FavouritesListViewController: UpdateFavouritesList {
    
    func updateFavouritesList(sender: UIButton, tableView: UITableView, breedList: [Breed]) {
        guard let row = indexPathOfButtonTapped(sender: sender, tableView: tableView)?.row else { return }
        let selectedBreed = breedList[row].name
        if sender.isSelected {
            favouritesList.append(selectedBreed)
            print(favouritesList)
        } else if !sender.isSelected {
            favouritesList.removeAll { $0 == selectedBreed }
            print(favouritesList)
        }
    }

    func indexPathOfButtonTapped(sender: AnyObject, tableView: UITableView) -> IndexPath? {
        let buttonPosition = sender.convert(CGPoint.zero, to: tableView)
        let indexPath = tableView.indexPathForRow(at: buttonPosition)
        return indexPath
    }
}
