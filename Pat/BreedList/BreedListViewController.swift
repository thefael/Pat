import UIKit

class BreedListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    let favourites = Favourites.shared
    let dataFetcher = DataFetcher()
    let interactor = BreedListInteractor()
    let dataSource = ObjectDataSource<Breed, BreedCell>()
    var breedList = [Breed]() {
        didSet {
            DispatchQueue.main.async {
                self.dataSource.genericList = self.breedList
                self.tableView.reloadData()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        updateFavoutitesList()
        dataSource.configureCell = { item, cell in
            let breed = item.name
            cell.textLabel?.text = breed
            cell.setButtonInitialImage(breed: breed)
            cell.updateFaveList = {
                if self.favourites.isFavourite(breed: breed) {
                    self.favourites.removeBreed(breed: breed)
                } else {
                    self.favourites.addBreed(breed: breed)
                }
            }
        }

        tableView.register(BreedCell.self, forCellReuseIdentifier: "ReusableCell")
        tableView.dataSource = dataSource
        tableView.delegate = self
        loadBreedList()
    }

    func updateFavoutitesList() {
        if let list = favourites.defaults.object(forKey: "favouritesListKey") as? [String] {
            favourites.updateFavouritesList(with: list)
        }
    }

    func loadBreedList() {
        interactor.loadBreedList(onSuccess: { breedList in
            self.breedList = breedList
        }, onError: { error in
            print("Error trying to load breedList: \(error)")
        })
    }
}

extension BreedListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "BreedListToDogList", sender: self)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dogsVC = segue.destination as? DogsViewController,
            let index = tableView.indexPathForSelectedRow?.row {
            dogsVC.breed = breedList[index].name
        }
    }
}
