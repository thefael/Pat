
import Foundation

protocol DataFetcherDelegate {
    func didUpdateBreedList(_ breedList: [String])
    func didFailWithError(_ error: Error)
}


class DataFetcher {
    
    var delegate: DataFetcherDelegate?
    let urlSession = URLSession.shared
    
    func fetchData() {
        
        let dataTask = urlSession.dataTask(with: URL.baseURL) { (data, response, error) in
            if let error = error {
                print(error)
            } else if let data = data {
                if let breedList = self.parseJSON(data: data) {
                    self.delegate?.didUpdateBreedList(breedList)
                }
            }
        }
        dataTask.resume()
    }
    
    func parseJSON(data: Data) -> [String]? {
        
        let decoder = JSONDecoder()
        var breedList = [String]()
        do {
            breedList = try decoder.decode(Array<String>.self, from: data)
            return breedList
        } catch {
            delegate?.didFailWithError(error)
            return nil
        }
    }
}
