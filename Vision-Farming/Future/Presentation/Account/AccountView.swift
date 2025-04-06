//
//  AccountView.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 1/14/25.
//

import MapKit
import SwiftUI


enum SectionType {
    case appearance, notifications, iotSensors, blockchain, tracking, cooperative, supplyChain, recommendations,smartAlert, terms, privacy, aboutUs
}
struct SectionItem : Identifiable {
    var id = UUID()
    var icon : String
    var title : String
    let type: SectionType
    var detail : String? = nil
}

struct AccountView: View {
    
    @StateObject private var viewModel : AccountViewModel = AccountViewModel()
    
    var body: some View{
        NavigationStack(path: $viewModel.navigationPath){
            List{
                Section{
                    VStack {
                        Image(systemName: "person.circle.fill")
                            .resizable()
                            .frame(width: 75, height: 75)
                            .foregroundColor(.green)
                        Text("Sinan Dinç")
                            .font(.title)
                            .fontWeight(.bold)
                        Text("sinandinc77@icloud.com")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        
                        Divider()
                        
                        VStack(alignment: .leading, spacing: 10) {
                            HStack {
                                Text("Çiftlik Adı:")
                                    .fontWeight(.medium)
                                Spacer()
                                Text("Yeşil Tarım Çiftliği")
                                    .font(.callout)
                            }
                            HStack {
                                Text("Konum:")
                                    .fontWeight(.medium)
                                Spacer()
                                Text("Konya, Türkiye")
                                    .font(.callout)
                            }
                            HStack {
                                Text("Üyelik Tipi:")
                                    .fontWeight(.medium)
                                Spacer()
                                Text("Premium")
                                    .font(.callout)
                                    .fontWeight(.medium)
                                    .foregroundColor(.green)
                            }
                        }
                        .padding()
                    }
                }
                .headerProminence(.increased)
                
                Section{
                    ForEach(viewModel.general) { section in
                        NavigationLink(value: section.type){
                            Label(section.title, systemImage: section.icon)
                                .font(.callout)
                                .fontWeight(.medium)
                        }
                    }
                }
                
                Section("Data"){
                    ForEach(viewModel.data) { section in
                        NavigationLink(value: section.type){
                            Label(section.title, systemImage: section.icon)
                                .font(.callout)
                                .fontWeight(.medium)
                        }
                    }
                }
                .headerProminence(.increased)
                
                Section("AI-Powered"){
                    ForEach(viewModel.ai) { section in
                        NavigationLink(value: section.type){
                            Label(section.title, systemImage: section.icon)
                                .font(.callout)
                                .fontWeight(.medium)
                        }
                    }
                }
                .headerProminence(.increased)
                
                Section("About Us"){
                    ForEach(viewModel.about) { section in
                        NavigationLink(value: section.type){
                            Label(section.title, systemImage: section.icon)
                                .font(.callout)
                                .fontWeight(.medium)
                        }
                    }
                }
                .headerProminence(.increased)
            }
            .navigationTitle(Text("Account"))
            .navigationBarTitleDisplayMode(.inline)
            .navigationDestination(for: SectionType.self) { type in
                switch type {
                case .notifications:
                    NotificationView()
                case .appearance:
                    AppearanceView()
                case .iotSensors:
                    SensorsView()
                case .blockchain:
                    BlockchainView()
                case .tracking:
                    TrackingView()
                case .cooperative:
                    CooperativeView()
                case .supplyChain:
                    SuppleChainView()
                case .recommendations:
                    RecommendationsView()
                case .smartAlert:
                    SmartAlertView()
                default:
                    Text("404 not found")
                }
            }
        }
    }
}


#Preview {
    AccountView()
}
