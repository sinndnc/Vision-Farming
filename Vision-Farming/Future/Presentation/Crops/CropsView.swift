//
//  MyCropsView.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 4/9/25.
//

import SwiftUI

struct CropsView: View {
    
    @StateObject var viewModel : CropViewModel
    
    var body: some View {
        List{
            ForEach(viewModel.crops,id: \.self) { crop in
                Section{
                    NavigationLink{
                        CropDetailView(crop:crop)
                    }label:{
                        HStack{
                            if let data = crop.image,
                               let uiImage = UIImage(data: data) {
                                Image(uiImage: uiImage)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width:50,height:50)
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                            }else{
                                ProgressView()
                                    .frame(width:50,height:50)
                            }
                           
                            VStack(alignment:.leading){
                                HStack{
                                    Text(crop.name)
                                        .fontWeight(.medium)
                                    Spacer()
                                    Text("20% Completed")
                                        .font(.subheadline)
                                        .fontWeight(.medium)
                                        .foregroundStyle(.gray)
                                }
                                ProgressView(value: 0.2)
                                    .frame(height:5)
                            }
                        }
                    }
                }
            }
        }
        .navigationTitle("Crops")
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                NavigationLink {
                    CropAddView(viewModel: viewModel)
                }label: {
                    Image(systemName: "plus")
                }
            }
        }
    }
}
