
import UIKit

class LogInViewController: UIViewController, Coordinating {
    
    weak var coordinator: ModuleCoordinatable?
    

    public var loginDelegate: LoginViewControllerDelegate?
    
    //weak var coordinator: LoginCoordinator?
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.backgroundColor = .white
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private lazy var contentView: UIView = {
        var contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.backgroundColor = .white
        return contentView
    }()
    
    private lazy var avatarImageView: UIImageView = {
        let myImage  = UIImageView ()
        myImage.translatesAutoresizingMaskIntoConstraints = false
        myImage.image = UIImage(named: "logo")
        myImage.clipsToBounds = true
        return myImage
    }()
    
    private lazy var stackView: UIStackView = { [unowned self] in
        let stackView = UIStackView ()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.addArrangedSubview(self.phoneTextField)
        stackView.addArrangedSubview(self.passwordTextField)
        stackView.backgroundColor = .systemYellow
        stackView.layer.cornerRadius = 10.0
        stackView.clipsToBounds = true
        stackView.layer.borderColor = UIColor.lightGray.cgColor
        stackView.layer.borderWidth = 0.5
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    public lazy var phoneTextField: TextFieldWithPadding = {
        let textField = TextFieldWithPadding ()
        textField.backgroundColor = .systemGray6
        textField.layer.borderWidth = 0.5
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.placeholder = "Email or phone"
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.autocorrectionType = UITextAutocorrectionType.no
        textField.keyboardType = UIKeyboardType.default
        textField.returnKeyType = UIReturnKeyType.done
        textField.clearButtonMode = UITextField.ViewMode.whileEditing
        textField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        textField.tintColor = UIColor(named: "AccentColor")
        textField.autocapitalizationType = .none
        textField.delegate = self
        return textField
    }()
    
    private lazy var passwordTextField: TextFieldWithPadding = {
        let textField = TextFieldWithPadding ()
        textField.backgroundColor = .systemGray6
        textField.layer.borderWidth = 0.5
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.placeholder = "Password"
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.autocorrectionType = UITextAutocorrectionType.no
        textField.keyboardType = UIKeyboardType.default
        textField.returnKeyType = UIReturnKeyType.done
        textField.clearButtonMode = UITextField.ViewMode.whileEditing
        textField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        textField.tintColor = UIColor(named: "AccentColor")
        textField.isSecureTextEntry = true
        textField.delegate = self
        return textField
    }()
    
    private lazy var logInButton: CustomButton = {
        let button = CustomButton(title: "Log In", radius: 10, backColor: .systemBlue)
        button.setBackgroundImage(UIImage (named: "buttonPixel"), for:.normal)
        let image = button.currentBackgroundImage
        button.setBackgroundImage (image?.image(alpha: 0.8), for: .highlighted)
        button.setBackgroundImage (image?.image(alpha: 0.8), for: .selected)
        button.setBackgroundImage (image?.image(alpha: 0.8), for: .disabled)
        button.setTitleColor(.white, for: .normal)
        button.clipsToBounds = true
        button.completionHandler = {self.buttonPressed()}
        return button
  }()
    
    private lazy var passwordButton: CustomButton = {
        let button = CustomButton(title: "Подобрать пароль", radius: 10, backColor: .systemBlue)
        button.setBackgroundImage(UIImage (named: "buttonPixel"), for:.normal)
        let image = button.currentBackgroundImage
        button.setTitleColor(.white, for: .normal)
        button.clipsToBounds = true
        button.completionHandler = {self.buttonPasswordPressed()}
        return button
  }()
    
    public lazy var indicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .medium)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    } ()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationController?.navigationBar.isHidden = true
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(avatarImageView)
        contentView.addSubview(stackView)
        contentView.addSubview(logInButton)
        contentView.addSubview(passwordButton)
        contentView.addSubview(indicator)
        setupConstraints()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name:UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name:UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    private func setupConstraints() {
        let safeAreaGuide = view.safeAreaLayoutGuide
            
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: safeAreaGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: safeAreaGuide.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: safeAreaGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: safeAreaGuide.bottomAnchor),
            
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.heightAnchor.constraint(equalTo: scrollView.heightAnchor),
          
            avatarImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            avatarImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 120),
            avatarImageView.heightAnchor.constraint(equalToConstant: 100),
            avatarImageView.widthAnchor.constraint(equalToConstant: 100),
            
            stackView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            stackView.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 120),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            stackView.heightAnchor.constraint(equalToConstant: 100),
            
            logInButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            logInButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 16),
            logInButton.heightAnchor.constraint(equalToConstant: 50),
            logInButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            logInButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            passwordButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            passwordButton.topAnchor.constraint(equalTo: logInButton.bottomAnchor, constant: 16),
            passwordButton.heightAnchor.constraint(equalToConstant: 50),
            passwordButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
           passwordButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            indicator.centerXAnchor.constraint(equalTo: passwordTextField.centerXAnchor),
            indicator.centerYAnchor.constraint(equalTo: passwordTextField.centerYAnchor)
            
            ])
        }
    
    @objc func buttonPressed() {
       
        if loginDelegate!.check(checker: Checker.shared, user: phoneTextField.text!, password: passwordTextField.text!) {
            
            #if DEBUG
            let service = TestUserService()
            #else
            let service = CurrentUserService()
            #endif
            
            if let user = service.userChecking(userLogin: phoneTextField.text!) {
                
                (coordinator as? LoginCoordinator)?.eventOccurred(event: .loginButtonTapped(user))
                
            } else {
                let alert = UIAlertController(title: "Ошибка входа", message: "Пароль и логин верные, но профиль пользователя более недоступен", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Вернуться", style: .default, handler: {action in }))
                present(alert, animated: true)
            }
        } else {
            
            let alert = UIAlertController(title: "Ошибка входа", message: "Пароль и логин некорректные", preferredStyle: .alert)
            alert.addAction (UIAlertAction(title: "Вернуться", style: .default))
            present(alert, animated: true)
            
        
        }
    }
    
    @objc func buttonPasswordPressed() {
        
        let letters = String().letters + String().digits
        var randomPassword = ""
        for _ in 1...3 {
            let randomLetter = letters.randomElement()!
            randomPassword += String(randomLetter)
        }
        print ("random password is \(randomPassword)")
        indicator.startAnimating()
        
        let queue = DispatchQueue(label: "password", qos: .userInitiated)
        
        queue.async {
            let bruteForce = BrutForce()
            print ("starting bruteForce")
            bruteForce.bruteForce(passwordToUnlock: randomPassword)
            print ("stopping bruteForce")
            DispatchQueue.main.async {
                self.indicator.stopAnimating()
                self.passwordTextField.isSecureTextEntry = false
                self.passwordTextField.text = randomPassword
            }
        }
        
    }
    
    @objc func keyboardWillShow(notification:NSNotification) {

        guard let userInfo = notification.userInfo else { return }
        var keyboardFrame:CGRect = (userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        keyboardFrame = self.view.convert(keyboardFrame, from: nil)

        var contentInset:UIEdgeInsets = self.scrollView.contentInset
        contentInset.bottom = keyboardFrame.size.height + 20
        scrollView.contentInset = contentInset
    }

    @objc func keyboardWillHide(notification:NSNotification) {

        let contentInset:UIEdgeInsets = UIEdgeInsets.zero
        scrollView.contentInset = contentInset
    }

}
extension LogInViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

class TextFieldWithPadding: UITextField {
    var textPadding = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.textRect(forBounds: bounds)
        return rect.inset(by: textPadding)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.editingRect(forBounds: bounds)
        return rect.inset(by: textPadding)
    }
}
extension UIImage {
    func image(alpha: CGFloat) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        draw(at: .zero, blendMode: .normal, alpha: alpha)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
}
