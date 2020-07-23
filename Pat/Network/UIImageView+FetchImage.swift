import UIKit

extension UIImageView {
    func fetchImage(from imageURL: URL?, _ completion: @escaping ((Result<UIImage, Error>) -> Void)) {
        if let imageURL = imageURL {
            if let cachedImage = ImageCache.shared.imageCache[imageURL] {
                completion(.success(cachedImage))
            } else {
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
}
