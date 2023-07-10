//
//  SavedPostViewController.swift
//  Navigation
//
//  Created by Александр Филатов on 27.06.2023.
//

import UIKit

class SavedPostViewController: UIViewController {

    
    var postDataManager = PostDataManager()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView.init(frame: .zero,style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
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
        
        navigationItem.rightBarButtonItems = [UIBarButtonItem(title: "Сбросить", style: .plain, target: self, action: #selector(resetSearch(_:))), UIBarButtonItem(title: "Поиск", style: .plain, target: self, action: #selector(searchAuthor(_:)))]
        
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
    
    @objc func searchAuthor(_ sender: UIButton) {
        
        let alert = UIAlertController (title: "Введите имя автора", message: nil, preferredStyle: .alert)
        alert.addTextField()
        let action = UIAlertAction(title: "Применить", style: .default, handler: {_ in
            let author = alert.textFields![0].text!
            self.postDataManager.searchPost(author: author) {
                        self.tableView.reloadData()
            }
        })
        alert.addAction(action)
        self.present(alert, animated: true)
        
    }
    
    @objc func resetSearch(_ sender: UIButton) {
        postDataManager.fetchSavedPosts()
        self.tableView.reloadData()
        
    }
    
}

extension SavedPostViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postDataManager.savedPosts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
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
    }
    
    
    func tableView(_ tableView: UITableView,
                       trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        
        let delete = UIContextualAction(style: .destructive,
                                        title: "Delete") { [weak self](action, view, completionHandler) in
            self?.postDataManager.deletePost(index: indexPath.row)
            tableView.reloadData()
            completionHandler(true)
        }
        delete.backgroundColor = .systemRed
        let configuration = UISwipeActionsConfiguration(actions: [delete])
        return configuration
        
    }
        
}


