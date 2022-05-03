//
//  MainBaseCoordinator .swift
//  Alias
//
//  Created by Victor Rubenko on 04.05.2022.
//

import Foundation

protocol MainBaseCoordinator: Coordinator {
    func moveTo(flow: AppFlow)
}
