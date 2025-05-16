//
//  Following.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 4/5/25.
//

import SwiftUI

struct FollowingPage: View {
    
    @StateObject var viewModel : CommunityViewModel
    
    var body: some View {
        ScrollView{
            LazyVStack(spacing: 0){
                let filteredPosts = viewModel.posts.filter{ $0.is_following == true }
                ForEach(filteredPosts) { post in
                    PostComponent(post: post)
                        .id(post.id)
                        .padding(.vertical, 7)
                }
            }
        }
        .padding(.horizontal,10)
    }
    
}
