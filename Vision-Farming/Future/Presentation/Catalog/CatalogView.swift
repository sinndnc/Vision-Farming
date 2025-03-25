//
//  CatalogView.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 3/18/25.
//

import Foundation
import SwiftUI

struct CatalogView: View {
    
    @StateObject var viewModel = CatalogViewModel()
    @EnvironmentObject var rootViewModel: RootViewModel

    var body: some View {
        NavigationStack(path: $rootViewModel.navigationPath) {
            List(viewModel.categories) { category in
                NavigationLink(destination: SubcategoriesView(category: category)) {
                    VStack(alignment:.leading){
                        Text("\(category.category_name)")
                            .font(.title3)
                            .fontWeight(.semibold)
                        Text("\(category.category_description)")
                            .font(.footnote)
                            .lineLimit(3)
                    }
                }
                
            }
            .toolbar{toolbarContent}
            .navigationTitle("Categories")
            .onAppear { viewModel.fetchPlants() }
            .navigationDestination(for: String.self) { value in
                if value == "ItemDetail" {
                    if let item = rootViewModel.selectedData {
                        ItemDetailsView(item: item)
                    } else {
                        ProgressView()
                    }
                }
            }
        }
    }
    
    struct SubcategoriesView: View {
        let category : Category
        @StateObject var viewModel = CatalogViewModel()
        
        var body: some View {
            List(viewModel.subCategories) { subcategory in
                NavigationLink(destination: PlantsView(category: category, subCategory: subcategory)) {
                    VStack(alignment: .leading){
                        Text(subcategory.name)
                            .font(.headline)
                        Text(subcategory.description)
                            .font(.footnote)
                            .lineLimit(3)
                    }
                }
            }
            .navigationTitle(category.category_name)
            .onAppear{
                viewModel.fetchSubcategories(category: category)
            }
        }
    }
    
    
    struct PlantsView: View {
        let category: Category
        let subCategory: SubCategory
        @StateObject var viewModel = CatalogViewModel()
        
        var body: some View {
            List(viewModel.categoryItems,id:\.self) { item in
                NavigationLink(destination: { ItemDetailsView(item: item) } ) {
                    VStack(alignment: .leading){
                        Text(item.name)
                            .font(.headline)
                        Text(item.description)
                            .font(.footnote)
                            .lineLimit(3)
                    }
                }
            }
            .navigationTitle(subCategory.name)
            .onAppear {
                viewModel.fetchSubCategoryItems(category: category, subCategory: subCategory)
            }
        }
    }
    
    struct ItemDetailsView: View {
        let item : CategoryItem
        
        var body: some View {
            List {
                Section("İklim Bilgisi") {
                    Text("Min. Sıcaklık: \(item.climate.min_temp)°C")
                    Text("Max. Sıcaklık: \(item.climate.max_temp)°C")
                    Text("Hassasiyet:\n\(item.climate.sensitivity)")
                    Text(item.climate.description)
                }
                .headerProminence(.increased)
                Section( "Sulama Bilgisi") {
                    Text("Frekans: \(item.watering.frequency)")
                    Text(item.watering.description)
                }
                .headerProminence(.increased)
                Section("Toprak Gereksinimleri") {
                    Text("pH: \(item.soil_requirements.pH)")
                    Text("Tip: \(item.soil_requirements.type)")
                    Text("Organik Madde: \(item.soil_requirements.organic_matter)")
                }
                .headerProminence(.increased)
                Section("Gübreleme") {
                    Text("Tip: \(item.fertilization.type)")
                    Text("Önerilenler: \(item.fertilization.recommended.joined(separator: ", "))")
                }
                .headerProminence(.increased)
                Section("Hasat Bilgisi") {
                    Text("Yöntem: \(item.harvesting.method)")
                    Text("Dönem: \(item.harvesting.best_period)")
                }
                .headerProminence(.increased)
            }
            .navigationTitle(item.name)
        }
    }
    
    
    @ViewBuilder
    var toolbarContent : some View {
        Button {
            
        } label: {
            Image(systemName: "line.3.horizontal.decrease.circle")
        }
    }
}


#Preview {
    CatalogView()
}
