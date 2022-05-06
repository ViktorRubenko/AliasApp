//
//  JokeService.swift
//  Alias
//
//  Created by Victor Rubenko on 01.05.2022.
//

import Foundation

protocol JokeServiceProtocol {
    //func getJoke(completion: @escaping (String) -> Void) -> String
        func didUpdateJoke (_ jokeService: JokeService, jokeData: JokeData)
        func didFailWithError (error: Error)
    }

    struct JokeData: Codable {
        let id: Int
        let type: String
        let setup: String
        let punchline: String
        
        var getJoke: String {
          return "\(setup)\n\(punchline)"
        }
    }

    struct JokeService {
        let jokeURL = "https://joke.deno.dev/"
        
        var delegate: JokeServiceProtocol?
        
        func fetchJoke(){
            performRequest(with: jokeURL)
        }
        
        func performRequest(with jokeURL: String) {
            //1 create url
            if let url = URL(string: jokeURL){
                //2 create urlSession
                let session = URLSession(configuration: .default)
                
                //3 give the session a task
                let task = session.dataTask(with: url) {(data, response, error) in
                    if error != nil {
                        self.delegate?.didFailWithError(error: error!)
                        return
                    }
                    if let safeData = data {
                        if let jokeData = self.parseJSON (safeData){
                            self.delegate?.didUpdateJoke(self, jokeData: jokeData )
                        }
                    }
                }
                //4. start the task
                task.resume()
            }
        }
        
        func parseJSON(_ jokeData: Data) -> JokeData? {
            let decoder = JSONDecoder()
            do {
                let decodedData =  try decoder.decode(JokeData.self, from: jokeData)

                let id = decodedData.id
                let type = decodedData.type
                let setup = decodedData.setup
                let punchline = decodedData.punchline
                let jokeData = JokeData (id: id, type: type, setup: setup, punchline: punchline)
                return jokeData
            } catch {
                delegate?.didFailWithError(error: error)
                return nil
            }
        }
    }

