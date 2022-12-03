//
//  EmailSignViewController.swift
//  Charity
//
//  Created by Al Stark on 16.11.2022.
//

import UIKit


final class EmailSignViewController: UIViewController {
    private let shared = Service.shared
    private var signUp: Bool = true{
        willSet {
            if newValue {
                regauthButton.setTitle("Войти", for: .normal)
                nameTextField.isHidden = false
                changePasswordButton.isHidden = true
            } else {
                regauthButton.setTitle("Регистрация", for: .normal)
                nameTextField.isHidden = true
                changePasswordButton.isHidden = false
            }
        }
    }
    private var changePasswordButton: UIButton = {
        var button = UIButton()
        button.setTitle("Не помню пароль", for: .normal)
        button.setTitleColor(UIColor(red: 0, green: 0, blue: 255, alpha: 1), for: .normal)
        
        return button
    }()
    private var nameTextField: UITextField = {
        var textField = UITextField()
        let placeholderText = NSAttributedString(string: "Введите имя", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        textField.attributedPlaceholder = placeholderText
        textField.borderStyle = .bezel
        textField.layer.borderColor = .init(red: 0, green: 0, blue: 0, alpha: 1)
        textField.layer.borderWidth = 1.0
        textField.backgroundColor = .white
        textField.textColor = .black
        textField.layer.cornerRadius = 10.0
        textField.borderStyle = .roundedRect
        return textField
    }()
    private var emailTextField: UITextField = {
        var textField = UITextField()
        textField.placeholder = "email"
        let placeholderText = NSAttributedString(string: "email", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        textField.attributedPlaceholder = placeholderText
        textField.borderStyle = .bezel
        textField.layer.borderColor = .init(red: 0, green: 0, blue: 0, alpha: 1)
        textField.layer.borderWidth = 1.0
        textField.backgroundColor = .white
        textField.textColor = .black
        textField.layer.cornerRadius = 10.0
        textField.borderStyle = .roundedRect
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        return textField
    }()
    private var passwordTextField: UITextField = {
        var textField = UITextField()
        textField.backgroundColor = .white

        let placeholderText = NSAttributedString(string: "Введите пароль", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        textField.attributedPlaceholder = placeholderText
        textField.borderStyle = .bezel
        textField.backgroundColor = .white
        textField.layer.borderColor = .init(red: 0, green: 0, blue: 0, alpha: 1)
        textField.layer.borderWidth = 1.0
        textField.textColor = .black
        textField.layer.cornerRadius = 10.0
        textField.borderStyle = .roundedRect
//        textField.isSecureTextEntry = true
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        return textField
    }()
    
    private var signButton: UIButton = {
        var button = UIButton()
        button.setTitle("Next", for: .normal)
        button.backgroundColor = .red
        button.layer.cornerRadius = 5
        return button
    }()
    
    private var regauthButton: UIButton =  {
        var button = UIButton()
        button.setTitle("Войти", for: .normal)
        button.setTitleColor(UIColor(red: 0, green: 0, blue: 255, alpha: 1), for: .normal)
        return button
        
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Sign in with e-mail"
        self.view.backgroundColor = .white
        setupUI()
    }
    private func setupUI() {
        setupNameTextField()
        setupEmailTextField()
        setupPasswordTextField()
        setupSignButton()
        setupregauthButton()
        setupChangePasswordButton()
    }
    
    private func setupNameTextField() {
        self.view.addSubview(nameTextField)
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        nameTextField.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        nameTextField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20).isActive = true
        nameTextField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20).isActive = true
        nameTextField.widthAnchor.constraint(equalToConstant: 70).isActive = true
    }
    private func setupEmailTextField() {
        self.view.addSubview(emailTextField)
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        emailTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 10).isActive = true
        emailTextField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20).isActive = true
        emailTextField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20).isActive = true
        emailTextField.widthAnchor.constraint(equalToConstant: 70).isActive = true
    }
    private func setupPasswordTextField() {
        self.view.addSubview(passwordTextField)
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 10).isActive = true
        passwordTextField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20).isActive = true
        passwordTextField.widthAnchor.constraint(equalTo: emailTextField.widthAnchor).isActive = true
        passwordTextField.heightAnchor.constraint(equalTo: emailTextField.heightAnchor).isActive = true
    }
    private func setupSignButton() {
        signButton.addTarget(self, action: #selector(signButtonPressed), for: .touchUpInside)
        self.view.addSubview(signButton)
        signButton.translatesAutoresizingMaskIntoConstraints = false
        signButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 10).isActive = true
        signButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20).isActive = true
        signButton.widthAnchor.constraint(equalToConstant: 120).isActive = true
        signButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    private func setupregauthButton() {
        view.addSubview(regauthButton)
        regauthButton.addTarget(self, action: #selector(regauthButtonTapped), for: .touchUpInside)
        regauthButton.translatesAutoresizingMaskIntoConstraints = false
        regauthButton.topAnchor.constraint(equalTo: signButton.bottomAnchor, constant: 15).isActive = true
        regauthButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
    }
    
    func setupChangePasswordButton() {
        changePasswordButton.addTarget(self, action: #selector(changePassowrdButtonTapped), for: .touchUpInside)
        
        self.view.addSubview(changePasswordButton)
        changePasswordButton.translatesAutoresizingMaskIntoConstraints = false
        changePasswordButton.topAnchor.constraint(equalTo: regauthButton.bottomAnchor, constant: 10).isActive = true
        changePasswordButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        changePasswordButton.isHidden = true
    }
    
    @objc
    private func changePassowrdButtonTapped() {
//        showAlert(title: "Сброс пароля", message: "Мы отправили на Вашу почту письмо для сброса пароля")
//        shared.changePassword(email: emailTextField.text ?? "")
        showResetAlert()
    }
    
    func showAlert(title: String , message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "ok", style: .default))
        
        present(alert, animated: true)
    }
    
    // MARK: - regAndAuth
    @objc
    private func signButtonPressed() {
        let password = passwordTextField.text ?? ""
        let name = nameTextField.text ?? ""
        let email = emailTextField.text ?? ""
        
        if signUp {
            if password.isEmpty || name.isEmpty || email.isEmpty {
                showAlert(title: "Ошибка", message: "Заполните все поля")
            } else {
                shared.createNewUser(name: name, email: email, password: password) { [weak self] result in
                    switch result {
                    case .failure(let error):
                        switch error {
                        case .emailExist :
                            self?.showAlert(title: "Ошибка", message: "Аккаунт с такой пчтой уже существует")
                        default:
                            self?.showAlert(title: "Неизвестная ошибка", message: "Что-то пошло не так, попробуйте еще раз")
                        }
                        
                    case .success(let uid):
                        print(1)
                        Service.shared.confirmEmail()
                    }
                }
            }
        } else {
            if password.isEmpty || email.isEmpty {
                showAlert(title: "Ошибка", message: "Заполните все поля")
            } else {
                shared.authWithEmail(email: email, password: password) { [weak self] Ans in
                    switch Ans {
                    case .emailNotExist:
                        self?.showAlert(title: "Ошибка", message: "Аккаунта с такой почтой нет")
                    case .emailNotVerified:
                        self?.showAlert(title: "Ошибка", message: "Ваша почта не верифицирована, мы отправили письмо с верификацией на Вашу почту")
                        self?.shared.confirmEmail()
                    case .wrongPassword:
                        self?.showAlert(title: "Ошибка", message: "Вы ввели неправльный пароль")
                    default:
                        self?.showAlert(title: "Неизвестная ошибка", message: "Что-то пошло не так, попробуйте еще раз")
                    }
                }
            }
        }
    }
    
    @objc
    private func regauthButtonTapped() {
        signUp = !signUp
    }
    
    private func showResetAlert() {
        let alert = UIAlertController(title: "Сброс пароля", message: "Введите вашу почту", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel)
        let okAction = UIAlertAction(title: "OK", style: .default){ [weak self] (action) in
            let login = alert.textFields?.first
            self?.shared.changePassword(email: login?.text ?? "")
            print(login?.text ?? "")
        }
        alert.addAction(cancelAction)
        alert.addAction(okAction)
        alert.addTextField { loginTF in
            loginTF.placeholder = "Введите почту"
        }
        
        present(alert, animated: true)
        
    }
}
