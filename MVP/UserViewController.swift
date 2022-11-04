//
//  ViewController.swift
//  MVP
//
//  Created by Nathaniel Whittington on 11/3/22.
//

import UIKit

class UserViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UserPresenterDelegate {
  
    

    var customTableView: UITableView = {
    var customTV = UITableView()
        customTV.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return customTV
    }()
    private let presenter = UserPresenter()
    private var posts = [Posts]()
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Posts"
        
        //TableView
        view.addSubview(customTableView)
        customTableView.delegate = self
        customTableView.dataSource = self
        
        //Presenter
        presenter.setViewDelegate(delegate: self)
        presenter.getData()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        customTableView.frame = view.bounds
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = posts[indexPath.row].title
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        presenter.didTap(post: posts[indexPath.row])
    }
    
    func presentPosts(posts: [Posts]) {
        self.posts = posts
        DispatchQueue.main.async {
            self.customTableView.reloadData()
        }
    }
    
    public func presentAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "dimiss", style: .cancel, handler: nil))
        present(alert, animated: true)
    }
    
    
    
}

