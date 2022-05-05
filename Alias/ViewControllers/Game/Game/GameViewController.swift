//
//  GameViewController.swift
//  Alias
//
//  Created by Victor Rubenko on 01.05.2022.
//

import UIKit

class GameViewController: UIViewController, GameBaseViewController {

    var gameService: GameBaseService!
    var componentsFactory: ComponentsBaseFactory!
    weak var coordinator: GameBaseCoordinator?
    
    private lazy var guessedHeader: GuessedHeaderView = {
        let view = GuessedHeaderView()
        view.guessedValue = gameService.roundPoints
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var timerView: TimerView = {
        let view = TimerView()
        view.timerValue = gameService.totalTimerSeconds
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    init(coordinator: GameBaseCoordinator, gameService: GameBaseService, componentsFactory: ComponentsBaseFactory) {
        self.coordinator = coordinator
        self.gameService = gameService
        self.componentsFactory = componentsFactory
        super.init(nibName: nil, bundle: nil)
        
        gameService.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        gameService.delegate = nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupNavBar()
        gameService.startRound()
    }
    
    private func setupViews() {
        let safeArea = view.safeAreaLayoutGuide
        
        view.backgroundColor = Constants.Colors.mainBackgroundColor
        view.addSubview(guessedHeader)
        view.addSubview(timerView)
        
        NSLayoutConstraint.activate([
            guessedHeader.topAnchor.constraint(equalTo: safeArea.topAnchor),
            guessedHeader.widthAnchor.constraint(equalTo: safeArea.widthAnchor),
            guessedHeader.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            
            timerView.topAnchor.constraint(equalTo: guessedHeader.bottomAnchor, constant: 10),
            timerView.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor)
        ])
    }
    
    private func setupNavBar() {
        title = "Игра"
    }

}

extension GameViewController: GameServiceDelegate {
    func handleWord(gameService: GameBaseService, word: String, action: String?) {
        print(word, action)
    }
    
    func timerDidUpdate(gameService: GameBaseService, seconds: Int) {
        timerView.timerValue = seconds
    }
    
    func roundDidEnd(gameService: GameBaseService) {
        print("end")
    }
    
    func gameDidEnd(gameService: GameBaseService) {
        print("gameEnd")
    }
}
