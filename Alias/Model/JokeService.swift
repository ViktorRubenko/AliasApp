//
//  Joke.swift
//  Alias
//
//  Created by Ирина on 04.05.2022.
//

import Foundation

struct JokeService {
    let jokeURL = "https://joke.deno.dev/"
    
    func performRequest(jokeURL: String) {
        //1 create url
        if let url = URL(string: jokeURL){
            //2 create urlSession
            let session = URLSession(configuration: .default)
            
            //3 give the session a task
            let task = session.dataTask(with: url) {(data, response, error) in
               
                if error != nil {
                    print(error!)
                    return
                }
                
                if let safeData = data {
                    //let dataString = String (data: safeData , encoding: .utf8)
                    //print(dataString)
                }
            }
            //4. start the task
            task.resume()
        }
    }
    
    func parseJSON(jokeData)
}
