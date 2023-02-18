//
//  LoginViewController.swift
//  Navigation
//
//  Created by Евгений Стафеев on 15.11.2022.
//

import UIKit

class LogInViewController: UIViewController {
    var loginDelegate: LoginViewControllerDelegate?
    private var timer: Timer?
    private let currentUserService = CurrentUserService()
    private let testUserService = TestUserService()
    private let brutForceService = BrutForceService()
    
    private let notificationCenter = NotificationCenter.default
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let contentView: UIView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIView())
    
    private lazy var logoImage: UIImageView = {
        let logoImage = UIImageView()
        logoImage.image = UIImage(named: "logo")
        logoImage.translatesAutoresizingMaskIntoConstraints = false
        return logoImage
    }()
    
    private lazy var userLoginTextField: UITextField = {
        let userLoginTextField = UITextField()
        userLoginTextField.translatesAutoresizingMaskIntoConstraints = false
        userLoginTextField.indent(size: 10)
        userLoginTextField.placeholder = "Login"
        userLoginTextField.textColor = .black
        userLoginTextField.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        userLoginTextField.autocapitalizationType = .none
        userLoginTextField.backgroundColor = .systemGray6
        userLoginTextField.delegate = self
        return userLoginTextField
    }()
    
    private lazy var userPasswordTextField: UITextField = {
        let userPasswordTextField = UITextField()
        userPasswordTextField.translatesAutoresizingMaskIntoConstraints = false
        userPasswordTextField.indent(size: 10)
        userPasswordTextField.placeholder = "Password"
        userPasswordTextField.isSecureTextEntry = true
        userPasswordTextField.textColor = .black
        userPasswordTextField.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        userPasswordTextField.backgroundColor = .systemGray6
        userPasswordTextField.delegate = self
        return userPasswordTextField
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        stackView.spacing = 0.5
        stackView.layer.borderWidth = 0.5
        stackView.layer.cornerRadius = 10
        stackView.backgroundColor = .lightGray
        stackView.clipsToBounds = true
        stackView.layer.borderColor = UIColor.lightGray.cgColor
        return stackView
    }()
    
    private lazy var logInButton: CustomButton = {
        let logInButton = CustomButton(title: "LOG IN", titleColor: .white)
        logInButton.clipsToBounds = true
        logInButton.setBackgroundImage(#imageLiteral(resourceName: "blue_pixel"), for: .normal)
        logInButton.layer.cornerRadius = 10
        
        if logInButton.isSelected || logInButton.isHighlighted || logInButton.isEnabled == false {
            logInButton.backgroundColor?.withAlphaComponent(0.8)
        }
        logInButton.addTarget(self, action: #selector(actionButton), for: .touchUpInside)
        
        return logInButton
    }()
    
    private lazy var getPassButton: CustomButton = {
        let getPassButton = CustomButton(title: "Подобрать пароль", titleColor: .white)
        getPassButton.clipsToBounds = true
        getPassButton.setBackgroundImage(#imageLiteral(resourceName: "blue_pixel"), for: .normal)
        getPassButton.layer.cornerRadius = 10
        return getPassButton
    }()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = .black
        activityIndicator.hidesWhenStopped = true
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicator
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupGestures()
        setupViews()
        stateMyButton(sender: logInButton)
        actionButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        notificationCenter.addObserver(self, selector: #selector(didShowKeyboard(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(didHideKeyboard(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        setupTimer(10, repeats: true)
    }
    
    
    private func setupTimer(_ interval: Double, repeats: Bool) {
        timer = Timer.scheduledTimer(timeInterval: interval,
                                     target: self,
                                     selector: #selector(passwordController),
                                     userInfo: nil,
                                     repeats: repeats)
    }
    
    @objc func passwordController() {
        let title = "Забыли пароль?"
        let titleRange = (title as NSString).range(of: title)
        let titleAttribute = NSMutableAttributedString.init(string: title)
        titleAttribute.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.black , range: titleRange)
        titleAttribute.addAttribute(NSAttributedString.Key.font, value: UIFont(name: "HelveticaNeue-Bold", size: 25)!, range: titleRange)
        
        let message = "Можно с Вашего разрешения подобрать пароль?"
        let messageRange = (message as NSString).range(of: message)
        let messageAttribute = NSMutableAttributedString.init(string: message)
        messageAttribute.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.red , range: messageRange)
        messageAttribute.addAttribute(NSAttributedString.Key.font, value: UIFont(name: "Helvetica", size: 17)!, range: messageRange)
        let alert = UIAlertController(title: "", message: "",  preferredStyle: .actionSheet)
        alert.setValue(titleAttribute, forKey: "attributedTitle")
        alert.setValue(messageAttribute, forKey: "attributedMessage")
        
        let okAction = UIAlertAction(title: "Да", style: .destructive) {_ in
            self.timer?.invalidate()
            self.getPassword()
            
        }
        let noAction = UIAlertAction(title: "Нет", style: .cancel) { alertAction in
            self.timer?.invalidate()
        }
        alert.addAction(okAction)
        alert.addAction(noAction)
        present(alert, animated: true, completion: nil)
    }
    
    private func setupViews() {
        view.addSubview(scrollView)
        scrollView.addSubview(logoImage)
        stackView.addArrangedSubview(userLoginTextField)
        stackView.addArrangedSubview(userPasswordTextField)
        scrollView.addSubview(stackView)
        scrollView.addSubview(logInButton)
        scrollView.addSubview(getPassButton)
        userPasswordTextField.addSubview(activityIndicator)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            logoImage.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 120),
            logoImage.heightAnchor.constraint(equalToConstant: 120),
            logoImage.widthAnchor.constraint(equalToConstant: 120),
            logoImage.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            stackView.topAnchor.constraint(equalTo: logoImage.bottomAnchor, constant: 120),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 16),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -16),
            stackView.heightAnchor.constraint(equalToConstant: 100),
            logInButton.topAnchor.constraint(equalTo: stackView.bottomAnchor,constant: 16),
            logInButton.heightAnchor.constraint(equalToConstant: 50),
            logInButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            logInButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            getPassButton.topAnchor.constraint(equalTo: logInButton.bottomAnchor, constant: 20),
            getPassButton.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            getPassButton.heightAnchor.constraint(equalToConstant: 50),
            getPassButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            getPassButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            activityIndicator.centerYAnchor.constraint(equalTo: userPasswordTextField.centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: userPasswordTextField.centerXAnchor)
            
        ])
    }
    
    @objc func dissmiskeyboard() {
        view.endEditing(true)
        scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
        
    }
    private func getPassword() {
        self.userPasswordTextField.isSecureTextEntry = true
        self.userPasswordTextField.text = "Qw2"
        let queue = DispatchQueue(label: "ru.IOSInt-homeworks.9", attributes: .concurrent)
        let workItem = DispatchWorkItem {
            self.brutForceService.bruteForce(passwordToUnlock: "qaz")
        }
        self.activityIndicator.startAnimating()
        queue.async(execute: workItem)
        workItem.notify(queue: .main) {
            self.userPasswordTextField.isSecureTextEntry = false
            self.activityIndicator.stopAnimating()
        }
    }
    
    @objc private func actionButton() {
        logInButton.action = { [self] in
            
#if DEBUG
            let user = currentUserService.userNew
#else
            let user = testUserService.testUser
#endif
            
            guard userLoginTextField.text == user.login, userPasswordTextField.text == user.password else {
                let alert = UIAlertController(title: "Ошибка", message: "Нет данных", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ок", style: .default, handler: nil))
                self.present(alert, animated: true)
                return
            }
            let profileVC = ProfileViewController()
            self.navigationController?.pushViewController(profileVC, animated: false)
        }
        getPassButton.action = {
            self.getPassword()
        }
    }
    
    @objc private func didShowKeyboard(_ notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            let logInButtonPointY =  logInButton.frame.origin.y + logInButton.frame.height
            let keyboardOriginY = scrollView.frame.height - keyboardHeight
            let yOffset = keyboardOriginY < logInButtonPointY ? logInButtonPointY - keyboardOriginY + 16 : 0
          
            scrollView.contentOffset = CGPoint(x: 0, y: yOffset)
        }
    }
    @objc private func didHideKeyboard(_ notification: Notification) {
        self.dissmiskeyboard()
    }
    
    private func setupGestures() {
        let tapDissmis = UITapGestureRecognizer(target: self, action: #selector(dissmiskeyboard))
        view.addGestureRecognizer(tapDissmis)
    }
    
    func stateMyButton(sender: UIButton) {
        switch sender.state {
        case .normal:
            sender.alpha = 1.0
        case .selected:
            sender.alpha = 0.8
        case .highlighted:
            sender.alpha = 0.8
        default:
            sender.alpha = 1.0
        }
    }
}
extension LogInViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
}



