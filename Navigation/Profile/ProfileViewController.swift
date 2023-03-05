import UIKit

class ProfileViewController: UIViewController {
    
    fileprivate let data = Post.make()
    
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



    

