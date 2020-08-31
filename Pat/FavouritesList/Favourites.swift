import UIKit

class Favourites {
    static let shared = Favourites()
    private init() {
        if let list = defaults.object(forKey: "favouritesListKey") as? [String] {
            favouritesList = list
        }
    }

    private let defaults = UserDefaults.standard
    private var favouritesList = [String]() 

    func getFavList() -> [String] {
        return favouritesList
    }

    func addBreed(breed: String) {
        favouritesList.append(breed)
        defaults.set(favouritesList, forKey: "favouritesListKey")
    }

    func removeBreed(breed: String) {
        favouritesList.removeAll { $0 == breed }
        defaults.set(favouritesList, forKey: "favouritesListKey")
    }

    func isFavourite(breed: String) -> Bool {
        if favouritesList.contains(breed) {
            return true
        } else {
            return false
        }
    }
}
