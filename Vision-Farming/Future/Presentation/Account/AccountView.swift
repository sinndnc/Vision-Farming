//
//  AccountView.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 1/14/25.
//

import MapKit
import SwiftUI
import PhotosUI

struct AccountView: View {
    
    @State private var selectedItem: PhotosPickerItem? = nil
    @StateObject public var viewModel : AccountViewModel
    
    var body: some View{
        NavigationStack(path: $viewModel.accNavigationPath){
            List{
                Section{
                    NavigationLink{
                        ProfileView()
                    }label:{
                        HStack{
                            if let user = viewModel.user,
                               let image = user.image,
                               let uiImage = UIImage(data: image)
                            {
                                Image(uiImage: uiImage)
                                    .resizable()
                                    .scaledToFit()
                                    .clipShape(Circle())
                                    .frame(width: 50, height: 50)
                            }
                            else{
                                ProgressView()
                                    .frame(width: 50, height: 50)
                            }
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
            .navigationDestination(for: SectionEnum.self) { type in
                switch type {
                case .myCrops:
                    CropsView()
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

