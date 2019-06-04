//
//  RedditModel.swift
//  RedditTop
//
//  Created by Sergey Khliustin on 4/11/19.
//  Copyright © 2019 Sergey Khliustin. All rights reserved.
//

import Foundation
import UIKit

fileprivate enum DataKey: String, CodingKey {
    case data
}

fileprivate enum ChildrenKey: String, CodingKey {
    case children
}

fileprivate enum PostKeys: String, CodingKey {
    case title
    case thumbnail
    case name
    case subreddit_name_prefixed
    case url
    case permalink
    case num_comments
    case author
    case created_utc
}

fileprivate let shareURLPrefix = "https://www.reddit.com"

struct RedditListing: Decodable {
    let posts: [RedditPost]
    
    init(from decoder: Decoder) throws {
        let container = try decoder
            .container(keyedBy: DataKey.self).nestedContainer(keyedBy: ChildrenKey.self, forKey: .data)
        posts = try container.decode([RedditPost].self, forKey: .children)
    }
}

struct RedditPost: Decodable, Hashable {
    let title: String
    let thumbnail: URL?
    let name: String
    let subreddit_name_prefixed: String
    let url: URL
    let permalink: String
    let num_comments: Int
    let author: String
    let created_utc: TimeInterval
    
    let shareURL: URL?
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: DataKey.self).nestedContainer(keyedBy: PostKeys.self, forKey: .data)
        title = try container.decode(String.self, forKey: .title)
        name = try container.decode(String.self, forKey: .name)
        subreddit_name_prefixed = try container.decode(String.self, forKey: .subreddit_name_prefixed)
        url = try container.decode(URL.self, forKey: .url)
        permalink = try container.decode(String.self, forKey: .permalink)
        num_comments = try container.decode(Int.self, forKey: .num_comments)
        author = try container.decode(String.self, forKey: .author)
        created_utc = try container.decode(TimeInterval.self, forKey: .created_utc)
        
        let thumbnail = try container.decode(URL.self, forKey: .thumbnail)
        if thumbnail.scheme != nil {
            self.thumbnail = thumbnail
        }
        else {
            self.thumbnail = nil
        }
        
        self.shareURL = URL(string: shareURLPrefix + self.permalink)
    }
    
    func hash(into hasher: inout Hasher) {
        self.permalink.hash(into: &hasher)
    }
}
