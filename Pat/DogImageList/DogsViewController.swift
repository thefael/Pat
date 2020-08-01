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
        loadDogList()
        self.configureCell()
        tableView.rowHeight = 200
    }

    func loadDogList() {
        interactor.loadDogList(from: breed,
                               onSuccess: { dogURLList in
            self.dogURLList = dogURLList
        },
                               onError: { error in
            print("This is the error: \(error)")
        })
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
