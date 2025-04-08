//
//  Following.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 4/5/25.
//

import SwiftUI

struct FollowingPage: View {
    var body: some View {
        ScrollView{
            LazyVStack(spacing: 0){
                ForEach(1...7,id:\.self) { id in
                    PostComponent(post: Post(
                        title: "",
                        content: "",
                        authorId: "",
                        authorName: "",
                        category: "",
                        tags: [""],
                        likesCount: 1,
                        commentsCount: 1,
                        isPublished: true,
                        visibility: ""
                        )
                    )
                    .id(id)
                    .padding(5)
                }
            }
        }
        .padding(.horizontal,10)
    }
}

#Preview {
    FollowingPage()
}
