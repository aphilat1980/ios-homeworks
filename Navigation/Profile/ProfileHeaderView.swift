import UIKit

class ProfileHeaderView: UIView {
    
    private lazy var setStatusButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 4
        button.setTitle("Show status", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.shadowOffset = CGSize(width: 4.0, height: 4.0)
        button.layer.shadowRadius = 4.0
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.7
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        return button
        }()
    
    private lazy var fullNameLabel: UILabel = {
        let label1 = UILabel ()
        label1.translatesAutoresizingMaskIntoConstraints = false
        label1.text = "Hipster Cat"
        label1.font = UIFont.boldSystemFont(ofSize: 18)
        label1.textColor = .black
        return label1
    }()
    
    private lazy var statusLabel: UILabel = {
        let label2 = UILabel ()
        label2.translatesAutoresizingMaskIntoConstraints = false
        label2.text = "Waiting for something..."
        label2.font = label2.font.withSize(14)
        label2.textColor = .gray
        return label2
    }()
    
    private lazy var avatarImageView: UIImageView = {
        let myImage  = UIImageView ()
        myImage.translatesAutoresizingMaskIntoConstraints = false
        myImage.image = UIImage(named: "avatar")
        myImage.layer.borderWidth = 3
        myImage.layer.borderColor = UIColor.white.cgColor
        myImage.layer.cornerRadius = 60
        myImage.clipsToBounds = true
        return myImage
    }()
    
    private lazy var statusTextField: UITextField = {
        let textField = UITextField ()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 12.0
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.black.cgColor
        textField.font = textField.font?.withSize(15)
        textField.addTarget(self, action: #selector(statusTextChanged), for: .editingChanged)
        return textField
    }()
    
    private var statusText: String = ""
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(setStatusButton)
        self.addSubview(statusLabel)
        self.addSubview(avatarImageView)
        self.addSubview(fullNameLabel)
        self.addSubview(statusTextField)
        setupObjects()
        }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        }
    
    //override func didMoveToSuperview () {
     //   self.addSubview(setStatusButton)
     //   self.addSubview(statusLabel)
    //    self.addSubview(avatarImageView)
     //   self.addSubview(fullNameLabel)
     //   self.addSubview(statusTextField)
     //   setupObjects()
  //  }
    
    private func setupObjects () {
        NSLayoutConstraint.activate([
        fullNameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 27),
        fullNameLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
        avatarImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16),
        avatarImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
        avatarImageView.widthAnchor.constraint(equalToConstant: 120),
        avatarImageView.heightAnchor.constraint(equalToConstant: 120),
        setStatusButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant:-16.0),
        setStatusButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16.0),
        setStatusButton.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 40),
        setStatusButton.heightAnchor.constraint(equalToConstant: 50),
        statusLabel.bottomAnchor.constraint(equalTo: setStatusButton.topAnchor, constant: -70),
        statusLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 150),
        statusTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
        statusTextField.bottomAnchor.constraint(equalTo: setStatusButton.topAnchor, constant: -15),
        statusTextField.heightAnchor.constraint(equalToConstant: 40),
        statusTextField.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 150)
        ])
        }
    
    @objc func buttonPressed(_ sender: UIButton) {
        if statusLabel.text != nil {
            statusLabel.text = statusText
            statusTextField.resignFirstResponder()
            print (statusText)
        }
        }
    
    @objc func statusTextChanged(_ textField: UITextField) {
        statusText = textField.text!
        }
    
}
