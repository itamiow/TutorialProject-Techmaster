//
//  PinPostViewController.swift
//  PostsApp
//
//  Created by Hà Văn Đức on 25/05/2023.
//

import UIKit
import MBProgressHUD

protocol PinPostDisplay {
    func getPosts(posts: [PostGetEntity])
    func loadmorePosts(posts: [PostGetEntity])
    func callAPIFailure(errorMsg: String?)
    func showLoading(isShow: Bool)
    func hideRefreshLoading()
}


class PinPostViewController: UIViewController {
    
    @IBOutlet weak var myTableview: UITableView!
    
    
    private var posts: [PostGetEntity]?
    
    private var presenter: PinPostPresenter!
    private var refresher = UIRefreshControl()
        
    override func viewDidLoad() {
        let service = PinPostAPIServiceImpl()
        let repo = PinPostRepositoryImpl(apiService: service)
        presenter = PinPostPresenterImpl(repository: repo, pinPostVC: self)
        super.viewDidLoad()
        setupTableView()
        
        presenter.getPosts()
    }
    
    private func setupTableView() {
        myTableview.delegate = self
        myTableview.dataSource = self
        myTableview.tableFooterView = UIView()
        myTableview.separatorStyle = .none
        myTableview.register(UINib(nibName: "PinPostTableViewCell", bundle: nil), forCellReuseIdentifier: "PinPostTableViewCell")
        myTableview.refreshControl = refresher
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

extension PinPostViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PinPostTableViewCell", for: indexPath) as! PinPostTableViewCell
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

extension PinPostViewController: PinPostDisplay {
    func getPosts(posts: [PostGetEntity]) {
        if posts.isEmpty {
            let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: myTableview.bounds.size.width, height: myTableview.bounds.size.height))
            messageLabel.text = "No data"
            messageLabel.textColor = .black
            messageLabel.numberOfLines = 0;
            messageLabel.textAlignment = .center;
            messageLabel.font = UIFont.systemFont(ofSize: 14.0, weight: .medium)
            messageLabel.sizeToFit()
            myTableview.backgroundView = messageLabel
        } else {
            myTableview.backgroundView = nil
        }
        self.posts = posts
        myTableview.reloadData()
    }
    
    func loadmorePosts(posts: [PostGetEntity]) {
        self.posts?.append(contentsOf: posts)
        myTableview.reloadData()
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

extension PinPostViewController: UITableViewDelegate {
    
}
