//
//  FeedViewController.swift
//  Navigation
//
//  Created by Евгений Стафеев on 01.11.2022.
//

import UIKit
import StorageService

class FeedViewController: UIViewController {
    
    private lazy var verticalStack: UIStackView = {
        let verticalStack = UIStackView()
        verticalStack.axis = .vertical
        verticalStack.spacing = 10
        verticalStack.distribution = .fillEqually
        verticalStack.layer.cornerRadius = 10
        verticalStack.clipsToBounds = true
        verticalStack.translatesAutoresizingMaskIntoConstraints = false
        return verticalStack
    }()
    
    private lazy var makeButton: CustomButton = {
        let buttonOne = CustomButton(title: "Post", titleColor: .black)
        buttonOne.setBackgroundImage(#imageLiteral(resourceName: "blue_pixel"), for: .normal)
        buttonOne.tag = 0
        buttonOne.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)
        return buttonOne
    }()
    
    private lazy var checkGuessButton: CustomButton = {
        let checkGuessButton = CustomButton(title: "checkGuessButton", titleColor: .black)
        checkGuessButton.backgroundColor = .white
        checkGuessButton.layer.cornerRadius = 10
        checkGuessButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        return checkGuessButton
    }()
     
    private lazy var wordTextField: CustomTextField = {
        let wordTextField = CustomTextField(font: UIFont.systemFont(ofSize: 16), placeholder: "Cекретное слово", borderColor: UIColor.lightGray.cgColor, borderWidth: 0.5)
        wordTextField.backgroundColor = .systemGray6
        wordTextField.layer.cornerRadius = 5
        return wordTextField
    }()
    
    private lazy var labelCheck: UILabel = {
       let labelCheck = UILabel()
        labelCheck.textColor = .black
        labelCheck.backgroundColor = .systemRed
        labelCheck.layer.cornerRadius = 10
        labelCheck.textAlignment = .center
        labelCheck.font = UIFont.boldSystemFont(ofSize: 20)
        labelCheck.clipsToBounds = true
        labelCheck.alpha = 0
        labelCheck.translatesAutoresizingMaskIntoConstraints = false
        return labelCheck
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Лента"
        self.tabBarItem = UITabBarItem(title: title, image: UIImage(systemName: "book"), tag: 0)
        view.backgroundColor = UIColor.systemRed
        setupVerticalStack()
        actionButton()
        let tap = UITapGestureRecognizer(target: self, action: #selector(dissmisKeyboard))
        view.addGestureRecognizer(tap)

    }
    @objc func dissmisKeyboard() {
        self.view.endEditing(true)
    }
    
    private func labelShow(text: String, color: UIColor) {
        UIView.animate(withDuration: 2) {
            self.labelCheck.text = text
            self.labelCheck.textColor = .black
            self.labelCheck.backgroundColor = color
            self.labelCheck.alpha = 1
        }
    }
    
    private func setupVerticalStack() {
        view.addSubview(checkGuessButton)
        view.addSubview(wordTextField)
        view.addSubview(labelCheck)
        checkGuessButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(verticalStack)
        verticalStack.addArrangedSubview(makeButton)
        verticalStack.addArrangedSubview(makeButton)
        NSLayoutConstraint.activate([
            wordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            wordTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15),
            wordTextField.heightAnchor.constraint(equalToConstant: 25),
            wordTextField.widthAnchor.constraint(equalToConstant: view.frame.width / 2),
            checkGuessButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            checkGuessButton.topAnchor.constraint(equalTo: wordTextField.bottomAnchor, constant: 20),
            checkGuessButton.heightAnchor.constraint(equalToConstant: 25),
            checkGuessButton.widthAnchor.constraint(equalToConstant: view.frame.width / 2),
            labelCheck.topAnchor.constraint(equalTo: checkGuessButton.bottomAnchor, constant: 10),
            labelCheck.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            labelCheck.heightAnchor.constraint(equalToConstant: 25),
            labelCheck.widthAnchor.constraint(equalToConstant: view.frame.width / 2),
            verticalStack.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            verticalStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            verticalStack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 20),
            verticalStack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            verticalStack.heightAnchor.constraint(equalToConstant: 90)
        ])
    }
    private func actionButton() {
        makeButton.action = {
            guard self.makeButton.tag == 0 else { return }
            let postVC = PostViewController()
            postVC.myTitle = "Ошибка"
            postVC.myMessage = "Вернутся обратно?"
            self.navigationController?.pushViewController(postVC, animated: true)
        }
    
        checkGuessButton.action = {
            guard self.wordTextField.text != nil else { return }
        }
        checkGuessButton.action = {
            if let word = self.wordTextField.text {
                let feedModel = FeedModel()
                let check = feedModel.check(word: word)
                print(check)
                check ? self.labelShow(text: "Верно", color: .green) : self.labelShow(text: "Не верно", color: .systemOrange)
            }
        }
    }
        
}

