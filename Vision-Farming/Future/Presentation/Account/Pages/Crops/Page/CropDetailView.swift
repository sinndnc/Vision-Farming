//
//  CropDetailView.swift
//  Vision-Farming
//
//  Created by Sinan Dinç on 4/13/25.
//

import SwiftUI

struct CropDetailView: View {
    
    let crop : Crop
    
    var body: some View {
        List {
            Section{
                HStack{
                    Text("Name:")
                        .font(.subheadline)
                    Text(crop.name)
                        .font(.subheadline)
                        .fontWeight(.medium)
                }
                HStack(alignment:.top){
                    Text("Notes:")
                        .font(.subheadline)
                    Text(crop.notes)
                        .font(.subheadline)
                        .fontWeight(.medium)
                }
            }header: {
                Text("General Information")
            }
            
            Section{
                HStack{
                    Text("Planted Date:")
                        .font(.subheadline)
                    Text(crop.planted_date,style:.date)
                        .font(.subheadline)
                        .fontWeight(.medium)
                }
                HStack{
                    Text("Expected Harvest Date:")
                        .font(.subheadline)
                    Text(crop.expected_harvest_date,style:.date)
                        .font(.subheadline)
                        .fontWeight(.medium)
                }
            }header: {
                Text("Planting and Harvesting")
                
            }
            
            Section{
//                ForEach(crop.actions,id:\.self){ action in
//                    HStack {
//                        Text("Type:")
//                            .font(.subheadline)
//                        Text(action.type)
//                            .font(.subheadline)
//                            .fontWeight(.medium)
//                    }
//                    HStack {
//                        Text("Note:")
//                            .font(.subheadline)
//                        Text(action.note)
//                            .font(.subheadline)
//                            .fontWeight(.medium)
//                    }
//                    HStack {
//                        Text("Date:")
//                            .font(.subheadline)
//                        Text(action.date,style: .date)
//                            .font(.subheadline)
//                            .fontWeight(.medium)
//                    }
//                }
            }header: {
                Text("Last Actions")
            }
            
        }
        .navigationTitle(crop.name)
    }
}
