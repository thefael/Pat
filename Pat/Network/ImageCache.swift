import UIKit
class ImageCache {
    static let shared = ImageCache()
    private init() {}

    var imageCache: [URL: UIImage]? = [:]

    func put(url: URL, data: UIImage) {
        imageCache?[url] = data
    }

    func get(url: URL) -> UIImage? {
        return imageCache?[url]
    }
}
