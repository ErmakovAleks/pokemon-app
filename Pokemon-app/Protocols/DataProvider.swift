import Foundation
import UIKit
import RxSwift
import RxCocoa

protocol PokemonsDataProvider {
    
    func list(limit: Int, offset: Int) -> Single<[Pokemon]>
    
    func details(url: URL) -> Single<Detail>
}
