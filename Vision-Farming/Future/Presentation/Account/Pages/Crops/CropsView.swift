//
//  MyCropsView.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 4/9/25.
//

import SwiftUI

struct CropsView: View {
    
    @StateObject var viewModel : AccountViewModel
    
    var body: some View {
        List{
            ForEach(viewModel.crops,id: \.self) { crop in
                Section{
                    NavigationLink{
                        CropDetailView(crop:crop)
                    }label:{
                        HStack{
                            Image(systemName: "test")
                                .frame(width:50,height:50)
                                .background(.black)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
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
    }
}

#Preview {
    CropsView(viewModel: AccountViewModel())
}
