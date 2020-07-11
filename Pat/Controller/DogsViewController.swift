//
import UIKit

class DogsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    var breed = String()

    let dataFetcher = DataFetcher()
    let dataSource = ObjectDataSource<DogImage, DogCell>()
    var dogImageList = [DogImage]() {
        didSet {
            DispatchQueue.main.async {
                self.dataSource.genericList = self.dogImageList
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableViewDelegates()
        configureTablewView()
        loadDogList()
    }

    func configureTablewView() {
        tableView.register(DogCell.self, forCellReuseIdentifier: "ReusableCell")
        dataSource.configureCell = { item, cell in
            cell.dogImageView.image = UIImage(data: item.dogImage!)
        }
    }

    func setTableViewDelegates() {
        tableView.dataSource = dataSource
        tableView.delegate = self
    }

    func loadDogList() {
        dataFetcher.fetchData(path: URL.makeDogURL(with: breed)) { (result: Result<[String], Error>) in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let imageURLArray):
                self.dogImageList = imageURLArray.map { imageURLString in
                    DogImage(imageURLString)
                }
            }
        }
    }
}

extension DogsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let currentImage =  UIImage(data: dogImageList[indexPath.row].dogImage!) ?? UIImage()
        let imageCrop = currentImage.getCropRatio()
        return tableView.frame.width / imageCrop
    }
}
