//
//  TrendingView.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 4/5/25.
//

import SwiftUI

struct TrendingPage: View {
    
    @StateObject var viewModel : CommunityViewModel
    
    var body: some View {
        ScrollView{
            LazyVStack(spacing: 0){
                let filteredPosts = viewModel.posts.sorted { $0.trend_score > $1.trend_score }
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
