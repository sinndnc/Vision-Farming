//
//  CalendarView.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 4/9/25.
//

import SwiftUI

struct CalendarView: View {
    
    @StateObject var viewModel : CalendarViewModel
    
    var body: some View {
        NavigationStack{
            GeometryReader{geo in
                VStack(spacing:0){
                    TimelineHeaderComponent(geo: geo, viewModel:viewModel)
                    ScrollViewReader { proxy in
                        ScrollView(){
                            TimelineGraphicComponent(geo: geo, viewModel:viewModel)
                        }
                        .onAppear {
//                            if (viewModel.graphicViewUIState == .initial) {
                                proxy.scrollTo(15,anchor: .center)
//                                viewModel.graphicViewUIState = .success
//                            }
                        }
                    }
                }
            }
            .searchable(text: .constant(""))
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("December 2024")
        }
    }
}
