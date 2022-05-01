//
//  JokeService.swift
//  Alias
//
//  Created by Victor Rubenko on 01.05.2022.
//

import Foundation

protocol JokeServiceProtocol {
    func getJoke(completion: @escaping (String) -> Void) -> String
}
