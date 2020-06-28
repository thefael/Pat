import Foundation

class DataFetcher {
    
    let urlSession = URLSession.shared
    
    func fetchData(_ completion: @escaping ([Breed]?, Error?) -> Void) {
        let dataTask = urlSession.dataTask(with: URL.baseURL) { (data, _, error) in
            if let error = error {
                completion(nil, error)
            } else if let data = data {
                do {
                    let breedList = try self.parseJSON(data: data)
                    completion(breedList, nil)
                } catch {
                    completion(nil, error)
                }
            }
        }
        dataTask.resume()
    }
    
    func parseJSON(data: Data) throws -> [Breed] {
        
        let decoder = JSONDecoder()
        
        let breedArray: [String] = try decoder.decode(Array<String>.self, from: data)
        let breedList = breedArray.map { name in Breed(name: name) }
        return breedList
    }
}
