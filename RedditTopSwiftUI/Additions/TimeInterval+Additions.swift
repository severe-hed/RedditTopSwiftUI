//
//  TimeInterval+Additions.swift
//  RedditTop
//
//  Created by Sergey Khliustin on 4/11/19.
//  Copyright © 2019 Sergey Khliustin. All rights reserved.
//

import Foundation

extension TimeInterval {
    func hoursAgoSinceNow() -> String {
        let now = Date().timeIntervalSince1970
        let diff = now - self
        let hours = diff / 3600
        if hours < 1 {
            return "less than an hour ago"
        }
        else if hours < 2 {
            return "1 hour ago"
        }
        else {
            return "\(Int(hours)) hours ago"
        }
    }
}
