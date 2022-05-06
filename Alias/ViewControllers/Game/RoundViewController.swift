//
//  ViewController.swift
//  Alias
//
//  Created by Victor Rubenko on 01.05.2022.
//

import UIKit

class RoundViewController: UIViewController, JokeServiceProtocol {

    var timer = Timer()
    var jokeService = JokeService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBOutlet weak var jokeText: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    @IBAction func StartRound(_ sender: UIButton) {
        
        jokeService.delegate = self
        let totalTime = 6
        var secondsPassed = 0 // обнуляем
        progressBar.progress = 0.0 // обнуляем бар
        jokeText.text = "" // пустой пока не закончится раунд
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [self] (Timer) in
            if secondsPassed < totalTime {
                secondsPassed += 1
                progressBar.progress = Float(secondsPassed) / Float(totalTime)
            } else {
                Timer.invalidate()
                jokeService.fetchJoke()
            }
        }
    }
    func didUpdateJoke(_ jokeService: JokeService, jokeData: JokeData){
        DispatchQueue.main.async {
            self.jokeText.text = jokeData.getJoke
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}
    
    



