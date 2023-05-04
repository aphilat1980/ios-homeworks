import UIKit

class PostViewController: UIViewController, Coordinating {
   
    var coordinator: ModuleCoordinatable?
    

    var titlePost = "Мой пост"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = self.titlePost
        view.backgroundColor = .systemOrange
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Info", style: .plain, target: self, action: #selector(buttonPressed(_:)))

}
    
    @objc func buttonPressed(_ sender: UIButton) {
        
        (coordinator as? FeedCoordinator)?.eventOccurred(event: .infoButtonTapped)
        
        }

}
