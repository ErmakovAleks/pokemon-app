import Foundation

// MARK: - PokemonDetails
public struct PokemonDetails: Codable {
    let abilities: [Ability]
    let baseExperience: Int
    let forms: [Species]
    let height: Int
    let id: Int
    let isDefault: Bool
    let locationAreaEncounters: String
    let name: String
    let order: Int
    let species: Species
    let weight: Int
}

// MARK: - Ability
public struct Ability: Codable {
    let ability: Species
    let isHidden: Bool
    let slot: Int
}

// MARK: - Species
public struct Species: Codable {
    let name: String
    let url: URL
}

// MARK: - Sprites
struct Sprites: Codable {
    let back_default: URL
    let back_shiny: URL
    let front_default: URL
    let front_shiny: URL
}
