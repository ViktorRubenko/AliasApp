//
//  JokeService.swift
//  Alias
//
//  Created by Victor Rubenko on 01.05.2022.
//

import Foundation

protocol JokeServiceProtocol {
    func getJoke(completion: @escaping (Result<Joke, Error>) -> Void)
}

enum JokeServiceError: Error {
    case InvalidURL
    case InvalidResponse
}

struct Joke: Decodable {
    var setup: String
    var punchline: String
}
