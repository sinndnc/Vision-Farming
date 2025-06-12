//
//  TimelineHeaderView.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 4/17/25.
//


import SwiftUI

struct TimelineHeaderComponent: View {
    
    var geo : GeometryProxy
    @StateObject var viewModel : CalendarViewModel

    var body: some View {
        let width = geo.size.width * 0.14
        let height = geo.size.height * 0.1

        ScrollViewReader{ proxy in
            ScrollView(.horizontal,showsIndicators: false){
                HStack{
                    ForEach(1...30,id: \.self){ day in
                        let currentDay = 18
                        let name = "Thu"
                        let textColor : Color = viewModel.selectedHeaderDay == day ? .white : day == currentDay ? .white : .gray
                        let background : Color? = viewModel.selectedHeaderDay == day ? .blue : day == currentDay ? .blue.opacity(0.2) : nil

                        Button {
                            viewModel.selectedHeaderDay = day
                        } label: {
                            VStack(spacing: 10){
                                Text(String(name))
                                    .font(.callout)
                                    .foregroundStyle(textColor)
                                Text(String(day))
                                    .font(.callout)
                                    .fontWeight(.bold)
                                    .foregroundStyle(textColor)
                            }
                        }
                        .id(day)
                        .frame(width: width,height: height)
                        .background(background)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                }
                Divider()
            }
            .onAppear{
                proxy.scrollTo(viewModel.selectedHeaderDay ,anchor: .center)
            }
        }
    }
}

#Preview {
    GeometryReader(content: { geometry in
        TimelineHeaderComponent(
            geo: geometry,
            viewModel: CalendarViewModel(
            rootViewModel: RootViewModel(
                    loader: MockService().mockLoader()
                )
            )
        )
    })
}
