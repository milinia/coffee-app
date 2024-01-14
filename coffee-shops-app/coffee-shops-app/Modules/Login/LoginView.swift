//
//  LoginView.swift
//  coffee-shops-app
//
//  Created by Evelina on 14.01.2024.
//

import UIKit

protocol LoginViewProtocol: AnyObject {
    var presenter: LoginPresenterProtocol? { get set }
}

class LoginView: UIViewController, LoginViewProtocol {
    
    var presenter: LoginPresenterProtocol?
    
    // MARK: - Private properties
    private enum UIConstants {
        static let contentInset: CGFloat = 16
        static let buttonCornerRadius: CGFloat = 20
        static let buttonBorderWidth: CGFloat = 2
        static let textFieldBorderWidth: CGFloat = 2
        static let buttonVerticalInsets: CGFloat = 13
        static let labelsFontSize: CGFloat = 15
        static let buttonTitleFontSize: CGFloat = 18
        static let spaceAfterLabel: CGFloat = 8
        static let textFieldHeight: CGFloat = 47
        static let verticalStackViewSpacing: CGFloat = 24
        static let horizontalStackViewSpacing: CGFloat = 6
        static let buttonHorizontalInsets: CGFloat = 20
    }
    
    private var passwordTextFieldOriginalText: String = ""
    
    //MARK: - Private UI properties
    private lazy var emailTextField: UITextField = {
        let textField = BaseTextField()
        textField.layer.borderColor = Asset.lightBrownColor.color.cgColor
        textField.layer.borderWidth = UIConstants.textFieldBorderWidth
        textField.borderStyle = .roundedRect
        textField.layer.cornerRadius = UIConstants.buttonCornerRadius
        textField.layer.masksToBounds = true
        textField.textColor = Asset.darkBeigeColor.color
        textField.keyboardType = .emailAddress
        textField.placeholder = Strings.Registraion.email
        return textField
    }()
    
