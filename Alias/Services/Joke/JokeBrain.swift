//
//  JokeBrain.swift
//  Alias
//
//  Created by Даниил Симахин on 04.05.2022.
//

struct Joke: Decodable {
    var id: Int
    var type: String
    var setup: String
    var punchline: String
    var url: String
}

import Foundation

class JokeBrain: JokeServiceProtocol {
    var url: String = "https://joke.deno.dev"
    
    //MARK: - Use getJoke()
    /*
        getJoke(completion: { joke in
         print(joke?.setup)
        })
    */
    func getJoke(completion: @escaping (Joke?) -> Void) -> String {
        var setup = ""
        
        guard let url = URL(string: url) else { return setup}
        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    print("Some error")
                    completion(nil)
                    return
                }
                guard let data = data else { return }
                do {
                    let string = try JSONDecoder().decode(Joke.self, from: data)
                    setup = string.setup
                    completion(string)
                } catch let jsonError {
                    print("Failed to decode JSON", jsonError)
                    completion(nil)
                }
            }
        }.resume()
        return setup
    }
}
