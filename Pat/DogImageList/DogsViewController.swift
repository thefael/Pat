import UIKit

class DogsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    var breed = String()

    let dataFetcher = DataFetcher()
    let interactor = DogsInteractor()
    let dataSource = ObjectDataSource<URL, DogCell>()
    var dogURLList = [URL]() {
        didSet {
            DispatchQueue.main.async {
                self.dataSource.genericList = self.dogURLList
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureTablewView()
        interactor.loadDogList(from: breed) { dogURLList in
            self.dogURLList = dogURLList
        }
        self.configureCell()
        tableView.rowHeight = 200
    }

    func configureTablewView() {
        tableView.register(DogCell.self, forCellReuseIdentifier: "ReusableCell")
        tableView.dataSource = dataSource
    }

    func configureCell() {
        self.dataSource.configureCell = { item, cell in
            cell.imageURL = item
        }
    }
}
