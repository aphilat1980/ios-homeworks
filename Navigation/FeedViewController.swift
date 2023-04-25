import UIKit

class FeedViewController: UIViewController {
    
    //let post = Post(title: "Пост 1")

    /*private lazy var button1: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 8
        button.setTitle("Перейти на пост - кнопка 1", for: .normal)
        button.addTarget(self, action: #selector(buttonPressed()), for: .touchUpInside)
        return button
        }()*/
    private lazy var button1: CustomButton = {
          let button = CustomButton(title: "Перейти на пост - кнопка 1", radius: 8, backColor: .systemBlue)
          button.completionHandler = {self.buttonPressed()}
          return button
    }()
    
    /*private lazy var button2: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 8
        button.setTitle("Перейти на пост - кнопка 2", for: .normal)
        button.addTarget(self, action: #selector(buttonPressed()), for: .touchUpInside)
        return button
        }()*/
    
    private lazy var button2: CustomButton = {
        let button = CustomButton(title: "Перейти на пост - кнопка 2", radius: 8, backColor: .systemBlue)
        button.translatesAutoresizingMaskIntoConstraints = true
        button.completionHandler = {self.buttonPressed()}
        return button
  }()
    
    private lazy var label: UILabel = {
        let label = UILabel ()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.numberOfLines = 2
        return label
    }()
    
    public lazy var textField: TextFieldWithPadding = {
        let textField = TextFieldWithPadding ()
        textField.backgroundColor = .systemGray6
        textField.layer.borderWidth = 0.5
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.placeholder = "Введите ключевое слово..."
        textField.font = UIFont.systemFont(ofSize: 20)
        textField.autocorrectionType = UITextAutocorrectionType.no
        textField.keyboardType = UIKeyboardType.default
        textField.returnKeyType = UIReturnKeyType.done
        textField.clearButtonMode = UITextField.ViewMode.whileEditing
        textField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        textField.tintColor = UIColor(named: "AccentColor")
        textField.autocapitalizationType = .none
        return textField
    }()
    
    private lazy var checkGuessButton: CustomButton = {
        let button = CustomButton(title: "Проверить", radius: 8, backColor: .systemBlue)
        button.translatesAutoresizingMaskIntoConstraints = true
        button.completionHandler = {self.check()}
        return button
  }()
    
    
    private lazy var stackView: UIStackView = { [unowned self] in
        let stackView = UIStackView ()
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 10.0
        stackView.addArrangedSubview(self.button1)
        stackView.addArrangedSubview(self.button2)
        stackView.addArrangedSubview(self.textField)
        stackView.addArrangedSubview(self.checkGuessButton)
        stackView.addArrangedSubview(self.label)
        
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemGray
        view.addSubview(stackView)
        setupConstraints()
        
        }
    
    private func setupConstraints () {
        let safeAreaLayoutGuide = view.safeAreaLayoutGuide
            NSLayoutConstraint.activate([
                stackView.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
                stackView.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor)
                ])
        }
    
    @objc func buttonPressed() {
        let postViewController = PostViewController()
        //postViewController.titlePost = post.title
        navigationController?.pushViewController(postViewController, animated: true)
    }
    
    @objc func check() {
        if textField.text == "" {
            let alert = UIAlertController(title: "Ошибка!!", message: "Введено пустое значение!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Вернуться", style: .default, handler: {action in }))
            present(alert, animated: true)
        } else {
            label.text = textField.text
            FeedModel().check(word: textField.text!) ? (self.label.textColor = .green) : (self.label.textColor = .red)
        }
    }
}
