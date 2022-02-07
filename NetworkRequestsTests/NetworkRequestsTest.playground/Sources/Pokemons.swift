import Foundation

// MARK: -
// MARK: Public structures

public struct Pokemons: Codable {
    let count: Int?
    let next, previous: URL?
    public let results: [Pokemon]?
}


public struct Pokemon: Codable {
    public let name: String?
    public let url: String?
}
