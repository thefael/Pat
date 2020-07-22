import UIKit

class ImageFetcher {
    static let shared = ImageFetcher()
    private init() {}

    var imageCache: [URL?: UIImage] = [:]
    
    func fetchImage(from imageURL: URL?, into imageView: UIImageView) {
        if let cachedImage = imageCache[imageURL] {
            imageView.image = cachedImage
        } else if let dogImageURL = imageURL {
            DispatchQueue.global(qos: .background).async {
                do {
                    let imageData = try Data(contentsOf: dogImageURL)
                    DispatchQueue.main.async {
                        imageView.image = UIImage(data: imageData)
                        self.imageCache[dogImageURL] = imageView.image
                    }
                } catch {
                    print("Unable to load data. \(error)")
                }
            }
        }
    }
}
