import UIKit
class ImageCache {
    static let shared = ImageCache()
    private init() {}

    var objCache: [AnyHashable: UIImage] = [:]

    func put(url: URL, data: UIImage) {
        objCache[url] = data
    }

    func get(key: AnyHashable) -> UIImage? {
        return objCache[key]
    }
}