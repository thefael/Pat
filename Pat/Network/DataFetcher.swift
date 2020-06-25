
import Foundation

protocol DataFetcherDelegate {
    func didUpdateBreedList(_ breedList: [Breed])
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
                do {
                    let breedList = try self.parseJSON(data: data)
                    self.delegate?.didUpdateBreedList(breedList)
                    
                } catch {
                    self.delegate?.didFailWithError(error)
                }
            }
        }
        dataTask.resume()
    }
    
    func parseJSON(data: Data) throws -> [Breed] {
        
        let decoder = JSONDecoder()
        var breedList = [Breed]()
        
        let breedArray: [String] = try decoder.decode(Array<String>.self, from: data)
        for name in breedArray {
            let newBreed = Breed(name: name)
            breedList.append(newBreed)
        }
        return breedList
    }
}
