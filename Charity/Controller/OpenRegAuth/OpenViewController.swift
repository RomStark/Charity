//
//  ViewController.swift
//  Charity
//
//  Created by Al Stark on 16.10.2022.
//

import UIKit
import SnapKit



final class ViewController: UIViewController {
    
    private lazy var emailSignButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sign in with email", for: .normal)
        button.layer.cornerRadius = 20.0
        button.layer.borderColor = .init(red: 0, green: 0, blue: 0, alpha: 0.5)
        button.layer.borderWidth = 1.0
        button.backgroundColor = .red
        button.addTarget(self, action: #selector(emailButtonPressed), for: .touchUpInside)
        return button
    }()
    
    private lazy var googleSignButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.setTitleColor(UIColor(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
        button.layer.cornerRadius = 20.0
        button.layer.borderColor = .init(red: 0, green: 0, blue: 0, alpha: 0.5)
        button.layer.borderWidth = 1
        button.setTitle("Sign in with Google", for: .normal)
        return button
    }()
    
    private lazy var faceBookSignButton: UIButton = {
        var button = UIButton()
        button.backgroundColor = .blue
        button.layer.cornerRadius = 20
        button.layer.borderColor = .init(red: 0, green: 0, blue: 0, alpha: 0.5)
        button.layer.borderWidth = 1
        button.setTitle("Sign in with Facebook", for: .normal)
        return button
    }()
    
    private lazy var buttonsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.addArrangedSubviews(
            [
                emailSignButton,
                googleSignButton,
                faceBookSignButton,
            ]
        )
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(buttonsStackView)
        makeConstraints()
    }
    
    private func makeConstraints() {
        buttonsStackView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.height.width.equalTo(220)
        }
    }
    
    @objc private func emailButtonPressed() {
        self.navigationController?.pushViewController(EmailSignViewController(), animated: true)
    }
}
