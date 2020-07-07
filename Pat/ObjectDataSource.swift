import UIKit

class ObjectDataSource<T, Cell: UITableViewCell>: NSObject, UITableViewDataSource {
    var genericList = [T]()
    var configureCell: ((T, Cell) -> Void)?

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return genericList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = genericList[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ReusableCell", for: indexPath) as? Cell else {
            return UITableViewCell()
        }
        configureCell?(item, cell)
        return cell
    }
}
