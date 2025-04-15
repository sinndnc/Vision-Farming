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
                ForEach(viewModel.myPosts ,id:\.self) { post in
                    PostComponent(post: post)
                        .id(post.id)
                        .padding(5)
                }
            }
        }
        .padding(.horizontal,10)
    }
    
}

#Preview {
    FollowingPage(viewModel: CommunityViewModel())
}
