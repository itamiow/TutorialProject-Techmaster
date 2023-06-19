//
//  PinPostPresenter.swift
//  PostsApp
//
//  Created by Hà Văn Đức on 25/05/2023.
//

import Foundation

protocol PinPostPresenter {
    func getPosts()
    func loadmorePosts()
    func refreshPosts()
}

class PinPostPresenterImpl: PinPostPresenter {
    private var repository: PinPostRepository
    private var pinPostVC: PinPostDisplay
    
    init(repository: PinPostRepository, pinPostVC: PinPostDisplay) {
        self.repository = repository
        self.pinPostVC = pinPostVC
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
            pinPostVC.showLoading(isShow: true)
        default:
            break
        }
        repository.index(page: page, pageSize: pageSize) { [weak self] response in
            guard let self = self else { return }
            switch apiType {
            case .getInit:
                self.pinPostVC.showLoading(isShow: false)
                self.pinPostVC.getPosts(posts: response.results)
            case .refresh:
                self.pinPostVC.hideRefreshLoading()
                self.pinPostVC.getPosts(posts: response.results)
            case .loadmore:
                self.pinPostVC.loadmorePosts(posts: response.results)
            }
            self.isCanLoadmore = response.isCanLoadmore
            
        } failure: { [weak self] apiError in
            guard let self = self else { return }

            switch apiType {
            case .getInit:
                self.pinPostVC.showLoading(isShow: false)
                self.pinPostVC.getPosts(posts: [])
            case .refresh:
                self.pinPostVC.hideRefreshLoading()
            default:
                break
            }
            self.pinPostVC.callAPIFailure(errorMsg: apiError?.errorMsg ?? "Something went wrong")
        }
    }
}
