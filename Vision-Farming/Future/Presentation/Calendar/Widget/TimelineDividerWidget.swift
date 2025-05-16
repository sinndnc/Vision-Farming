//
//  TimelineDividerView.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 4/17/25.
//


import SwiftUI

struct TimelineDividerWidget: View {
    
    var geo : GeometryProxy
    
    var body: some View {
        let width = geo.size.width * 0.85
        let height = geo.size.height * 0.1
        
        VStack(spacing: 0){
            ForEach(0...24,id: \.self){ index in
                ZStack{
                    Rectangle()
                        .frame(height: 1)
                        .foregroundStyle(.gray.opacity(0.2))
                }
                .id(index)
                .frame(width: width,height: height,alignment: .top)
            }
        }
    }
}

#Preview {
    GeometryReader(content: { geometry in
        TimelineDividerWidget(geo: geometry)
    })
}
