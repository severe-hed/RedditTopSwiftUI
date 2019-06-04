//
//  MainPresenter.swift
//  RedditTop
//
//  Created by Sergey Khliustin on 4/11/19.
//  Copyright © 2019 Sergey Khliustin. All rights reserved.
//

import Foundation

protocol MainPresenterProtocol {
    func saveState(_ index: Int)
    func restoreState()
    func reload()
    func loadMore()
    var posts: [RedditPost] { get }
}

final class MainPresenter: MainPresenterProtocol {
    weak var controller: MainControllerProtocol?
    
    private(set) var posts: [RedditPost] = []
    private var isLoading: Bool = false
    
    init(controller: MainControllerProtocol) {
        self.controller = controller
    }
    
    func saveState(_ index: Int) {
        UserDefaults.standard.setValue(self.posts[index].name, forKey: "lastViewedPost")
        UserDefaults.standard.synchronize()
    }
    
    func restoreState() {
        if isLoading { return }
        isLoading = true
        let after: String? = UserDefaults.standard.string(forKey: "lastViewedPost")
        RedditApiManager.shared.fetchTop(limit: 25, after: after) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let posts):
                    self.posts = posts
                    self.controller?.reloadData()
                case .failure(let error):
                    self.controller?.showError(error)
                }
            }
            self.isLoading = false
        }
    }
    
    func reload() {
        if isLoading { return }
        isLoading = true
        RedditApiManager.shared.fetchTop(limit: 25, after: nil, reloadCache: true) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let posts):
                    self.posts = posts
                    self.controller?.reloadData()
                case .failure(let error):
                    self.controller?.showError(error)
                }
            }
            self.isLoading = false
        }
    }
    
    func loadMore() {
        guard let last = self.posts.last else {
            return
        }
        if isLoading { return }
        isLoading = true
        RedditApiManager.shared.fetchTop(limit: 25, after: last.name) { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let posts):
                    self.posts.append(contentsOf: posts)
                    self.controller?.appendData(count: posts.count)
                case .failure(let error):
                    self.controller?.showError(error)
                }
            }
            self.isLoading = false
        }
    }
}
