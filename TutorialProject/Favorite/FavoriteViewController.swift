//
//  FavoriteViewController.swift
//  PostsApp
//
//  Created by Hà Văn Đức on 25/05/2023.
//

import UIKit
import MBProgressHUD

protocol FavoriteDisplay {
    func getPosts(posts: [PostGetEntity])
    func loadmorePosts(posts: [PostGetEntity])
    func callAPIFailure(errorMsg: String?)
    func showLoading(isShow: Bool)
    func hideRefreshLoading()
}


class FavoriteViewController: UIViewController {
    
    @IBOutlet weak var myTableView: UITableView!
    
    private var posts: [PostGetEntity]?
    
    private var presenter: FavoritePresenter!
    private var refresher = UIRefreshControl()
        
    override func viewDidLoad() {
        let service = FavoritePostAPIServiceImpl()
        let repo = FavoritePostRepositoryImpl(apiService: service)
        presenter = FavoritePresenterImpl(repository: repo, favoriteVC: self)
        super.viewDidLoad()
        setupTableView()
        
        presenter.getPosts()
    }
    
    private func setupTableView() {
        myTableView.delegate = self
        myTableView.dataSource = self
        myTableView.tableFooterView = UIView()
        myTableView.separatorStyle = .none
        myTableView.register(UINib(nibName: "FavoriteTableViewCell", bundle: nil), forCellReuseIdentifier: "FavoriteTableViewCell")
        myTableView.refreshControl = refresher
        refresher.addTarget(self, action: #selector(onRefresh), for: .valueChanged)
    }
    
    @objc func onRefresh() {
        presenter.refreshPosts()
    }

 
    private func routeToAuthNavigation() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "LoginViewController")
        guard let window = (UIApplication.shared.delegate as? AppDelegate)?.window else { return}
        let nav = UINavigationController(rootViewController: vc)
        nav.setNavigationBarHidden(true, animated: true)
        window.rootViewController = nav
        window.makeKeyAndVisible()
    }
}

extension FavoriteViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteTableViewCell", for: indexPath) as! FavoriteTableViewCell
        let post = posts![indexPath.row]
        cell.bindData(post: post)
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let posts = posts else {
            return
        }
        if indexPath.row == posts.count - 1 {
            self.presenter.loadmorePosts()
        }
    }
}

extension FavoriteViewController: FavoriteDisplay {
    func getPosts(posts: [PostGetEntity]) {
        if posts.isEmpty {
            let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: myTableView.bounds.size.width, height: myTableView.bounds.size.height))
            messageLabel.text = "No data"
            messageLabel.textColor = .black
            messageLabel.numberOfLines = 0;
            messageLabel.textAlignment = .center;
            messageLabel.font = UIFont.systemFont(ofSize: 14.0, weight: .medium)
            messageLabel.sizeToFit()
            myTableView.backgroundView = messageLabel
        } else {
            myTableView.backgroundView = nil
        }
        self.posts = posts
        myTableView.reloadData()
    }
    
    func loadmorePosts(posts: [PostGetEntity]) {
        self.posts?.append(contentsOf: posts)
        myTableView.reloadData()
    }
    
    func callAPIFailure(errorMsg: String?) {
        let alert = UIAlertController(title: "Get posts failure", message: errorMsg ?? "Something went wrong", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true)
    }
    
    func showLoading(isShow: Bool) {
        if isShow {
            MBProgressHUD.showAdded(to: self.view, animated: true)
        } else {
            MBProgressHUD.hide(for: self.view, animated: true)
        }
    }
    
    func hideRefreshLoading() {
        refresher.endRefreshing()
    }
}

extension FavoriteViewController: UITableViewDelegate {
    
}
