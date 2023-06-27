//
//  SavedPostViewController.swift
//  Navigation
//
//  Created by Александр Филатов on 27.06.2023.
//

import UIKit

class SavedPostViewController: UIViewController {

    
    var postDataManager = PostDataManager()
    
    var currentUser = User(userLogin: "aphilat", userFullName: "Test User", userStatus: "Test test test", userAvatar: UIImage(named: "avatar")!)
    
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView.init(
            frame: .zero,
            style: .plain
        )
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.register(ProfileTableViewCell.self, forCellReuseIdentifier: ProfileTableViewCell.id)
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: PostTableViewCell.id)
        
        tableView.dataSource = self
        tableView.delegate = self
        
        return tableView
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        postDataManager.fetchSavedPosts()
        tableView.reloadData()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .green
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

extension SavedPostViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return 1
        case 1: return postDataManager.savedPosts.count
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
            cell.fullNameLabel.text = currentUser.userFullName
            cell.statusLabel.text = currentUser.userStatus
            cell.avatarImageView.image = currentUser.userAvatar
            return cell
            
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: PostTableViewCell.id, for: indexPath) as? PostTableViewCell else {
            fatalError("could not dequeueReusableCell")
            }
            let currentLastItem = postDataManager.savedPosts[indexPath.row]
            cell.author.text = currentLastItem.author
            cell.image.image = UIImage(named: currentLastItem.image!)
            cell.my_description.text = currentLastItem.myDescription
            cell.likes.text = "Likes: \(currentLastItem.likes)"
            cell.views.text = "Views: \(currentLastItem.views)"
            
            return cell
        
        default: break
        
        }
     return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        postDataManager.deletePost(index: indexPath.row)
        //delegate.networkManager.deleteQuote(index: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }
        
}


