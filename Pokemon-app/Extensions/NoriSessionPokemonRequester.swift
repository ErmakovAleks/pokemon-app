//
//  NoriSessionPokemonRequester.swift
//  Pokemon-app
//
//  Created by Александр Ермаков on 21.05.2022.
//

import Foundation
import RxSwift

class NoriSessionPokemonRequester<Service: DataSessionService>: NSObject, PokemonsDataProvider {
    
    // MARK: -
    // MARK: Variables
    
    var linkEntry: String = PokemonAPI.dev.rawValue
    
    // MARK: -
    // MARK: PokemonsDataProvider functions
    
    func list(limit: Int, offset: Int) -> Single<[Pokemon]> {
        return Single<[Pokemon]>.create { single in
            let url = URL(string: self.linkEntry + "?limit=\(limit)&offset=\(offset)")!
            Service.request(model: Pokemons.self, url: url) |*| get { response in
                switch response {
                case .success(let pokemons):
                    if let results = pokemons.results {
                        single(.success(results))
                    } else { print("Invalid response!") }
                case .failure(let error):
                    single(.failure(error))
                }
            }
            return Disposables.create()
        }
    }
    
    func details(url: URL) -> Single<Detail> {
        return Single<Detail>.create { single in
            Service.request(model: PokemonDetails.self, url: url) |*| get { response in
                switch response {
                case .success(let results):
                    var image: UIImage?
                    if let imageURL = results.sprites?.frontDefault,
                    let data = try? Data(contentsOf: imageURL)
                    {
                        image = UIImage(data: data)
                    }
                    let details: Detail = (
                        name: results.name,
                        height: results.height,
                        weight: results.weight,
                        image: image
                    )
                    single(.success(details))
                case .failure(let error):
                    single(.failure(error))
                }
            }
            return Disposables.create()
        }
    }
}

extension Pokemons: NetworkProcessable {
    public typealias ReturnedType = Pokemons
    
    public static var url: URL {
        fatalError("This type has no link!")
    }
}

extension PokemonDetails: NetworkProcessable {
    public typealias ReturnedType = PokemonDetails
    
    public static var url: URL {
        fatalError("This type has no link!")
    }
}
