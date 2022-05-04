//
//  GameSettingsViewController.swift
//  Alias
//
//  Created by Victor Rubenko on 01.05.2022.
//

import SwiftUI
import UIKit

class GameSettingsViewController: UIViewController {

    private var gameService: GameServiceProtocol!
    private var componentsFactory: ComponentsBaseFactory!
    
    private lazy var bottomButton: UIButton = {
        let button = componentsFactory.bottomButton()
        button.setTitle("Далее", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        //button.addTarget(self, action: #selector(didTapBottomButton), for: .touchUpInside)
        return button
    }()
    
    private let bottomButtonContainer: UIView = {
        let view = UIView()
        view.backgroundColor = Constants.Colors.bottomButtonColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(bottomButtonContainer)
        bottomButtonContainer.addSubview(bottomButton)

        NSLayoutConstraint.activate([
            bottomButtonContainer.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            bottomButtonContainer.leadingAnchor.constraint(equalTo: bottomButton.leadingAnchor),
            bottomButtonContainer.trailingAnchor.constraint(equalTo: bottomButton.trailingAnchor),
            bottomButtonContainer.topAnchor.constraint(equalTo: bottomButton.topAnchor),
            
            bottomButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            bottomButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            bottomButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            bottomButton.heightAnchor.constraint(equalToConstant: Constants.Sizes.BottomButton.height),
        ])
        // Do any additional setup after loading the view.
    }
    
    init(gameService: GameServiceProtocol, componentsFactory: ComponentsBaseFactory) {
        self.componentsFactory = componentsFactory
        self.gameService = gameService
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    struct SwiftUIController: UIViewControllerRepresentable {
        typealias UIViewControllerType = GameSettingsViewController
        
        func makeUIViewController(context: Context) -> UIViewControllerType {
            let viewController = UIViewControllerType(gameService: GameServiceForTest.shared, componentsFactory: ComponentFactory())
            return viewController
        }
        
        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
            
        }
    }
    
    struct SwiftUIController_Previews: PreviewProvider {
        static var previews: some View {
            SwiftUIController().edgesIgnoringSafeArea(.all)
        }
    }
}
