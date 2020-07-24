import UIKit
class ObjectCache {
    static let shared = ObjectCache()
    private init() {}

    var imageCache: [AnyHashable: AnyObject]? = [:]

    func put(url: URL, data: UIImage) {
        imageCache?[url] = data
    }

    func get(key: AnyHashable) -> AnyObject? {
        return imageCache?[key]
    }
}
