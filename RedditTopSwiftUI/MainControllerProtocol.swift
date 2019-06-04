//
//  MainControllerProtocol.swift
//  RedditTop
//
//  Created by Sergey Khliustin on 4/11/19.
//  Copyright © 2019 Sergey Khliustin. All rights reserved.
//

import UIKit

protocol MainControllerProtocol: class {
    func reloadData()
    func appendData(count: Int)
    func showError(_ error: NSError)
}
