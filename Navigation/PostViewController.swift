import UIKit

class PostViewController: UIViewController {

    var titlePost = "Мой пост"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = self.titlePost
        view.backgroundColor = .systemOrange
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Info", style: .plain, target: self, action: #selector(buttonPressed(_:)))
}
    
    @objc func buttonPressed(_ sender: UIButton) {
        
        let infoViewController = InfoViewController()
        infoViewController.modalTransitionStyle = .coverVertical
        infoViewController.modalPresentationStyle = .pageSheet
        present(infoViewController, animated: true)
        }

}
