//
//  PokemonModel.swift
//  Pokemon-app
//
//  Created by Александр Ермаков on 04.02.2022.
//

import Foundation
import RxSwift

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

enum IncorrectResponseError: Error {
    case incorrectResponse
}

// MARK: -
// MARK: Public class

public class Requester {
    
    // MARK: -
    // MARK: Associated Types
    
    typealias Completion<T> = (Result<T, Error>) -> ()
    typealias PokemonsCardsCompletion = Completion<[Pokemon]>
    
    // MARK: -
    // MARK: Public initializations
    
    public init() {}
    
    // MARK: -
    // MARK: Public functions
    
    func pokemons(limit: Int = 20, completion: @escaping PokemonsCardsCompletion) {
        let url = URL(string: "https://pokeapi.co/api/v2/pokemon/?limit=\(limit)")
        if let url = url {
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            var pokemonsArray: [Pokemon] = []
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let data = data, let pokemons = try? JSONDecoder().decode(Pokemons.self, from: data), let results = pokemons.results {
                    pokemonsArray = results
                }
                if let error = error {
                    completion(.failure(error))
                } else {
                    completion(.success(pokemonsArray))
                }
            }
            task.resume()
        }
    }
    
    public func names(limit: Int = 20) -> Observable<String> {
        return Observable<String>.create { observer in
            var request = URLRequest(url: URL(string: "https://pokeapi.co/api/v2/pokemon/?limit=\(limit)")!)
            request.httpMethod = "GET"
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let data = data, let pokemons = try? JSONDecoder().decode(Pokemons.self, from: data),
                   let results = pokemons.results {
                    results.forEach { result in
                        observer.onNext(result.name!)
                    }
                }
            }
            task.resume()
            return Disposables.create()
        }
    }
}
