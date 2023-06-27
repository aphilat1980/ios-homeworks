import StorageService
import UIKit

class ProfileViewController: UIViewController, Coordinating {
    
    weak var coordinator: ModuleCoordinatable?
    
    convenience init (user: User){
        self.init()
        self.currentUser = user
    }
    
    var postDataManager = PostDataManager()
    
    var currentUser: User?
    
    fileprivate let data = Post.make()
    
    //создаю "поверх" ячейки в таблице UIImageView для нажатия и запуска анимации
    private lazy var avView: UIImageView = { [unowned self] in
        let view = UIImageView()
        view.frame = CGRect(x: 16, y: 16, width: 120, height: 120)
        view.image = currentUser?.userAvatar
        view.isUserInteractionEnabled = true
        view.layer.borderWidth = 3
        view.layer.borderColor = UIColor.white.cgColor
        view.clipsToBounds = true
        view.layer.cornerRadius = 60
        let tapImage = UITapGestureRecognizer( target: self, action: #selector(didTapImage))
        view.addGestureRecognizer(tapImage)
            return view
    }()
    //создаю backgroundView, который будет перекрывать контент при анимации
    private lazy var backgroundView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.alpha = 0
        return view
    }()
    
    //создаю UIImageView, для закрытия анимации
    private lazy var xImage: UIImageView = {[unowned self] in
        let myImage  = UIImageView ()
        myImage.contentMode = .scaleAspectFit
        myImage.image = UIImage(systemName: "clear")
        myImage.frame = CGRect(x: self.view.frame.width - 56, y: 40, width: 40, height: 40)
        myImage.alpha = 0
        myImage.tintColor = .black
        myImage.isUserInteractionEnabled = true
        let tapX = UITapGestureRecognizer( target: self, action: #selector(didTapX))
        myImage.addGestureRecognizer(tapX)
        return myImage
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView.init(
            frame: .zero,
            style: .plain
        )
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.register(ProfileTableViewCell.self, forCellReuseIdentifier: ProfileTableViewCell.id)
        
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: PostTableViewCell.id)
        
        tableView.register(PhotosTableViewCell.self, forCellReuseIdentifier: PhotosTableViewCell.id)
        
        tableView.dataSource = self
        tableView.delegate = self
        
        return tableView
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        #if DEBUG
        view.backgroundColor = .orange
        #else
        view.backgroundColor = .red
        #endif
        view.addSubview(tableView)
        tableView.addSubview(avView)
        setupConstraints()
    }
    
    private func setupConstraints() {
        let safeAreaGuide = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: safeAreaGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: safeAreaGuide.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: safeAreaGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeAreaGuide.bottomAnchor)
        ])
    }
    
    @objc private func didTapImage() {
        launchAnimation()
    }
    
    @objc private func didTapX() {
        launchReverseAnimation()
    }
    
    private func launchAnimation() {
        
        tableView.addSubview(backgroundView)
        tableView.addSubview(avView)
        tableView.addSubview(xImage)
        
        let safeAreaGuide = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            backgroundView.leadingAnchor.constraint(equalTo: safeAreaGuide.leadingAnchor),
            backgroundView.topAnchor.constraint(equalTo: safeAreaGuide.topAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: safeAreaGuide.trailingAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: safeAreaGuide.bottomAnchor)
        ])
        
        UIView.animateKeyframes(withDuration: 1.6, delay: 0.5, options:.calculationModeLinear, animations: {
            // 1
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.3125) {
                self.avView.center = self.view.center
                self.backgroundView.alpha = 0.45
            }
            // 2
            UIView.addKeyframe(withRelativeStartTime: 0.3125,relativeDuration: 0.3125) {
                self.avView.bounds.size = CGSize(width: self.view.safeAreaLayoutGuide.layoutFrame.width, height: self.view.safeAreaLayoutGuide.layoutFrame.width)
                self.avView.layer.cornerRadius = 0
                self.avView.layer.borderWidth = 10
                self.backgroundView.alpha = 0.9
            }
            // 3
            UIView.addKeyframe(withRelativeStartTime: 0.625,relativeDuration: 0.375) {
                self.xImage.alpha = 1
            }
        },
            completion: { finished in
            self.avView.isUserInteractionEnabled = false //устанавливаю false, чтобы аватар неактивным был для нажатия
            }
        )
    }
    
    private func launchReverseAnimation() {
            
        UIView.animateKeyframes(withDuration: 1.6, delay: 0.5, options:.calculationModeLinear, animations: {
            // 1
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.375) {
                self.xImage.alpha = 0
            }
            // 2
            UIView.addKeyframe(withRelativeStartTime: 0.375, relativeDuration: 0.3125) {
                self.avView.bounds.size = CGSize(width: 120, height: 120)
                self.avView.layer.cornerRadius = 60
                self.avView.layer.borderWidth = 3
                self.backgroundView.alpha = 0.45
            }
            // 1
            UIView.addKeyframe(withRelativeStartTime: 0.6875, relativeDuration: 0.3125) {
                self.backgroundView.alpha = 0
                self.avView.center = CGPoint(x: 76, y: 76)
            }
            
        },
            completion: { finished in
            self.backgroundView.removeFromSuperview()
            self.xImage.removeFromSuperview()
            self.avView.isUserInteractionEnabled  = true
        })
    }
   
}

extension ProfileViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return 1
        case 1: return 1
        case 2: return data.count
        default: break
        }
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ProfileTableViewCell.id, for: indexPath) as? ProfileTableViewCell else {
            fatalError("could not dequeueReusableCell")
            }
            cell.fullNameLabel.text = currentUser?.userFullName
            cell.statusLabel.text = currentUser?.userStatus
            cell.avatarImageView.image = currentUser?.userAvatar
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: PhotosTableViewCell.id, for: indexPath) as? PhotosTableViewCell else {
            fatalError("could not dequeueReusableCell")
            }
            return cell
            
        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: PostTableViewCell.id, for: indexPath) as? PostTableViewCell else {
            fatalError("could not dequeueReusableCell")
            }
            let currentLastItem = data[indexPath.row]
            cell.post = currentLastItem
            cell.completionHandler = {
                self.postDataManager.createSavedPost(author: currentLastItem.author, myDescription: currentLastItem.my_description, image: currentLastItem.image, likes: currentLastItem.likes, views: currentLastItem.views)
                let alert = UIAlertController (title: "Post Saved Success", message: "Check Saved Posts", preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .cancel)
                alert.addAction(action)
                self.present(alert, animated: true)
                
            }
            return cell
        
        default: break
        
        }
     return UITableViewCell()
    }
        
}
extension ProfileViewController: UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            (coordinator as? LoginCoordinator)?.eventOccurred(event: .photosTapped)
            
            //let photosViewController = PhotosViewController()
            //navigationController?.pushViewController(photosViewController, animated: true)
        }
    }
}



    

