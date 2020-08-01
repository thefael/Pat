import Foundation

class DogsInteractor {
    let dataFetcher = DataFetcher()

    func loadDogList(from path: String,
                     onSuccess: @escaping ([URL]) -> Void,
                     onError: @escaping (Error) -> Void) {
        dataFetcher.fetchData(path: URL.makeDogURL(with: path)) { (result: Result<[URL], Error>) in
            switch result {
            case .failure(let error):
                onError(error)
            case .success(let imageURLArray):
                onSuccess(imageURLArray)
            }
        }
    }
}
