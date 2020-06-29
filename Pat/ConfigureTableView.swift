import UIKit

class ConfigureTableView {
    static func numberOfItemsIn<T>(_ array: [T]) -> Int {
        return array.count
    }

    static func itemToPopulateCell<T>(use array: [T], toPopulate: UITableViewCell, at indexPath: IndexPath) -> T {
        return array[indexPath.item]
    }
}
