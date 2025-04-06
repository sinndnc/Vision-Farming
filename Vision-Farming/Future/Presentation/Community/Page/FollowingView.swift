//
//  Following.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 4/5/25.
//

import SwiftUI

struct FollowingView: View {
    var body: some View {
        ScrollView{
            LazyVStack(spacing: 0){
                ForEach(1...7,id:\.self) { id in
                    PostView()
                        .id(id)
                        .padding(5)
                }
            }
        }
        .padding(.horizontal,10)
    }
}

#Preview {
    FollowingView()
}
