import Foundation
import UIKit
import RxSwift
import RxCocoa

protocol PokemonsDataProvider {
    
    func list(limit: Int, offset: Int, handler: @escaping PokemonsCardsCompletion)
    
    func details(url: URL, handler: @escaping PokemonDetailCompletion)
    
    func rxList(limit: Int, offset: Int) -> Single<[Pokemon]>
    
    func rxDetails(url: URL) -> Single<Detail>
}
