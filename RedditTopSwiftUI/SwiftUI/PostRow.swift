//
//  PostRow.swift
//  RedditTop
//
//  Created by Sergey Khliustin on 6/4/19.
//  Copyright © 2019 Sergey Khliustin. All rights reserved.
//

import SwiftUI

struct PostRow : View {
    var post: RedditPost
    
    var body: some View {
        let defaultFont = Font.custom("Arial", size: 12)
        let boldFont = Font.custom("Arial Bold", size: 12)
        return VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(post.subreddit_name_prefixed)
                    .font(boldFont)
                    .color(Color(red: 28/255.0, green: 28/255.0, blue: 28/255.0))
                
                Text("Posted by u/\(post.author) \(post.created_utc.hoursAgoSinceNow())")
                    .font(defaultFont)
                    .color(Color(red: 120/255.0, green: 124/255.0, blue: 126/255.0))
            }
            HStack(alignment: .center, spacing: 8) {
                Text(post.title)
                    .font(Font.custom("Arial Bold", size: 18))
                    .lineLimit(nil)
                    .multilineTextAlignment(.leading)
                Spacer()
                if post.thumbnail != nil {
                    WrappedUIImageView(url: post.thumbnail!).frame(width: 140, height: 140, alignment: Alignment.center).fixedSize()
                }
                
            }
            HStack {
                Text("\(post.num_comments) Comments")
                    .font(boldFont)
                    .color(Color(red: 135/255.0, green: 138/255.0, blue: 140/255.0))
                Spacer()
                Button(action: {
                    
                }) {
                    Text("🔗 Share")
                        .font(boldFont)
                        .color(Color(red: 135/255.0, green: 138/255.0, blue: 140/255.0))
                }
            }
        }
//            .padding()
            .padding(EdgeInsets(top: 20, leading: 0, bottom: 20, trailing: 0))
            .background(
                RoundedRectangle(cornerRadius: 3)
                    .fill(Color.clear)
                    .border(Color.init(white: 0.7), width: 1, cornerRadius: 3)
                .padding(EdgeInsets(top: 0, leading: -18, bottom: 0, trailing: -18))
        )
        
    }
}

#if DEBUG
struct PostRow_Previews : PreviewProvider {
    static var previews: some View {
        Text("asdfasdf")
    }
}
#endif
