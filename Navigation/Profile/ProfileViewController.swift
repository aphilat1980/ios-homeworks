import UIKit

class ProfileViewController: UIViewController {
    
    fileprivate let data = Post.make()
    
    private lazy var avView: UIImageView = { [unowned self] in
        let view = UIImageView()
        view.frame = CGRect(x: 16, y: 16, width: 120, height: 120)
        //view.translatesAutoresizingMaskIntoConstraints = false
        view.image = UIImage(named: "avatar")
        view.isUserInteractionEnabled = true
        view.layer.borderWidth = 3
        view.layer.borderColor = UIColor.white.cgColor
        view.clipsToBounds = true
        view.layer.cornerRadius = 60
        let tapRed = UITapGestureRecognizer( target: self, action: #selector(didTapRed))
        view.addGestureRecognizer(tapRed)
            return view
    }()
    
    private lazy var backgroundView: UIView = {
        let view = UIView()
        //view.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        view.translatesAutoresizingMaskIntoConstraints = false
        //view.isUserInteractionEnabled = true
        view.backgroundColor = .white
        view.alpha = 0
        return view
    }()
    
    private lazy var xImage: UIImageView = {[unowned self] in
        let myImage  = UIImageView ()
        //myImage.translatesAutoresizingMaskIntoConstraints = false
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
        view.backgroundColor = .white
        view.addSubview(tableView)
        //tableView.addSubview(backgroundView)
        //tableView.addSubview(xImage)
        tableView.addSubview(avView)
        setupConstraints()
    }
    
    private func setupConstraints() {
        let safeAreaGuide = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: safeAreaGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: safeAreaGuide.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: safeAreaGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeAreaGuide.bottomAnchor),
            
            /*backgroundView.leadingAnchor.constraint(equalTo: safeAreaGuide.leadingAnchor),
            backgroundView.topAnchor.constraint(equalTo: safeAreaGuide.topAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: safeAreaGuide.trailingAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: safeAreaGuide.bottomAnchor)*/
        ])
    }
    
    @objc private func didTapRed() {
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
                self.backgroundView.alpha = 0.5
            }
            
            // 2
            UIView.addKeyframe(withRelativeStartTime: 0.3125,relativeDuration: 0.3125) {
                self.avView.bounds.size = CGSize(width: self.view.safeAreaLayoutGuide.layoutFrame.width, height: self.view.safeAreaLayoutGuide.layoutFrame.width)
                self.avView.layer.cornerRadius = 0
                self.avView.layer.borderWidth = 10
                self.backgroundView.alpha = 1
            }
            // 3
            UIView.addKeyframe(withRelativeStartTime: 0.625,relativeDuration: 0.375) {
                self.xImage.alpha = 1
            }
            
        },
            completion: { finished in
            self.avView.isUserInteractionEnabled = false
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
                self.backgroundView.alpha = 0.5
            }
            // 1
            UIView.addKeyframe(withRelativeStartTime: 0.6875, relativeDuration: 0.3125) {
                self.backgroundView.alpha = 0
                //self.backgroundView.backgroundColor = .red
                self.avView.center = CGPoint(x: 76, y: 76)
            }
            
        },
            completion: { finished in
            self.backgroundView.removeFromSuperview()
            //self.avView.removeFromSuperview()
            self.xImage.removeFromSuperview()
            //self.tableView.willRemoveSubview(self.avView)
            //self.setupConstraints()
            self.avView.isUserInteractionEnabled  = true
            print("complete")
        }
        )
        //backgroundView.removeFromSuperview()
        
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
            return cell
        
        default: break
        
        }
     return UITableViewCell()
    }
        
}
extension ProfileViewController: UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            let photosViewController = PhotosViewController()
            navigationController?.pushViewController(photosViewController, animated: true)
        }
    }
}



    

