//
//  MainViewData.swift
//  RedditTop
//
//  Created by Sergey Khliustin on 6/4/19.
//  Copyright © 2019 Sergey Khliustin. All rights reserved.
//

import Combine
import SwiftUI

final class MainViewData: BindableObject, MainControllerProtocol {
    func reloadData() {
        posts = presenter.posts
    }
    
    func appendData(count: Int) {
        posts = presenter.posts
    }
    
    func showError(_ error: NSError) {
        print(error)
    }
    
    let didChange = PassthroughSubject<MainViewData, Never>()
    var posts: [RedditPost] = [RedditPost]() {
        didSet {
            self.didChange.send(self)
            
        }
    }
    
    var presenter: MainPresenterProtocol!
    
    init() {
        presenter = MainPresenter(controller: self)
        presenter.restoreState()
    }
    
    
}
