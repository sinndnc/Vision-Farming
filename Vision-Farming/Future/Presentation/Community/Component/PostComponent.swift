//
//  PostView.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 3/25/25.
//

import SwiftUI

struct PostComponent: View {
    
    let post : Post
    
    var body: some View {
        VStack(spacing: 15){
            HStack{
                Image(systemName: "")
                    .frame(width: 50,height: 50)
                    .background(.green)
                    .clipShape(Circle())
                VStack(alignment: .leading){
                    Text(post.author_name)
                        .fontWeight(.medium)
                    HStack{
                        Text("Posted at:")
                            .font(.footnote)
                            .foregroundStyle(.gray)
                        Text(post.created_at ?? .now,style:.date)
                            .font(.footnote)
                            .foregroundStyle(.gray)
                    }
                }
                Spacer()
                Image(systemName:"ellipsis")
            }
            Text(post.content)
                .font(.callout)
            
            HStack(spacing:20){
                HStack(spacing: 3){
                    Image(systemName: "eye.fill")
                        .font(.subheadline)
                        .foregroundStyle(.gray)
                    Text("\(post.likes_count)")
                        .font(.footnote)
                        .fontWeight(.medium)
                }
                HStack(spacing: 3){
                    Image(systemName: "heart.fill")
                        .font(.subheadline)
                        .foregroundStyle(.gray)
                    Text("\(post.comments_count)")
                        .font(.footnote)
                        .fontWeight(.medium)
                }
                Spacer()
            }
        }
        .padding()
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 15))
    }
}

#Preview {
    PostComponent(
        post: Post(
            title: "",
            content: "",
            author_id: "",
            author_name: "",
            tags: [""],
            likes_count: 1,
            comments_count: 1,
        )
    )
}
