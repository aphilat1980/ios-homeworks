import UIKit

class FeedViewController: UIViewController {
    
    let post = Post(title: "Пост 1")

    private lazy var button1: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 8
        button.setTitle("Перейти на пост - кнопка 1", for: .normal)
        button.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
        return button
        }()
    
    private lazy var button2: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 8
        button.setTitle("Перейти на пост - кнопка 2", for: .normal)
        button.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
        return button
        }()
    
    private lazy var stackView: UIStackView = { [unowned self] in
        let stackView = UIStackView ()
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 10.0
        stackView.addArrangedSubview(self.button1)
        stackView.addArrangedSubview(self.button2)
        
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemPink
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
    
    @objc func buttonPressed(_ sender: UIButton) {
        let postViewController = PostViewController()
        postViewController.titlePost = post.title
        navigationController?.pushViewController(postViewController, animated: true)
        }

}
