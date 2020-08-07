import UIKit

class BreedListInteractor {

    let dataFetcher = DataFetcher()
    let favouriteVC = FavouritesListViewController()

    func loadBreedList(onSuccess: @escaping ([Breed]) -> Void, onError: @escaping (Error) -> Void) {
        dataFetcher.fetchData(path: URL.breeds) { (result: Result<[String], Error>) in
            switch result {
            case .failure(let error):
                onError(error)
            case .success(let breedArray):
                let breedList = breedArray.map { name in Breed(name: name) }
                onSuccess(breedList)
            }
        }
    }

    func updateFavouritesList(sender: UIButton, tableView: UITableView, breedList: [Breed]) {
        guard let row = indexPathOfButtonTapped(sender: sender, tableView: tableView)?.row else { return }
        let selectedBreed = breedList[row].name
        if sender.isSelected {
            favouriteVC.favouritesList.append(selectedBreed)
            print(favouriteVC.favouritesList)
        } else if !sender.isSelected {
            favouriteVC.favouritesList.removeAll { $0 == selectedBreed }
            print(favouriteVC.favouritesList)
        }
    }

    func indexPathOfButtonTapped(sender: AnyObject, tableView: UITableView) -> IndexPath? {
        let buttonPosition = sender.convert(CGPoint.zero, to: tableView)
        let indexPath = tableView.indexPathForRow(at: buttonPosition)
        return indexPath
    }
}
