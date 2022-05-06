//
//  JokeService.swift
//  Alias
//
//  Created by Victor Rubenko on 01.05.2022.
//

import Foundation

protocol JokeServiceProtocol {
    var url: String { get }
    
    func getJoke(completion: @escaping (Joke?) -> Void) -> String
}
