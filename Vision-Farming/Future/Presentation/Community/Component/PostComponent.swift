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
                Image(systemName: "house")
                    .resizable()
                    .frame(width: 50,height: 50)
                    .background(.green)
                    .clipShape(Circle())
                VStack(alignment: .leading){
                    Text("Sinan Dinç")
                        .fontWeight(.medium)
                    Text("Posted 3m ago")
                        .font(.footnote)
                        .foregroundStyle(.gray)
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
                    Text("5.768K")
                        .font(.footnote)
                        .fontWeight(.medium)
                }
                HStack(spacing: 3){
                    Image(systemName: "heart.fill")
                        .font(.subheadline)
                        .foregroundStyle(.gray)
                    Text("258")
                        .font(.footnote)
                        .fontWeight(.medium)
                }
                Spacer()
                HStack{
                    Image(systemName: "archivebox.fill")
                        .foregroundStyle(.gray)
                    Text("Saved")
                        .font(.subheadline)
                        .fontWeight(.medium)
                }
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
}
