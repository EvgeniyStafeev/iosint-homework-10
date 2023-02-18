//
//  PostTableViewCell.swift
//  Navigation
//
//  Created by Татьяна Новичихина on 18.11.2022.
//

import UIKit
import StorageService

class PostTableViewCell: UITableViewCell {
    
    private let postView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    private let authorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.numberOfLines = 2
        return label
    }()
    
    private let labelDescription: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.numberOfLines = 0
        label.textAlignment = .justified
        return label
    }()
    
    private let postImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .systemBackground
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let like: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        return label
    }()
    
    private let labelView: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCell(_ postVk: PostVK) {
        authorLabel.text = postVk.author
        labelDescription.text = postVk.description
        postImage.image = UIImage(named: postVk.image)
        like.text = "Like: \(postVk.like)"
        labelView.text = "Просмотры: \(postVk.view)"
    }
    
    private func setupLayout() {
        [postView, authorLabel, labelDescription, postImage, like, labelView].forEach { contentView.addSubview($0) }
        
        let inset: CGFloat = 16
        
        NSLayoutConstraint.activate([
            
            postView.topAnchor.constraint(equalTo: contentView.topAnchor),
            postView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            postView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            postView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            authorLabel.topAnchor.constraint(equalTo: postView.topAnchor, constant: inset),
            authorLabel.leadingAnchor.constraint(equalTo: postView.leadingAnchor, constant: inset),
            authorLabel.trailingAnchor.constraint(equalTo: postView.trailingAnchor, constant: -inset),
            
            postImage.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: 12),
            postImage.leadingAnchor.constraint(equalTo: postView.leadingAnchor),
            postImage.widthAnchor.constraint(equalTo: postView.widthAnchor),
            postImage.heightAnchor.constraint(equalTo: postImage.widthAnchor),
            
            labelDescription.topAnchor.constraint(equalTo: postImage.bottomAnchor, constant: inset),
            labelDescription.leadingAnchor.constraint(equalTo: postView.leadingAnchor, constant: inset),
            labelDescription.trailingAnchor.constraint(equalTo: postView.trailingAnchor, constant: -inset),
            
            like.topAnchor.constraint(equalTo: labelDescription.bottomAnchor, constant: inset),
            like.leadingAnchor.constraint(equalTo: postView.leadingAnchor, constant: inset),
            like.bottomAnchor.constraint(equalTo: postView.bottomAnchor, constant: -inset),
            
            labelView.topAnchor.constraint(equalTo: labelDescription.bottomAnchor, constant: inset),
            labelView.trailingAnchor.constraint(equalTo: postView.trailingAnchor, constant: -inset),
            labelView.bottomAnchor.constraint(equalTo: postView.bottomAnchor, constant: -inset),
        ])
    }
}
