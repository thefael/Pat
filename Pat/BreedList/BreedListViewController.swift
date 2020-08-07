import UIKit

class BreedListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    let dataFetcher = DataFetcher()
    let interactor = BreedListInteractor()
    let favouriteVC = FavouritesListViewController()
    let dataSource = ObjectDataSource<Breed, UITableViewCell>()
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
        dataSource.configureCell = { item, cell in
            cell.textLabel?.text = item.name
        }
        tableView.dataSource = dataSource
        tableView.delegate = self
        loadBreedList()
    }

    @IBAction func favouritePressed(_ sender: UIButton) {
        sender.isSelected.toggle()
        interactor.updateFavouritesList(sender: sender, tableView: tableView, breedList: breedList)
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
