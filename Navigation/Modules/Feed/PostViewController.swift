import UIKit

class PostViewController: UIViewController, Coordinating {
   
    var coordinator: ModuleCoordinatable?
    

    var titlePost = NSLocalizedString("postViewControllerTitle", comment: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = self.titlePost
        view.backgroundColor = .systemOrange
        
        let buttonTitle = NSLocalizedString("postViewControllerRightNavButtonTitle", comment: "")
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: buttonTitle, style: .plain, target: self, action: #selector(buttonPressed(_:)))

}
    
    @objc func buttonPressed(_ sender: UIButton) {
        
        (coordinator as? FeedCoordinator)?.eventOccurred(event: .infoButtonTapped)
        
        }

}
