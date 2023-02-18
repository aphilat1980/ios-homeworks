import UIKit

class FeedViewController: UIViewController {

    private lazy var button: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 8
        button.setTitle("Перейти на пост", for: .normal)
        return button
        }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemPink
        view.addSubview(button)
        
        let safeAreaLayoutGuide = view.safeAreaLayoutGuide
            NSLayoutConstraint.activate([
                button.leadingAnchor.constraint(
                equalTo: safeAreaLayoutGuide.leadingAnchor,
                constant: 20.0
                ),
                button.trailingAnchor.constraint(
                equalTo: safeAreaLayoutGuide.trailingAnchor,
                constant: -20.0
                ),
                button.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor),
                button.heightAnchor.constraint(equalToConstant: 44.0)
                ])
        button.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
        
    }
    let post = Post(title: "Пост 1")
    
    @objc func buttonPressed(_ sender: UIButton) {
        let postViewController = PostViewController()
        postViewController.titlePost = post.title
        navigationController?.pushViewController(postViewController, animated: true)
        }

}
