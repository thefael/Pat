import Foundation

extension URL {
    private static let urlString = "https://hidden-crag-71735.herokuapp.com/api/"

    static let baseURL: URL = {
        guard let url = URL(string: urlString) else {
            fatalError("Invalid baseURL")
        }
        return url
    }()

    static var breeds: URL {
        baseURL.appendingPathComponent("breeds")
    }

    static func makeDogURL(with breed: String) -> URL {
        let dogImageURL = baseURL
            .appendingPathComponent(breed)
            .appendingPathComponent("images")
        return dogImageURL
    }
}
