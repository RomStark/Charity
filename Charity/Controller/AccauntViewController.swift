//
//  AccauntViewController.swift
//  Charity
//
//  Created by Al Stark on 03.12.2022.
//

import UIKit
import FirebaseAuth

class AccauntViewController: UIViewController {
    
    private let shared = Service.shared
    private let userDefaults = UserDefaults.standard

    private var photo: UIImageView = {
        var image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private var nameLabel: UILabel = {
        var label = UILabel()
        label.numberOfLines = 1
        return label
    }()
    
    private var emailLabel: UILabel = {
        var label = UILabel()
        label.numberOfLines = 1
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        stackView.spacing = 6
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubviews(
            [nameLabel,
             emailLabel,
            ]
        )
        return stackView
    }()
    
    private var logOutButton: UIButton = {
        var button = UIButton()
        button.setTitle("Выйти", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gray
        setupPhoto()
        setupStackView()
        getUserInfo()
        setupLogOutButton()
    }
    
    private func setupPhoto() {
        view.addSubview(photo)
        photo.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20.0).isActive = true
        photo.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10.0).isActive = true
        photo.widthAnchor.constraint(equalToConstant: 120.0).isActive = true
        photo.heightAnchor.constraint(equalTo: photo.widthAnchor).isActive = true
    }
    
    private func setupStackView() {
        view.addSubview(stackView)
        stackView.leadingAnchor.constraint(equalTo: photo.trailingAnchor, constant: 20.0).isActive = true
        stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20.0).isActive = true
    }
    
    private func setupLogOutButton() {
        view.addSubview(logOutButton)
        logOutButton.topAnchor.constraint(equalTo: photo.bottomAnchor, constant: 30).isActive = true
        logOutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        logOutButton.addTarget(self, action: #selector(logOutBuutonTapped), for: .touchUpInside)
    }
    
    @objc private func logOutBuutonTapped() {
        do {
            try? Auth.auth().signOut()
            userDefaults.set("", forKey: "uid")
        }
    }
    
    private func getUserInfo() {
        var url: String = ""
        shared.getUser { [weak self] user in
            self?.nameLabel.text = user.name
            self?.emailLabel.text = user.email
            url = user.photoURL ?? ""
        }
        loadPhoto(urlString: url )
    }
    
    func loadPhoto(urlString: String) {
        guard let url = URL(string: urlString) else {
            self.photo.image = UIImage(named: "imageCharity")
            return
        }
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.photo.image = image
                    }
                }
            }
        }
    }
}
