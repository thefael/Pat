
import Foundation

protocol DataFetcherDelegate {
    func didUpdateBreedList(_ breedList: BreedList)
    func didFailWithError(_ error: Error)
}


class DataFetcher {
    
    var delegate: DataFetcherDelegate?
    
    let url = URL(fileURLWithPath: "https://hidden-crag-71735.herokuapp.com/api/breeds")
    let urlSession = URLSession.shared
    
    func fetchData() {
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
    
    func parseJSON(data: Data) -> BreedList? {
        
        let decoder = JSONDecoder()
        var dogList = BreedList(dogList: [])
        
        do {
            dogList = try decoder.decode(BreedList.self, from: data)
            print(dogList)
            return dogList
        } catch {
            delegate?.didFailWithError(error)
            return nil
        }
        
    }
    
}
