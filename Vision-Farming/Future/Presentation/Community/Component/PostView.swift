//
//  PostView.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 3/25/25.
//

import SwiftUI

struct PostView: View {
    var body: some View {
        VStack(spacing: 15){
            HStack{
                Image(systemName: "world")
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
            Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries")
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
    PostView()
}
