import UIKit

protocol UpdateFavouritesList {
    func updateFavouritesList(sender: UIButton, tableView: UITableView, breedList: [Breed])
}

class Favourites: UpdateFavouritesList {
    static let shared = Favourites()
    private init() {}

    let defaults = UserDefaults.standard
    private var favouritesList = [String]() {
        didSet {
            defaults.set(favouritesList, forKey: "favouritesListKey")
        }
    }

    func getFavList() -> [String] {
        return favouritesList
    }

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
