import UIKit

class BreedListInteractor {

    let dataFetcher = DataFetcher()

    func loadBreedList(onSuccess: @escaping ([Breed]) -> Void, onError: @escaping (Error) -> Void) {
        dataFetcher.fetchData(path: URL.breeds) { (result: Result<[String], Error>) in
            switch result {
            case .failure(let error):
                onError(error)
            case .success(let breedArray):
                let breedList = breedArray.map { name in Breed(name: name) }
                onSuccess(breedList)
            }
        }
    }
}
