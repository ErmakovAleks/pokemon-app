import Foundation

// MARK: -
// MARK: PokemonDetails

struct PokemonDetails: Codable {
    let height: Int?
    let name: String?
    let sprites: Sprites?
    let weight: Int?
}
// MARK: -
// MARK: Sprites

struct Sprites: Codable {
    let back_default: URL
    let back_shiny: URL
    let front_default: URL
    let front_shiny: URL
}
