//
//  GameViewController.swift
//  Alias
//
//  Created by Victor Rubenko on 01.05.2022.
//

import UIKit
import AVFoundation

class GameViewController: InitialGameViewController {
    private var player: AVAudioPlayer?
    private var jokeService: JokeBaseService!
    
    private lazy var header: GameHeaderView = {
        let view = GameHeaderView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var footer: GameFooterView = {
        let view = GameFooterView(frame: .zero) { [weak self] in
            self?.gameService.resetTeamRound()
            self?.coordinator?.goToNextRound()
        }
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var timerView: TimerView = {
        let view = TimerView()
        view.timerValue = gameService.totalTimerSeconds
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var actionLabel: UILabel = {
        let label = UILabel()
        label.textColor = Constants.Colors.redColor
        label.font = .systemFont(ofSize: 30, weight: .semibold)
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var wordLabel: UILabel = {
        let label = UILabel()
        label.textColor = Constants.Colors.textColor
        label.font = .systemFont(ofSize: 45, weight: .bold)
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var actionWordContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var guessButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = Constants.Colors.bottomButtonColor
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .semibold)
        button.setTitle("??????????????????", for: .normal)
        button.setTitleColor(Constants.Colors.greenColor, for: .normal)
        button.clipsToBounds = true
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(didTapGuessButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var skipButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = Constants.Colors.bottomButtonColor
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .semibold)
        button.setTitle("????????????????????", for: .normal)
        button.setTitleColor(Constants.Colors.redColor, for: .normal)
        button.clipsToBounds = true
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(didTapSkipButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var buttonStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    init(coordinator: GameBaseCoordinator?, gameService: GameBaseService, componentsFactory: ComponentsBaseFactory, jokeService: JokeBaseService) {
        super.init(coordinator: coordinator, gameService: gameService, componentsFactory: componentsFactory)
        self.jokeService = jokeService
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
        gameService.startCurrentTeamRound()
        updateUI()
    }
    
    private func setupViews() {
        let safeArea = view.safeAreaLayoutGuide
        
        view.backgroundColor = Constants.Colors.mainBackgroundColor
        view.addSubview(header)
        view.addSubview(timerView)
        
        view.addSubview(actionWordContainer)
        actionWordContainer.addSubview(actionLabel)
        actionWordContainer.addSubview(wordLabel)
        
        view.addSubview(buttonStack)
        buttonStack.addArrangedSubview(guessButton)
        buttonStack.addArrangedSubview(skipButton)
        
        view.addSubview(footer)
        
        NSLayoutConstraint.activate([
            header.topAnchor.constraint(equalTo: safeArea.topAnchor),
            header.widthAnchor.constraint(equalTo: safeArea.widthAnchor),
            header.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            header.heightAnchor.constraint(equalToConstant: 110),
            
            timerView.topAnchor.constraint(equalTo: header.bottomAnchor, constant: 10),
            timerView.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            timerView.widthAnchor.constraint(greaterThanOrEqualToConstant: 120),
            
            actionWordContainer.topAnchor.constraint(equalTo: timerView.bottomAnchor),
            actionWordContainer.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 10),
            actionWordContainer.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -10),
            actionWordContainer.bottomAnchor.constraint(equalTo: buttonStack.topAnchor),
            
            wordLabel.centerXAnchor.constraint(equalTo: actionWordContainer.centerXAnchor),
            wordLabel.centerYAnchor.constraint(equalTo: actionWordContainer.centerYAnchor),
            wordLabel.widthAnchor.constraint(equalTo: actionWordContainer.widthAnchor),
            
            actionLabel.bottomAnchor.constraint(equalTo: wordLabel.topAnchor, constant: -5),
            actionLabel.widthAnchor.constraint(equalTo: wordLabel.widthAnchor),
            actionLabel.centerXAnchor.constraint(equalTo: wordLabel.centerXAnchor),
            
            buttonStack.bottomAnchor.constraint(equalTo: footer.topAnchor, constant: -10),
            buttonStack.heightAnchor.constraint(equalToConstant: 50),
            buttonStack.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 10),
            buttonStack.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -10),
            
            footer.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            footer.widthAnchor.constraint(equalTo: safeArea.widthAnchor),
            footer.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            footer.heightAnchor.constraint(equalToConstant: 150),
        ])
    }
    
    override func setupNavBar() {
        super.setupNavBar()
        title = "????????"
    }
    
    private func updateUI() {
        header.guessedValue = gameService.points
        footer.skipValue = gameService.skippedWords
    }
    
    private func playSound(success: Bool) {
        guard let successURL = Bundle.main.url(forResource: "success", withExtension: "wav") else { return }
        guard let failURL = Bundle.main.url(forResource: "fail", withExtension: "mp3") else { return }
        
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            
            player = try AVAudioPlayer(contentsOf: success ? successURL : failURL)
            
            guard let player = player else { return }
            
            player.play()
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    @objc private func didTapGuessButton() {
        playSound(success: true)
        gameService.guessedWord()
        updateUI()
    }
    
    @objc private func didTapSkipButton() {
        playSound(success: false)
        gameService.skipWord()
        updateUI()
    }

}

extension GameViewController: GameServiceDelegate {
    func handleWord(gameService: GameBaseService, word: String, action: String?) {
        actionLabel.text = action
        wordLabel.text = word.uppercased()
    }
    
    func timerDidUpdate(gameService: GameBaseService, seconds: Int) {
        if seconds == 0 {
            timerView.forceTitle = "?????????????????? ??????????"
        } else {
            timerView.timerValue = seconds
        }
    }
    
    func teamRoundDidEnd(gameService: GameBaseService) {
        guessButton.isEnabled = false
        skipButton.isEnabled = false
        dismiss(animated: true, completion: nil)
        jokeService.getJoke { [weak self] result in
            switch result {
            case .success(let joke):
                let alert = UIAlertController(title: "Joke", message: "\(joke.setup)\n\(joke.punchline)", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "??????????", style: .destructive, handler: { [weak self] _ in
                    self?.coordinator?.goToResults()
                }))
                self?.present(alert, animated: true)
            case .failure(_):
                self?.coordinator?.goToResults()
            }
        }
    }
}
