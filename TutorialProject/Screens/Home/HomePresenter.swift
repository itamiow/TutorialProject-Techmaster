//
//  HomePresenter.swift
//  TutorialProject
//
//  Created by USER on 14/06/2023.
//

import Foundation
protocol HomePresenter {
    func getPosts()
    func loadmorePosts()
    func refreshPosts()
}
enum APIType {
    case getInit
    case refresh
    case loadmore
}
class HomePresenterImpl: HomePresenter {
    private var postRepository: PostgetRepository
    private var homeVC: HomeDisplay
    
    init(postRepository: PostgetRepository, homeVC: HomeDisplay) {
        self.postRepository = postRepository
        self.homeVC = homeVC
    }
    
    var currentPage = 1
    var isCanLoadmore = false
    
    func getPosts() {
        _getPosts(page: currentPage, apiType: .getInit)
    }
    
    func loadmorePosts() {
        guard isCanLoadmore else {
            return
        }
        isCanLoadmore = false
        currentPage += 1
        _getPosts(page: currentPage, apiType: .loadmore)
    }
    
    func refreshPosts() {
        currentPage = 1
        _getPosts(page: currentPage, apiType: .refresh)
    }
    
    private func _getPosts(page: Int, pageSize: Int = 20, apiType: APIType) {
        switch apiType {
        case .getInit:
            homeVC.showLoading(isShow: true)
        default:
            break
        }
        postRepository.postgetReposi(page: page, pageSize: pageSize) { [weak self] response in
            guard let self = self else { return }
            switch apiType {
            case .getInit:
                self.homeVC.showLoading(isShow: false)
                self.homeVC.getPosts(posts: response.results)
            case .refresh:
                self.homeVC.hideRefreshLoading()
                self.homeVC.getPosts(posts: response.results)
            case .loadmore:
                self.homeVC.loadmorePosts(posts: response.results)
            }
            self.isCanLoadmore = response.isCanLoadmore
            
        } failure: { [weak self] apiError in
            guard let self = self else { return }

            switch apiType {
            case .getInit:
                self.homeVC.showLoading(isShow: false)
                self.homeVC.getPosts(posts: [])
            case .refresh:
                self.homeVC.hideRefreshLoading()
            default:
                break
            }
            self.homeVC.callAPIFailure(errorMsg: apiError?.errorMsg ?? "Something went wrong")
        }
    }
}
