//
//  TrendingView.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 4/5/25.
//

import SwiftUI

struct TrendingView: View {
    var body: some View {
        ScrollView{
            LazyVStack(spacing: 0){
                ForEach(1...5,id:\.self) { id in
                    PostView()
                        .id(id)
                        .padding(.vertical, 7)
                }
            }
        }
        .padding(.horizontal,10)
    }
}

#Preview {
    TrendingView()
}
