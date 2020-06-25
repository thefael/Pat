
import Foundation

protocol DataFetcherDelegate {
    func didUpdateBreedList(_ breedList: [String])
    func didFailWithError(_ error: Error)
}


class DataFetcher {
    
    var delegate: DataFetcherDelegate?
    
    let urlString = "https://hidden-crag-71735.herokuapp.com/api/breeds"
    let urlSession = URLSession.shared
    
    func fetchData() {
        guard let url = URL(string: urlString) else { return }
        let dataTask = urlSession.dataTask(with: url) { (data, response, error) in
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
