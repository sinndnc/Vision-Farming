//
//  QuickAddView.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 5/24/25.
//

import SwiftUI

struct QuickAddView: View {
    
    @State public var navigationPath : NavigationPath = NavigationPath()
    
    @StateObject public var viewModel: QuickAddViewModel
    @EnvironmentObject public var rootViewModel : RootViewModel
    
    var body: some View {
        GeometryReader { geoProxy in
            NavigationStack(path: $navigationPath){
                ScrollView(showsIndicators: false){
                    LazyVStack(alignment: .leading,spacing: 20){
                        QuickAddComponent(label: "Add Object",items: viewModel.addObject)
                        QuickAddComponent(label: "Add Document",items: viewModel.addDocument)
                        QuickAddComponent(label: "Add Income",items: viewModel.addIncome)
                        QuickAddComponent(label: "Add Expense",items: viewModel.addExpense)
                    }
                }
                .padding(.horizontal)
                .navigationTitle("Quick add")
                .navigationBarTitleDisplayMode(.inline)
                .navigationDestination(for: QuickAddRouter.self) { router in
                    switch router {
                    case .crop:
                        let cropViewModel = CropViewModel(rootViewModel: rootViewModel)
                        CropAddView(viewModel: cropViewModel)
                    case .farm:
                        FarmAddView()
                    case .field:
                        FieldAddView(farms: viewModel.farms)
                    case .sensor:
                        SensorAddView(farms: viewModel.farms,fields:viewModel.fields)
                    default:
                        Text("No Found")
                    }
                }
            }
        }
    }
}
