import UIKit

class InfoViewController: UIViewController {
    
    private lazy var button: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 8
        button.setTitle("Вызвать алерт", for: .normal)
        return button
        }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
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
                    button.centerYAnchor.constraint(equalTo:
                    safeAreaLayoutGuide.centerYAnchor),
                    button.heightAnchor.constraint(equalToConstant: 44.0)
                ])
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
    }
   
    @objc func buttonPressed() {
        let alert = UIAlertController(title: "Алерт", message: "Внимание Внимание!!", preferredStyle: .alert)
        let action1 = UIAlertAction(title: "Сообщение 1", style: .default, handler: {action in print("Вы нажали кнопку Сообщение 1")})
        let action2 = UIAlertAction(title: "Сообщение 2", style: .default, handler: {action in print("Вы нажали кнопку Сообщение 2")})
        alert.addAction(action1)
        alert.addAction(action2)
        present(alert, animated: true)
        }
}
