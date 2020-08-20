import UIKit

class Favourites {
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
        defaults.set(favouritesList, forKey: "favouritesListKey")
    }

    func addBreed(breed: String) {
        favouritesList.append(breed)
    }

    func removeBreed(breed: String) {
        favouritesList.removeAll { $0 == breed }
    }

    func isFavourite(breed: String) -> Bool {
        guard let list = defaults.object(forKey: "favouritesListKey") as? [String] else { return false }
        if list.contains(breed) {
            return true
        } else {
            return false
        }
    }
}
