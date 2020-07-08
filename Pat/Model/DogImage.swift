import Foundation

struct DogImage: Codable {
    let imageURLString: String

    init(_ imageURLString: String) {
        self.imageURLString = imageURLString
    }
}
