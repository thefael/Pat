import UIKit
class ImageCache {
    static let shared = ImageCache()
    private init() {}

    private var imgCache: [AnyHashable: UIImage] = [:]

    func put(url: URL, data: UIImage) {
        imgCache[url] = data
    }

    func get(key: AnyHashable) -> UIImage? {
        return imgCache[key]
    }
}
