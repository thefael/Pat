import Foundation

class DogsInteractor {
    let dataFetcher = DataFetcher()

    func loadDogList(from path: String, completion: @escaping ([URL]) -> Void) {
        dataFetcher.fetchData(path: URL.makeDogURL(with: path)) { (result: Result<[URL], Error>) in
            switch result {
            case .failure(let error):
                print("This is the error: \(error)")
            case .success(let imageURLArray):
                completion(imageURLArray)
            }
        }
    }
}
