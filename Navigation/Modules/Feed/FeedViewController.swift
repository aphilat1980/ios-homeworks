import UIKit

class FeedViewController: UIViewController {
    
    let feedViewModel: FeedViewModel
    
    init(feedViewModel: FeedViewModel) {
        self.feedViewModel = feedViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var timer: Timer?
    
    private lazy var button1: CustomButton = {
          let button = CustomButton(title: "Перейти на пост - кнопка 1", radius: 8, backColor: .systemBlue)
          button.completionHandler = {self.buttonPressed()}
          return button
    }()
    
    
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
    
    private lazy var counterLabel: UILabel = {
        let label = UILabel ()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 100)
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
        stackView.addArrangedSubview(self.counterLabel)
        
        return stackView
    }()
    
    var runCount = 31
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        view.backgroundColor = .systemGray
        view.addSubview(stackView)
        setupConstraints()
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(fireTimer), userInfo: nil, repeats: true)
        bindViewModel()
        
    }
    
    func bindViewModel () {
            
        feedViewModel.onStateDidChange = {[weak self] state in
            guard let self = self else {
                return
            }
            switch state {
            case .initial:
                self.view.backgroundColor = .systemGray
                self.stackView.isHidden = false
                self.runCount = 31
                self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.fireTimer), userInfo: nil, repeats: true)
            case .success:
                self.stackView.isHidden = false
                self.label.textColor = .green
                self.timer?.invalidate()
                self.runCount = 31
                self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.fireTimer), userInfo: nil, repeats: true)
                
            case .failure:
                self.stackView.isHidden = false
                self.label.textColor = .red
            case .emptyField:
                self.view.backgroundColor = .black
                self.stackView.isHidden = true

                let alert = UIAlertController(title: "Ошибка!!", message: "Введено пустое значение!", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Вернуться", style: .default, handler: {action in self.feedViewModel.state = .initial }))
                self.present(alert, animated: true)
            }
        }
    }
    
    @objc func fireTimer() {
        if runCount > 0 {
            runCount -= 1
            counterLabel.text = String (runCount)}
        else {
            textField.text = ""
            self.timer?.invalidate()
            let alert = UIAlertController(title: "Истекло время ввода ключевого слова", message: "Введите за 30 сек слово заново", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Вернуться", style: .default, handler: {action in self.feedViewModel.state = .initial }))
            self.present(alert, animated: true)
            //runCount = 31
        }
    }
    
    private func setupConstraints () {
        let safeAreaLayoutGuide = view.safeAreaLayoutGuide
            NSLayoutConstraint.activate([
                stackView.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
                stackView.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor)
                ])
        }
    
    @objc func buttonPressed() {
        //let postViewController = PostViewController()
        //navigationController?.pushViewController(postViewController, animated: true)
        feedViewModel.updateState(viewInput: .postButtonPTapped)
    }
    
    @objc func check() {
        label.text = textField.text
        feedViewModel.updateState(viewInput: .checkButtonTapped(textField.text!))
            //feedViewModel.check(secretWord: textField.text!)
    }
    
}
