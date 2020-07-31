import Foundation

class BreedListInteractor {

    let dataFetcher = DataFetcher()

    func loadBreedList(completion: @escaping ([Breed]) -> Void) {
        dataFetcher.fetchData(path: URL.breeds) { (result: Result<[String], Error>) in
            switch result {
            case .failure(let error):
                print("Error trying to fetch data. \(error)")
            case .success(let breedArray):
                let breedList = breedArray.map { name in Breed(name: name) }
                completion(breedList)
            }
        }
    }
}
