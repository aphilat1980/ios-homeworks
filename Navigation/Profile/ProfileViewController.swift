import UIKit

class ProfileViewController: UIViewController {

    private lazy var profileHeaderView: ProfileHeaderView = {
        let profileHeaderView = ProfileHeaderView ()
        profileHeaderView.translatesAutoresizingMaskIntoConstraints = false
        return profileHeaderView
    }()
    
    private lazy var setTitleButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemBlue
        button.setTitle("Set title", for: .normal)
        button.setTitleColor(.white, for: .normal)
        //button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        return button
        }()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Profile"
        self.navigationController?.navigationBar.backgroundColor = .white
        view.backgroundColor = .lightGray
        view.addSubview(profileHeaderView)
        view.addSubview(setTitleButton)
        setupView()
    }
    
    private func setupView () {
        let safeAreaLayoutGuide = view.safeAreaLayoutGuide
                NSLayoutConstraint.activate([
                    profileHeaderView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor),
                    profileHeaderView.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor),
                    profileHeaderView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
                    profileHeaderView.heightAnchor.constraint(equalToConstant: 220),
                    setTitleButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
                    setTitleButton.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor),
                    setTitleButton.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor),
                    setTitleButton.heightAnchor.constraint(equalToConstant: 50)
                    ])
    }
    
}
