//
//  RootViewGettableProtocol.swift
//  Pokemon-app
//
//  Created by Александр Ермаков on 08.03.2022.
//

import Foundation
import UIKit

protocol RootViewGettable: UIViewController {
    
    associatedtype RootView: UIView
    
    var rootView: RootView? { get }
}
