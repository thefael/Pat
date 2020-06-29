import Foundation

class DataFetcher {
    
    let urlSession = URLSession.shared
    
    func fetchData<T: Decodable>(path: URL, _ completion: @escaping (Result<T, Error>) -> Void) {
        urlSession.dataTask(with: path) { (data, _, error) in
            if let error = error {
                completion(.failure(error))
            } else if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let obj = try decoder.decode(T.self, from: data)
                    completion(.success(obj))
                } catch {
                    completion(.failure(error))
                }

            }

       }.resume()
    }
}
