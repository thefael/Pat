//
import UIKit

class DogsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    var breed = String()

    let dataFetcher = DataFetcher()
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
//        tableView.estimatedRowHeight = 200
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

    func loadDogList() {
        dataFetcher.fetchData(path: URL.makeDogURL(with: breed)) { (result: Result<[URL], Error>) in
            switch result {
            case .failure(let error):
                print("This is the error: \(error)")
            case .success(let imageURLArray):
                self.dogURLList = imageURLArray
            }
        }
    }
}
