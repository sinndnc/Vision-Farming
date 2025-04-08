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
                ForEach(viewModel.posts,id:\.self) { post in
                    PostComponent(post: post)
                        .padding(.vertical, 7)
                        .id(post.content.hashValue)
                }
            }
        }
        .padding(.horizontal,10)
    }
}

#Preview {
    TrendingPage(viewModel: .init())
}
