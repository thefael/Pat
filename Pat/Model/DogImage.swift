import UIKit

//struct DogImage: Codable {
//    let imageURLString: String
//
//    init(_ imageURLString: String) {
//        self.imageURLString = imageURLString
//    }
//}
struct DogImage: Codable {
    let dogImage: Data?

    init(_ imageURLString: String) {
        let imageURL = URL(string: imageURLString)!
        self.dogImage = NSData(contentsOf: imageURL) as Data?
    }
}
