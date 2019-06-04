//
//  MainView.swift
//  RedditTop
//
//  Created by Sergey Khliustin on 6/3/19.
//  Copyright © 2019 Sergey Khliustin. All rights reserved.
//

import SwiftUI

struct MainView : View {
    
    @EnvironmentObject var userData: MainViewData
    
    //Lifecycle
    
    var body: some View {
        List {
            ForEach(userData.posts.identified(by: \.self)) {
                post in
                PostRow(post: post)
                    .onAppear {
                        if post == self.userData.posts.last {
                            self.userData.presenter.loadMore()
                            print("loadMore")
                        }
                }
            }
        }
            .navigationBarItem(title: Text("Reddit Top"))
            .navigationBarItems(trailing: Button(action: {
                self.userData.presenter.reload()
            }, label: {
                Text("Reload")
            }))
    }
}

#if DEBUG
struct MainView_Previews : PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
#endif
