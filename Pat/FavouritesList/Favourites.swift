import UIKit

protocol UpdateFavouritesList {
    func updateFavouritesList(sender: UIButton, cell: UITableViewCell,
                              tableView: UITableView, breedList: [Breed])
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

    func updateFavouritesList(with list: [String]) {
        favouritesList = list
    }

    func updateFavouritesList(sender: UIButton,
                              cell: UITableViewCell,
                              tableView: UITableView,
                              breedList: [Breed]) {

        guard let row = tableView.indexPath(for: cell)?.row else { return }
        let selectedBreed = breedList[row].name
        if sender.isSelected {
            favouritesList.append(selectedBreed)
            print(favouritesList)
        } else if !sender.isSelected {
            favouritesList.removeAll { $0 == selectedBreed }
        }
    }
}