    private lazy var emailLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "SFUIDisplay-Regular", size: UIConstants.labelsFontSize)
        label.textColor = Asset.lightBrownColor.color
        label.text = Strings.Registraion.email
        return label
    }()
    
    private lazy var passwordLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "SFUIDisplay-Regular", size: UIConstants.labelsFontSize)
        label.textColor = Asset.lightBrownColor.color
        label.text = Strings.Registraion.password
        return label
    }()
    
    private lazy var passwordTextField: UITextField = {
        let textField = BaseTextField()
        textField.layer.borderColor = Asset.lightBrownColor.color.cgColor
        textField.layer.borderWidth = UIConstants.textFieldBorderWidth
        textField.borderStyle = .roundedRect
        textField.layer.cornerRadius = UIConstants.buttonCornerRadius
        textField.layer.masksToBounds = true
        textField.textColor = Asset.darkBeigeColor.color
        textField.placeholder = Strings.Registraion.password
        return textField
    }()
    
    private lazy var loginButton: UIButton = {
        var configuration = UIButton.Configuration.filled()
        var container = AttributeContainer()
        container.font = UIFont(name: "SFUIDisplay-Bold", size: UIConstants.buttonTitleFontSize)
        let attributedString = AttributedString(Strings.Login.login, attributes: container)
        configuration.attributedTitle = attributedString
        configuration.baseBackgroundColor = Asset.darkBrownColor.color
        configuration.baseForegroundColor = Asset.beigeColor.color
        configuration.contentInsets = NSDirectionalEdgeInsets(
            top: UIConstants.buttonVerticalInsets,
            leading: UIConstants.buttonHorizontalInsets,
            bottom: UIConstants.buttonVerticalInsets,
            trailing: UIConstants.buttonHorizontalInsets
        )
        configuration.background.cornerRadius = UIConstants.buttonCornerRadius

        configuration.cornerStyle = .fixed
        let button = UIButton(configuration: configuration)
        return button
    }()
    
    private lazy var noAccountLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "SFUIDisplay-Regular", size: UIConstants.buttonTitleFontSize)
        label.text = "Нет аккаунта?"
        label.textColor = Asset.lightBrownColor.color
        return label
    }()
    
    private lazy var registerButton: UIButton = {
        let button = UIButton()
        button.setTitle("Зарегистрироваться", for: .normal)
        button.setTitleColor(Asset.darkBrownColor.color, for: .normal)
        button.tintColor = Asset.darkBrownColor.color
        button.titleLabel?.font = UIFont(name: "SFUIDisplay-SemiBold", size: UIConstants.buttonTitleFontSize)
        return button
    }()
    
    private lazy var verticalStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.distribution = .fill
        view.alignment = .leading
        view.translatesAutoresizingMaskIntoConstraints = false
        view.spacing = UIConstants.verticalStackViewSpacing
        return view
    }()
    
    private lazy var horizontalStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.distribution = .fill
        view.translatesAutoresizingMaskIntoConstraints = false
        view.spacing = UIConstants.horizontalStackViewSpacing
        return view
    }()
    
    // MARK: - UIViewController life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
        registerButton.addTarget(self, action: #selector(registerButtonPressed), for: .touchUpInside)
        loginButton.addTarget(self, action: #selector(loginButtonPressed), for: .touchUpInside)
    }
    // MARK: - Button actions
    @objc func loginButtonPressed() {
        if let email = emailTextField.text {
            if !isTextFieldEmpty(email: email, password: passwordTextFieldOriginalText) {
                presenter?.login(email: email, password: passwordTextFieldOriginalText)
            } else {
                if email.isEmpty {
                    emailTextField.layer.borderColor = UIColor.systemRed.cgColor
                }
                if passwordTextFieldOriginalText.isEmpty {
                    passwordTextField.layer.borderColor = UIColor.systemRed.cgColor
                }
            }
        }
    }
    
    @objc func registerButtonPressed() {
        presenter?.openRegisterScreen()
    }
    
    // MARK: - Private methods
    
    private func isTextFieldEmpty(email: String, password: String) -> Bool {
        return email.isEmpty || password.isEmpty
    }
    
    private func setupView() {
        view.backgroundColor = .white
        navigationItem.hidesBackButton = true
        navigationItem.title = Strings.Login.title
        [emailLabel, emailTextField, passwordLabel, passwordTextField, loginButton].forEach({verticalStackView.addArrangedSubview($0)})
        [noAccountLabel, registerButton].forEach({horizontalStackView.addArrangedSubview($0)})
        [verticalStackView, horizontalStackView].forEach({view.addSubview($0)})
        
        setupConstraints()
        
        passwordTextField.delegate = self
        emailTextField.delegate = self
        
        verticalStackView.setCustomSpacing(UIConstants.spaceAfterLabel, after: emailLabel)
        verticalStackView.setCustomSpacing(UIConstants.spaceAfterLabel, after: passwordLabel)
    }
    
    private func setupConstraints() {
        verticalStackView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(UIConstants.contentInset)
            make.centerY.equalToSuperview()
        }
        loginButton.snp.makeConstraints { make in
            make.width.equalToSuperview()
        }
        emailTextField.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(UIConstants.textFieldHeight)
        }
        passwordTextField.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(UIConstants.textFieldHeight)
        }
        horizontalStackView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(2 * UIConstants.contentInset)
        }
    }
    
}

extension LoginView: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == passwordTextField {
            if string == "" {
                passwordTextFieldOriginalText = String(passwordTextFieldOriginalText.dropLast())
            } else {
                passwordTextFieldOriginalText += string
            }
            let asteriskText = String(repeating: "*", count: string.count)
            textField.text = (textField.text as NSString?)?.replacingCharacters(in: range, with: asteriskText)
            return false
        }
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.layer.borderColor = Asset.lightBrownColor.color.cgColor
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.layer.borderColor = Asset.lightBrownColor.color.cgColor
    }
}
