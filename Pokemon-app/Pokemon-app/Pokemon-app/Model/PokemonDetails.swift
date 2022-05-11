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
    let backDefault: URL
    let backShiny: URL
    let frontDefault: URL
    let frontShiny: URL
    
    enum CodingKeys: String, CodingKey {
        case backDefault = "back_default"
        case backShiny = "back_shiny"
        case frontDefault = "front_default"
        case frontShiny = "front_shiny"
    }
}
