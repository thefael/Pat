import Foundation

class DataFetcher {
    
    let urlSession = URLSession.shared

    func fetchData<T: Decodable>(path: URL, _ completion: @escaping (T?, Error?) -> Void) {
        urlSession.dataTask(with: path) { (data, _, error) in
           if let error = error {
               completion(nil, error)
           } else if let data = data {
               do {
                let decoder = JSONDecoder()
                let obj = try decoder.decode(T.self, from: data)
                   completion(obj, nil)
               } catch {
                   completion(nil, error)
               }
           }
       }.resume()
    }
}
