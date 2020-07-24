import UIKit

extension UIImageView {
    func fetchImage(from imageURL: URL?,
                    _ completion: @escaping ((Result<UIImage, Error>) -> Void)) -> URLSessionDataTask? {
        let imageCache = ObjectCache.shared
        var dataTask: URLSessionDataTask?
        guard let imageURL = imageURL else { return nil }
        if let cachedImage = imageCache.get(key: imageURL) as? UIImage {
            completion(.success(cachedImage))
        } else {
            let urlSession = URLSession.shared
            dataTask = urlSession.dataTask(with: imageURL) { data, _, error in
                DispatchQueue.main.async {
                    if let error = error {
                        completion(.failure(error))
                    } else if let data = data, let image = UIImage(data: data) {
                        completion(.success(image))
                    }
                }
            }
            dataTask?.resume()
        }
        return dataTask
    }
}
