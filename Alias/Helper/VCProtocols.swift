//
//  VCProtocols.swift
//  Alias
//
//  Created by Victor Rubenko on 05.05.2022.
//

import Foundation

protocol GameBaseServicied {
    var gameService: GameBaseService! { get }
}

protocol ComponentsBaseFactoried {
    var componentsFactory: ComponentsBaseFactory! { get }
}

protocol GameBaseViewController: GameBaseCoordinated, GameBaseServicied, ComponentsBaseFactoried {
    
}

protocol PreparationsBaseViewController: PreparationsBaseCoordinated, GameBaseServicied, ComponentsBaseFactoried {
    
}
