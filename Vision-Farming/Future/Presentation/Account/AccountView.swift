//
//  AccountView.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 1/14/25.
//

import MapKit
import SwiftUI


enum SectionType {
    case appearance
    case notifications
    case iotSensors
    case myCrops
    case myFarms
    case blockchain
    case tracking
    case cooperative
    case supplyChain
    case recommendations
    case smartAlert
    case terms
    case privacy
    case aboutUs
    case myFields
}
struct SectionItem : Identifiable {
    var id = UUID()
    var icon : String
    var title : String
    let type: SectionType
    var detail : String? = nil
}

struct AccountView: View {
    
    @StateObject private var viewModel : AccountViewModel = .init()
    
    var body: some View{
        NavigationStack(path: $viewModel.navigationPath){
            List{
                Section{
                    NavigationLink{
                    }label:{
                        HStack{
                            Image(systemName: "person.circle.fill")
                                .resizable()
                                .frame(width: 50, height: 50)
                                .foregroundColor(.green)
                            VStack(alignment:.leading) {
                                if let user = viewModel.user{
                                    Text("\(user.name) \(user.surname)")
                                        .font(.title3)
                                        .fontWeight(.semibold)
                                    Text(user.email)
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                }else{
                                    ProgressView()
                                }
                            }
                        }
                    }
                }
                
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
            .navigationTitle("Account")
            .navigationBarTitleDisplayMode(.inline)
            .navigationDestination(for: SectionType.self) { type in
                switch type {
                case .myCrops:
                    CropsView(viewModel: viewModel)
                case .myFarms:
                    FarmsView(viewModel: viewModel)
                case .myFields:
                    FieldsView(viewModel: viewModel)
                case .iotSensors:
                    SensorsView(viewModel: viewModel)
                case .appearance:
                    AppearanceView()
                case .notifications:
                    NotificationView()
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
