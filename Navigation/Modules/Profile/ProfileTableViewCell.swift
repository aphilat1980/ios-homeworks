import UIKit

class ProfileTableViewCell: UITableViewCell {

    static let id = "profileTableViewCell_id"
    
    /*private lazy var setStatusButton: UIButton = {
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
        button.addTarget(self, action: #selector(buttonPressed()), for: .touchUpInside)
        return button
        }()*/
    private lazy var setStatusButton: CustomButton = {
        let title = NSLocalizedString("profileTableViewCellButtonTitile", comment: "")
        let button = CustomButton(title: title, radius: 4, backColor: .systemBlue)
        button.setTitleColor(.white, for: .normal)
        button.layer.shadowOffset = CGSize(width: 4.0, height: 4.0)
        button.layer.shadowRadius = 4.0
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.7
        button.completionHandler = {self.buttonPressed()}
        return button
  }()
    
    public lazy var fullNameLabel: UILabel = {
        let label1 = UILabel ()
        label1.translatesAutoresizingMaskIntoConstraints = false
        label1.font = UIFont.boldSystemFont(ofSize: 18)
        label1.textColor = .black
        return label1
    }()
    
    public lazy var statusLabel: UILabel = {
        let label2 = UILabel ()
        label2.translatesAutoresizingMaskIntoConstraints = false
        let title = NSLocalizedString("profileTableViewCellStatusLabelText", comment: "")
        label2.text = title
        label2.font = label2.font.withSize(14)
        label2.textColor = .gray
        return label2
    }()
    
    public lazy var avatarImageView: UIImageView = {
        let myImage  = UIImageView ()
        myImage.translatesAutoresizingMaskIntoConstraints = false
        myImage.layer.borderWidth = 3
        myImage.layer.borderColor = UIColor.white.cgColor
        myImage.layer.cornerRadius = 60
        myImage.clipsToBounds = true
        return myImage
    }()
    
    private lazy var statusTextField: TextFieldWithPadding = {
        let textField = TextFieldWithPadding ()
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
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .systemGray6
        contentView.addSubview(setStatusButton)
        contentView.addSubview(statusLabel)
        contentView.addSubview(avatarImageView)
        contentView.addSubview(fullNameLabel)
        contentView.addSubview(statusTextField)
        setupObjects()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupObjects () {
        let constraint1 = setStatusButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        constraint1.priority = .defaultHigh
        NSLayoutConstraint.activate([
        fullNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 27),
        fullNameLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
        avatarImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
        avatarImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
        avatarImageView.widthAnchor.constraint(equalToConstant: 120),
        avatarImageView.heightAnchor.constraint(equalToConstant: 120),
        //constaint1
        setStatusButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant:-16.0),
        setStatusButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16.0),
        setStatusButton.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 40),
        setStatusButton.heightAnchor.constraint(equalToConstant: 50),
        statusLabel.bottomAnchor.constraint(equalTo: setStatusButton.topAnchor, constant: -70),
        statusLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 150),
        statusTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
        statusTextField.bottomAnchor.constraint(equalTo: setStatusButton.topAnchor, constant: -15),
        statusTextField.heightAnchor.constraint(equalToConstant: 40),
        statusTextField.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 150),
        constraint1
        ])
        }
    
    @objc func buttonPressed() {
        if statusLabel.text != nil {
            statusLabel.text = statusText
            statusTextField.resignFirstResponder()
        }
        
    }
    
    @objc func statusTextChanged(_ textField: UITextField) {
        statusText = textField.text!
    }
    
}
