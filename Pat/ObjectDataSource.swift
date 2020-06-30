import UIKit

class ObjectDataSource<T, Cell: UITableViewCell>: NSObject, UITableViewDataSource {
    var genericList: [T]?
    var configureCell: (T, Cell) -> Void = {(item, cell) in }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let list = genericList else { return 0 }
        return list.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let list = genericList else { return UITableViewCell() }
        let item = list[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ReusableCell", for: indexPath) as? Cell else {
            return UITableViewCell()
        }
        configureCell(item, cell)
        return cell
    }
}
