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
    }

    func configureTablewView() {
        tableView.register(DogCell.self, forCellReuseIdentifier: "ReusableCell")
        tableView.dataSource = dataSource
        tableView.delegate = self
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
                print(error)
            case .success(let imageURLArray):
                self.dogURLList = imageURLArray
            }
        }
    }
}

extension DogsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let dogImageData = NSData(contentsOf: dogURLList[indexPath.row]) as Data?
        let currentImage =  UIImage(data: dogImageData!) ?? UIImage()
        let imageCrop = currentImage.getCropRatio()
        return tableView.frame.width / imageCrop
    }
}
