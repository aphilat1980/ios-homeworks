import UIKit

class ProfileViewController: UIViewController {

    let profileHeaderView = ProfileHeaderView ()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Profile"
        self.navigationController?.navigationBar.backgroundColor = .white
        view.backgroundColor = .lightGray
        view.addSubview(profileHeaderView)
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        profileHeaderView.frame = view.safeAreaLayoutGuide.layoutFrame
    }
    
    
}
