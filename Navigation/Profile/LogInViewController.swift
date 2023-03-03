
import UIKit

class LogInViewController: UIViewController {

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
    
    private lazy var phoneTextField: TextFieldWithPadding = {
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
    
    private lazy var logInButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setBackgroundImage(UIImage (named: "buttonPixel"), for:.normal)
        let image = button.currentBackgroundImage
        button.setBackgroundImage (image?.image(alpha: 0.8), for: .highlighted)
        button.setBackgroundImage (image?.image(alpha: 0.8), for: .selected)
        button.setBackgroundImage (image?.image(alpha: 0.8), for: .disabled)
        button.layer.cornerRadius = 10
        button.setTitle("Log In", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        button.clipsToBounds = true
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationController?.navigationBar.isHidden = true
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(avatarImageView)
        contentView.addSubview(stackView)
        contentView.addSubview(logInButton)
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
            logInButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
            ])
        }
    
    @objc func buttonPressed(_ sender: UIButton) {
        let profileViewController = ProfileViewController()
        navigationController?.pushViewController(profileViewController, animated: true)
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
