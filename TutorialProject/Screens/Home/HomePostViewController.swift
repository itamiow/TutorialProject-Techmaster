//
//  HomePostViewController.swift
//  TutorialProject
//
//  Created by USER on 14/06/2023.
//

import UIKit
import MBProgressHUD
import Alamofire

protocol HomeDisplay {
    func getPosts(posts: [PostGetEntity])
    func loadmorePosts(posts: [PostGetEntity])
    func callAPIFailure(errorMsg: String?)
    func showLoading(isShow: Bool)
    func hideRefreshLoading()
}

class HomePostViewController: UIViewController {

    @IBOutlet weak var homeTableView: UITableView!
    private var posts: [PostGetEntity]?

    private var presenter: HomePresenter!
    private var refresher = UIRefreshControl()

    private var cacheImages = [String: UIImage]()

    override func viewDidLoad() {
        let service = PostGetAPISerivceImpl()
        let repo = PostRepositoryImpl(postAPISevece: service)
        presenter = HomePresenterImpl(postRepository: repo, homeVC: self)
        super.viewDidLoad()
        setupTableView()

        presenter.getPosts()
    }

    private func setupTableView() {
        homeTableView.delegate = self
        homeTableView.dataSource = self
        homeTableView.tableFooterView = UIView()
        homeTableView.separatorStyle = .none
        homeTableView.register(UINib(nibName: "HomeTableViewCell", bundle: nil), forCellReuseIdentifier: "HomeTableViewCell")
        homeTableView.refreshControl = refresher
        refresher.addTarget(self, action: #selector(onRefresh), for: .valueChanged)
        homeTableView.reloadData()
    }

    @objc func onRefresh() {
        presenter.refreshPosts()
    }

    @IBAction func handleButtonAction(_ sender: UIButton) {
        AuthService.share.clearAll()
        UserDefaultService.shared.clearAll()
        routeToAuthNavigation()
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

    private func loadImage(link: String, completed: ((UIImage?) -> Void)?) {
        AF.download(link).responseData { [weak self] response in
            guard let self = self else { return }
            if let data = response.value {
                let image = UIImage(data: data)
                self.cacheImages[link] = image
                completed?(image)
            }
        }
    }
}

extension HomePostViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell", for: indexPath) as! HomeTableViewCell
        let post = posts![indexPath.row]
        if let user = post.author, let avatarImg = user.profile.avatar {
            if let imgCached = cacheImages[avatarImg] {
                cell.authorAvatar(image: imgCached)
            } else {
                loadImage(link: avatarImg) { image in
                    cell.authorAvatar(image: image)
                }
            }
        } else {
            cell.authorAvatar(image: nil)
        }

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

extension HomePostViewController: HomeDisplay {
    func getPosts(posts: [PostGetEntity]) {
        if posts.isEmpty {
            let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: homeTableView.bounds.size.width, height: homeTableView.bounds.size.height))
            messageLabel.text = "No data"
            messageLabel.textColor = .black
            messageLabel.numberOfLines = 0;
            messageLabel.textAlignment = .center;
            messageLabel.font = UIFont.systemFont(ofSize: 14.0, weight: .medium)
            messageLabel.sizeToFit()
            homeTableView.backgroundView = messageLabel
        } else {
            homeTableView.backgroundView = nil
        }
        self.posts = posts
        homeTableView.reloadData()
    }

    func loadmorePosts(posts: [PostGetEntity]) {
        self.posts?.append(contentsOf: posts)
        homeTableView.reloadData()
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

extension HomePostViewController: UITableViewDelegate {

}
