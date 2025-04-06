//
//  ForYouView.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 4/5/25.
//

import SwiftUI

struct ForYouView: View {
    
    var body: some View {
        ScrollView{
            LazyVStack(spacing: 0){
                ForEach(1...3,id:\.self) { id in
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
    ForYouView()
}
