//
//  ViewController.swift
//  Alias
//
//  Created by Victor Rubenko on 01.05.2022.
//

import UIKit

class ViewController: UIViewController {

    var timer = Timer()
    //var secondsPassed = 0
    //var totalTime = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBOutlet weak var jokeText: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    @IBAction func StartRound(_ sender: UIButton) {
        //let hardness = sender.currentTitle! // Soft, Medium, Hard
        let totalTime = 6
        var secondsPassed = 0 // обнуляем
        progressBar.progress = 0.0 // обнуляем бар
        jokeText.text = "" // пустой пока не закончится раунд
        
        // запускаем таймер
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [self] (Timer) in
            if secondsPassed < totalTime {
                secondsPassed += 1
                progressBar.progress = Float(secondsPassed) / Float(totalTime)
            } else {
                Timer.invalidate()
                jokeText.text = "nmmm"
            }
        }
    }
    

}

struct Joke: Decodable{
    let id: Int
    let type: String
    let setup: String
    let punchline: String
}

struct JokeData: Decodable {
    let jokeURL = "https://joke.deno.dev/#"
    print(jokeURL)
    
    func fetchJoke(cityName: String){
        let joke = "\(joke.setup)\n\(joke.punchline)"
    }
    
}


