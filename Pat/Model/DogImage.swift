import UIKit

struct DogImage: Codable {
    let imageData: Data?

    init(_ imageURL: URL) {
        self.imageData = NSData(contentsOf: imageURL) as Data?
    }
}
