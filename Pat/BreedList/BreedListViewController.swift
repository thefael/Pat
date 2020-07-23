import UIKit

class BreedListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let dataFetcher = DataFetcher()
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
    
    func loadBreedList() {
        dataFetcher.fetchData(path: URL.breeds) { (result: Result<[String], Error>) in
            switch result {
            case .failure(let error):
                print("Error trying to fetch data. \(error)")
            case .success(let breedArray):
                self.breedList = breedArray.map { name in Breed(name: name) }
            }
        }
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
