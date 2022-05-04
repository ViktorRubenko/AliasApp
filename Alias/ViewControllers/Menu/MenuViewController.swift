//
//  MenuViewController.swift
//  Alias
//
//  Created by Victor Rubenko on 01.05.2022.
//

import UIKit

class MenuViewController: UIViewController, MainBaseCoordinated {
    
    weak var coordinator: MainBaseCoordinator?

    private lazy var newGameButton: UIButton = {
        let button = componentsFactory.mainMenuButton()
        button.setTitle("Новая игра", for: .normal)
        button.addTarget(self, action: #selector(didTapNewGameButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var rulesButton: UIButton = {
        let button = componentsFactory.mainMenuButton()
        button.setTitle("Правила", for: .normal)
        button.addTarget(self, action: #selector(didTapRulesButton), for: .touchUpInside)
        return button
    }()
    
    private let buttonsContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var logoImageView = componentsFactory.logoImageView()
    private var componentsFactory: ComponentsBaseFactory!
    
    private var needConfigureLayouts = true
    
    init(coordinator: MainBaseCoordinator, componentsFactory: ComponentsBaseFactory) {
        self.coordinator = coordinator
        self.componentsFactory = componentsFactory
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupNavBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
        startAnimation()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
        logoImageView.layer.removeAllAnimations()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if needConfigureLayouts {
            buttonsContainer.layoutIfNeeded()
            needConfigureLayouts = false
            [rulesButton, newGameButton].forEach {
                $0.layer.cornerRadius = $0.bounds.height * 0.5
                $0.layer.shadowOpacity = 1
                $0.layer.shadowColor = UIColor.gray.withAlphaComponent(0.8).cgColor
                $0.layer.shadowOffset = CGSize(width: 0, height: 5)
            }
            logoImageView.layer.shadowColor = UIColor.gray.cgColor
            logoImageView.layer.shadowOpacity = 1
            logoImageView.layer.shadowOffset = CGSize(width: 5, height: 5)
        }
    }
    
    private func setupViews() {
        let safeArea = view.safeAreaLayoutGuide
        
        view.backgroundColor = Constants.Colors.mainBackgroundColor
        
        view.addSubview(logoImageView)
        view.addSubview(buttonsContainer)
        buttonsContainer.addSubview(newGameButton)
        buttonsContainer.addSubview(rulesButton)
        
        NSLayoutConstraint.activate([
            logoImageView.widthAnchor.constraint(equalTo: safeArea.widthAnchor, multiplier: 0.5),
            logoImageView.heightAnchor.constraint(equalTo: logoImageView.widthAnchor),
            logoImageView.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            logoImageView.centerYAnchor.constraint(equalTo: safeArea.centerYAnchor, constant: -100),
            
            buttonsContainer.widthAnchor.constraint(equalTo: safeArea.widthAnchor),
            buttonsContainer.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            buttonsContainer.topAnchor.constraint(equalTo: logoImageView.bottomAnchor),
            buttonsContainer.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            
            rulesButton.widthAnchor.constraint(greaterThanOrEqualTo: buttonsContainer.widthAnchor, multiplier: 0.7),
            rulesButton.widthAnchor.constraint(lessThanOrEqualTo: buttonsContainer.widthAnchor),
            rulesButton.heightAnchor.constraint(equalToConstant: 60),
            rulesButton.centerXAnchor.constraint(equalTo: buttonsContainer.centerXAnchor),
            rulesButton.topAnchor.constraint(equalTo: buttonsContainer.centerYAnchor, constant: 5),
            
            newGameButton.widthAnchor.constraint(equalTo: rulesButton.widthAnchor),
            newGameButton.heightAnchor.constraint(equalToConstant: 60),
            newGameButton.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            newGameButton.bottomAnchor.constraint(equalTo: buttonsContainer.centerYAnchor, constant: -5),
        ])
    }
    
    private func setupNavBar() {
        let backItem = UIBarButtonItem()
        backItem.title = "Назад"
        navigationItem.backBarButtonItem = backItem
    }
    
    private func startAnimation() {
        UIView.animate(withDuration: 2, delay: 0, options: [.autoreverse, .repeat]) {
            self.logoImageView.transform = CGAffineTransform(scaleX: 1.15, y: 1.15)
        } completion: { _ in
            self.logoImageView.transform = .identity
        }
    }
    
    @objc private func didTapNewGameButton() {
        coordinator?.goToPreparations()
    }
    
    @objc private func didTapRulesButton() {
        coordinator?.goToRules()
    }
}
