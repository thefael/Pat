import UIKit
class ImageCache {
    static let shared = ImageCache()
    private init() {}

    var imageCache: [URL?: UIImage] = [:]
}
