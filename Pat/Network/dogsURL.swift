
import Foundation

extension URL {
    private static let urlString = "https://hidden-crag-71735.herokuapp.com/api/breeds"
    static let baseURL: URL = {
        guard let url = URL(string: urlString) else {
            fatalError("Invalid baseURL")
        }
        return url
    }()
}
