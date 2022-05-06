//
//  JokeBrain.swift
//  Alias
//
//  Created by Даниил Симахин on 04.05.2022.
//

import Foundation

class JokeBrain: JokeServiceProtocol {
    private let url = "https://joke.deno.dev"
    func getJoke(completion: @escaping (Result<Joke, Error>) -> Void) {
        
        guard let url = URL(string: url) else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                guard error == nil, let data = data else {
                    completion(.failure(error!))
                    return
                }
                do {
                    let joke = try JSONDecoder().decode(Joke.self, from: data)
                    completion(.success(joke))
                } catch {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
}
