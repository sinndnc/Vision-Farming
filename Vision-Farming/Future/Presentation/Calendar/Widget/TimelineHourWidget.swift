//
//  TimelineHourView.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 4/17/25.
//


import SwiftUI

struct TimelineHourView: View {
    
    var geo : GeometryProxy
    
    var body: some View {
        let width = geo.size.width * 0.15
        let height = geo.size.height * 0.1
        
        VStack(spacing: 0){
            ForEach(0...24,id: \.self){ index in
                HStack(alignment: .top,spacing:0){
                    Text("\(index):00")
                        .font(.footnote)
                        .padding(.horizontal,10)
                        .frame(width: width,alignment: .leading)
                    Divider()
                }
                .padding(.vertical,-8)
                .frame(width: width,height: height)
            }
        }
    }
}

#Preview {
    GeometryReader(content: { geometry in
        TimelineHourView(geo: geometry)
//        TimelineNowDividerView(geo: geometry)
    })
}
