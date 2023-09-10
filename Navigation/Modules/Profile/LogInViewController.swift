
import UIKit


class LogInViewController: UIViewController, Coordinating {
    
    weak var coordinator: ModuleCoordinatable?
    
    let loginViewModel: LoginViewModel
    
    init(loginViewModel: LoginViewModel) {
        self.loginViewModel = loginViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
        //contentView.backgroundColor = .white
        contentView.backgroundColor = Pallete.viewControllerBackgroundColor
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
        //textField.backgroundColor = .systemGray6
        textField.backgroundColor = Pallete.textFieldBackgroundColor
        textField.layer.borderWidth = 0.5
        textField.layer.borderColor = UIColor.lightGray.cgColor
        let placeholder = NSLocalizedString("loginViewControllerPlaceholder1", comment: "")
        textField.placeholder = placeholder
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
        //textField.backgroundColor = .systemGray6
        textField.backgroundColor = Pallete.textFieldBackgroundColor
        textField.layer.borderWidth = 0.5
        textField.layer.borderColor = UIColor.lightGray.cgColor
        let placeholder = NSLocalizedString("loginViewControllerPlaceholder2", comment: "")
        textField.placeholder = placeholder
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
        let title = NSLocalizedString("loginViewControllerButtonTitle", comment: "")
        let button = CustomButton(title: title, radius: 10, backColor: .systemBlue)
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
    
    
    private lazy var biometricLogInButton: CustomButton = {
        let title = "Face ID Login"
        let button = CustomButton(title: title, radius: 10, backColor: .systemBlue)
        button.setBackgroundImage(UIImage (named: "buttonPixel"), for:.normal)
        let image = button.currentBackgroundImage
        button.setBackgroundImage (image?.image(alpha: 0.8), for: .highlighted)
        button.setBackgroundImage (image?.image(alpha: 0.8), for: .selected)
        button.setBackgroundImage (image?.image(alpha: 0.8), for: .disabled)
        button.setTitleColor(.white, for: .normal)
        button.clipsToBounds = true
        button.completionHandler = {self.biometricButtonPressed()}
        return button
  }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        bindViewModel()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name:UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name:UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    
    func bindViewModel () {
            
        loginViewModel.onStateDidChange = {[weak self] state in
            guard let self = self else {
                return
            }
            
            switch state {
            case .initial:
                self.view.backgroundColor = Pallete.viewControllerBackgroundColor
                
            case .successExistUser:
                self.successLoginExistUser()
                
            case .failureLogin(let error):
                self.showAlertLoginFailure(error: error)
                
            case .noUser:
                self.showAlertNoUser()
                
            case .successNewUser:
                self.successRegisterNewUser()
                
            case .failureRegister(let error):
                self.showAlertRegisterFailure(error: error)
        }
      }
    }
        
    func successLoginExistUser () {
        
        let userName = NSLocalizedString("loginViewControllerLoginSuccessUserName", comment: "")
        let userStatus = NSLocalizedString("loginViewControllerLoginSuccessUserStatus", comment: "")
        let user = User(userLogin: self.phoneTextField.text!, userFullName: userName, userStatus: userStatus, userAvatar: UIImage(named: "avatar")!)
        (self.coordinator as? LoginCoordinator)?.eventOccurred(event: .loginButtonTapped(user))
    }
    
    func showAlertLoginFailure (error: String) {
        let alertTitle = NSLocalizedString("loginViewControllerFailureAlertTitle", comment: "")
        let alert = UIAlertController(title: alertTitle, message: error, preferredStyle: .alert)
        let actionTitle = NSLocalizedString("loginViewControllerFailureActionTitle", comment: "")
        alert.addAction (UIAlertAction(title: actionTitle, style: .default))
        self.present(alert, animated: true)
    }
    
    func showAlertNoUser () {
        let noUserAlertTitle = NSLocalizedString("loginViewControllerNoUserAlertTitle", comment: "")
        let noUserAlertMessage = NSLocalizedString("loginViewControllerNoUserAlertMessage", comment: "")
        let alert = UIAlertController(title: noUserAlertTitle, message: noUserAlertMessage, preferredStyle: .alert)
        let noUserAction1Title = NSLocalizedString("loginViewControllerNoUserAlertAction1Title", comment: "")
        alert.addAction(UIAlertAction(title: noUserAction1Title, style: .default, handler: { action in
            self.loginViewModel.updateState(viewInput: .newUserRegisterButtonPressed(email: self.phoneTextField.text!, password: self.passwordTextField.text!))
        }))
        let noUserAction2Title = NSLocalizedString("loginViewControllerNoUserAlertAction2Title", comment: "")
        alert.addAction (UIAlertAction(title: noUserAction2Title, style: .default))
        self.present(alert, animated: true)
    }
    
    func successRegisterNewUser () {
        let user = User(userLogin: self.phoneTextField.text!, userFullName: "\(self.phoneTextField.text!)", userStatus: "Привет", userAvatar: UIImage(named: "avatar")!)
        (self.coordinator as? LoginCoordinator)?.eventOccurred(event: .loginButtonTapped(user))
    }
    
    func showAlertRegisterFailure (error: String) {
        let title = NSLocalizedString("loginViewControllerRegisterFailureAlertTitle", comment: "")
        let alert = UIAlertController(title: title, message: error, preferredStyle: .alert)
        let actionTitle = NSLocalizedString("loginViewControllerRegisterFailureActionTitle", comment: "")
        alert.addAction (UIAlertAction(title: actionTitle, style: .default))
        self.present(alert, animated: true)
    }
    
    
    
    private func setupView() {
        view.backgroundColor = Pallete.viewControllerBackgroundColor
        navigationController?.navigationBar.isHidden = true
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(avatarImageView)
        contentView.addSubview(stackView)
        contentView.addSubview(logInButton)
        contentView.addSubview(biometricLogInButton)
        
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
            biometricLogInButton.centerXAnchor.constraint(equalTo: logInButton.centerXAnchor),
            biometricLogInButton.topAnchor.constraint(equalTo: logInButton.bottomAnchor, constant: 10),
            biometricLogInButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            biometricLogInButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            biometricLogInButton.heightAnchor.constraint(equalToConstant: 50)
            
            ])
        }
    
    @objc func buttonPressed() {
        
        loginViewModel.updateState(viewInput: .loginButtonTapped(email: self.phoneTextField.text!, password: self.passwordTextField.text!))
        
        
    }
    
    @objc func biometricButtonPressed() {
        
        LocalAuthorizationService().authorizeIfPossible { success in
            if success {
                self.successLoginExistUser()
            } else {
                self.showAlertLoginFailure(error: "FaceID authorization failure")
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



