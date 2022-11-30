//
//  MainTableViewController.swift
//  Charity
//
//  Created by Al Stark on 28.11.2022.
//

import UIKit
import FirebaseAuth

final class MainTableViewController: UIViewController {
    
    private var charities = [Charity]()
    
    private var tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.singleLine
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    private var signOutButton: UIButton = {
        var button = UIButton()
        button.setTitle("Выйти", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray
//        setupSignOutButton()
        setupNavVC()
        setupTableView()
        getCharities()
    }
    
    private func getCharities() {
        Service.shared.getListOfCharitys { [weak self] charities in
            self?.charities = charities
            self?.tableView.reloadData()
        }
    }
    
    private func setupNavVC() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(signOutButtonTapped))
    }
    
    private func setupTableView() {
        tableView.register(CharitysTableViewCell.self, forCellReuseIdentifier: CharitysTableViewCell.reuseIdentifier)
        view.addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func setupSignOutButton() {
        self.view.addSubview(signOutButton)
        signOutButton.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 40).isActive = true
        signOutButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        signOutButton.addTarget(self, action: #selector(signOutButtonTapped), for: .touchUpInside)
    }
    
    @objc
    private func signOutButtonTapped() {
        do {
            try? Auth.auth().signOut()
        }
    }
}

extension MainTableViewController: UITableViewDelegate {
    
}

extension MainTableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return charities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CharitysTableViewCell.reuseIdentifier, for: indexPath) as? CharitysTableViewCell
        cell?.configure(charity: charities[indexPath.row])
        return cell ?? UITableViewCell()
    }
    
    
}
