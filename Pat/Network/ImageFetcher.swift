import UIKit

class ImageFetcher {
    static let shared = ImageFetcher()
    private init() {}
    
    func fetchImage(from imageURL: URL?, into imageView: UIImageView) {
        if let dogImageURL = imageURL {
            DispatchQueue.global(qos: .background).async {
                do {
                    let imageData = try Data(contentsOf: dogImageURL)
                    DispatchQueue.main.async {
                        imageView.image = UIImage(data: imageData)
                    }
                } catch {
                    print("Unable to load data. \(error)")
                }
            }
        }
    }
}
