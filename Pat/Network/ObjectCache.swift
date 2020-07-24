import UIKit
class ObjectCache {
    static let shared = ObjectCache()
    private init() {}

    var objCache: [AnyHashable: AnyObject]? = [:]

    func put(url: URL, data: UIImage) {
        objCache?[url] = data
    }

    func get(key: AnyHashable) -> AnyObject? {
        return objCache?[key]
    }
}
