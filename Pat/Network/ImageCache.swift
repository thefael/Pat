import UIKit
class ImageCache {
    static let shared = ImageCache()
    private init() {}

    var imageCache: [URL?: UIImage] = [:]
}

extension UIImageView {
    func fetchImage(from imageURL: URL?, _ completion: @escaping ((Result<UIImage, Error>) -> Void)) {
        if let imageURL = imageURL {
            let urlSession = URLSession.shared
            let dataTask = urlSession.dataTask(with: imageURL) { data, _, error in
                DispatchQueue.main.async {
                    if let error = error {
                        completion(.failure(error))
                    } else if let data = data, let image = UIImage(data: data) {
                        completion(.success(image))
                    }
                }
            }
            dataTask.resume()
        }
    }
}
