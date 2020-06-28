import Foundation

struct Dog: Codable {
    let breed: String
}

struct BreedList: Codable {
    let dogList: [Dog]
}
