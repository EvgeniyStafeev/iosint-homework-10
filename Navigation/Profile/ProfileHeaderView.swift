//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by Евгений Стафеев on 01.11.2022.
//

import UIKit

class ProfileHeaderView: UIView {
    
    public let user = User(login: "1111", password: "2222", fullName: "Evgeny Stafeev", statusLabel: "Учусь в Нетологии", avatar: (UIImage(named: "Фото11")!))
    
    lazy var profileAvatarImage: UIImageView = {
        let profileAvatarImage = UIImageView()
        profileAvatarImage.image = user.avatar
        profileAvatarImage.translatesAutoresizingMaskIntoConstraints = false
        profileAvatarImage.clipsToBounds = true
        profileAvatarImage.backgroundColor = .systemBackground
        profileAvatarImage.layer.cornerRadius = 55.0
        profileAvatarImage.layer.borderWidth = 3.0
        profileAvatarImage.layer.borderColor = UIColor.white.cgColor
        //profileAvatarImage.image = tempImage
        return profileAvatarImage
    }()
    
    lazy var profileNameLabel: UILabel = {
        let profileNameLabel = UILabel()
        profileNameLabel.translatesAutoresizingMaskIntoConstraints = false
        //profileNameLabel.text = "Hipster Cat"
        profileNameLabel.textColor = .black
        profileNameLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        return profileNameLabel
    }()
    
    lazy var profileStatusTextField: UILabel = {
        let profileStatusTextField = UILabel()
        profileStatusTextField.translatesAutoresizingMaskIntoConstraints = false
        //profileStatusTextField.text = "Waiting for something..."
        profileStatusTextField.textColor = .gray
        profileStatusTextField.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        profileStatusTextField.isUserInteractionEnabled = false
        return profileStatusTextField
    }()
    
    lazy var showStatusButton: UIButton = {
            let showStatusButton = UIButton()
        showStatusButton.translatesAutoresizingMaskIntoConstraints = false
        showStatusButton.backgroundColor = .systemBlue
        showStatusButton.setTitle("Set status", for: .normal)
        showStatusButton.setTitleColor(UIColor.white, for: .normal)
        showStatusButton.layer.cornerRadius = 12.0
        showStatusButton.layer.shadowOffset = CGSize(width: 4, height: 4)
        showStatusButton.layer.shadowRadius = 4.0
        showStatusButton.layer.shadowColor = UIColor.black.cgColor
        showStatusButton.layer.shadowOpacity = 0.7
        showStatusButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
            return showStatusButton
        }()
    
    lazy var newStatus: UITextField = {
        let newStatus = UITextField()
        newStatus.translatesAutoresizingMaskIntoConstraints = false
        newStatus.indent(size: 10)
        newStatus.placeholder = "Enter text here ..."
        newStatus.textColor = .black
        newStatus.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        newStatus.backgroundColor = .white
        newStatus.layer.borderWidth = 1.0
        newStatus.layer.borderColor = UIColor.black.cgColor
        newStatus.layer.cornerRadius = 12.0
        newStatus.addTarget(self, action: #selector(statusTextChanges), for: .editingChanged)
            return newStatus
         }()
        
    override init(frame: CGRect) {
             super.init(frame: frame)
             setupLayout()
             createUser()
         }

         required init?(coder: NSCoder) {
             super.init(coder: coder)
         }
    
    private var statusText = String()
    
    private func createUser() {
        profileAvatarImage.image = user.avatar
        profileNameLabel.text = user.fullName
        profileStatusTextField.text = user.statusLabel
    }
    
    @objc private func buttonPressed() {
        profileStatusTextField.text = statusText
        self.endEditing(true)
        print(statusText)
    }
    
    @objc private func statusTextChanges() {
        statusText = newStatus.text ?? "No text"
            print(newStatus)
        }
    
    private func setupLayout() {
        [profileAvatarImage, profileNameLabel, profileStatusTextField, showStatusButton, newStatus].forEach { addSubview($0) }
        
        NSLayoutConstraint.activate([
            profileAvatarImage.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16.0),
            profileAvatarImage.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16.0),
            profileAvatarImage.heightAnchor.constraint(equalToConstant: 110.0),
            profileAvatarImage.widthAnchor.constraint(equalToConstant: 110.0),
            
            profileNameLabel.leadingAnchor.constraint(equalTo: profileAvatarImage.trailingAnchor, constant: 16.0),
            profileNameLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 27.0),
            profileNameLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16.0),
            
            profileStatusTextField.leadingAnchor.constraint(equalTo: profileAvatarImage.trailingAnchor, constant: 16.0),
            profileStatusTextField.bottomAnchor.constraint(equalTo: showStatusButton.topAnchor, constant: -68.0),
            profileStatusTextField.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16.0),
            
            newStatus.leadingAnchor.constraint(equalTo: profileAvatarImage.trailingAnchor, constant: 16.0),
            newStatus.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16.0),
            newStatus.topAnchor.constraint(equalTo: profileAvatarImage.bottomAnchor, constant: -16.0),
            newStatus.heightAnchor.constraint(equalToConstant: 40),
            
            showStatusButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16.0),
            showStatusButton.topAnchor.constraint(equalTo: profileAvatarImage.bottomAnchor, constant: 32.0),
            showStatusButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16.0),
            showStatusButton.heightAnchor.constraint(equalToConstant: 50.0)
        ])
    }
}
